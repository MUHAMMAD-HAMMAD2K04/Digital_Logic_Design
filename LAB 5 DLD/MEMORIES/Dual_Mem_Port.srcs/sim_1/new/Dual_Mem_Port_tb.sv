`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 11:20:05 PM
// Design Name: 
// Module Name: Dual_Mem_Port_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for Dual Port Memory
// 
// Dependencies: Dual_Mem_Port.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Dual_Mem_Port_tb;

    // ========================================================================
    // PARAMETERS
    // ========================================================================
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;
    
    parameter CLK_L_PERIOD = 10;  // 100 MHz
    parameter CLK_R_PERIOD = 14;  // ~71 MHz

    // ========================================================================
    // CLOCK GENERATION
    // ========================================================================
    logic clk_l = 0;
    logic clk_r = 0;
    
    always #(CLK_L_PERIOD/2) clk_l = ~clk_l;
    always #(CLK_R_PERIOD/2) clk_r = ~clk_r;

    // ========================================================================
    // LEFT PORT SIGNALS
    // ========================================================================
    logic                    rst_l;
    logic                    ce0_l;
    logic                    ce1_l;
    logic                    rw_l;
    logic                    oe_l;
    logic                    mode_l;
    logic [ADDR_WIDTH-1:0]   addr_l;
    wire  [DATA_WIDTH-1:0]   data_l;
    logic [DATA_WIDTH-1:0]   drv_l;

    // ========================================================================
    // RIGHT PORT SIGNALS
    // ========================================================================
    logic                    rst_r;
    logic                    ce0_r;
    logic                    ce1_r;
    logic                    rw_r;
    logic                    oe_r;
    logic                    mode_r;
    logic [ADDR_WIDTH-1:0]   addr_r;
    wire  [DATA_WIDTH-1:0]   data_r;
    logic [DATA_WIDTH-1:0]   drv_r;

    // ========================================================================
    // BIDIRECTIONAL BUS DRIVERS
    // ========================================================================
    assign data_l = (!rw_l) ? drv_l : {DATA_WIDTH{1'bz}};
    assign data_r = (!rw_r) ? drv_r : {DATA_WIDTH{1'bz}};

    // ========================================================================
    // DUT INSTANTIATION
    // ========================================================================
    Dual_Mem_Port #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) DUT (
        .clk_l   (clk_l),
        .rst_l   (rst_l),
        .ce0_l   (ce0_l),
        .ce1_l   (ce1_l),
        .rw_l    (rw_l),
        .oe_l    (oe_l),
        .mode_l  (mode_l),
        .addr_l  (addr_l),
        .data_l  (data_l),
        
        .clk_r   (clk_r),
        .rst_r   (rst_r),
        .ce0_r   (ce0_r),
        .ce1_r   (ce1_r),
        .rw_r    (rw_r),
        .oe_r    (oe_r),
        .mode_r  (mode_r),
        .addr_r  (addr_r),
        .data_r  (data_r)
    );

    // ========================================================================
    // TEST SEQUENCE
    // ========================================================================
    initial begin
        // Initialize all signals
        init_ports();
        
        // Apply reset
        apply_reset();
        
        // Test 1: Write to left port
        test_write_left();
        
        // Test 2: Read from left port (Flow-through mode)
        test_read_left_flow();
        
        // Test 3: Read from right port (Pipeline mode)
        test_read_right_pipeline();
        
        // Test 4: Write to right port
        test_write_right();
        
        // Test 5: Read from left port (verify right write)
        test_read_left_verify();
        
        // Test 6: Simultaneous write and read
        test_simultaneous_access();
        
        // Test 7: Output disable check
        test_output_disable();
        
        // Finish simulation
        #100;
        $display("All tests completed successfully!");
        $finish;
    end

    // ========================================================================
    // TASK DEFINITIONS
    // ========================================================================
    
    task init_ports();
        begin
            rst_l  = 1'b1;
            rst_r  = 1'b1;
            ce0_l  = 1'b0;
            ce1_l  = 1'b1;
            ce0_r  = 1'b0;
            ce1_r  = 1'b1;
            rw_l   = 1'b1;
            rw_r   = 1'b1;
            oe_l   = 1'b1;
            oe_r   = 1'b1;
            mode_l = 1'b0;
            mode_r = 1'b0;
            addr_l = '0;
            addr_r = '0;
            drv_l  = '0;
            drv_r  = '0;
        end
    endtask
    
    task apply_reset();
        begin
            $display("[%0t] Applying Reset", $time);
            #(CLK_L_PERIOD * 2);
            rst_l = 1'b0;
            rst_r = 1'b0;
            #(CLK_L_PERIOD);
        end
    endtask
    
    task test_write_left();
        begin
            $display("[%0t] TEST 1: Write 0xAA to address 3 (Left Port)", $time);
            @(posedge clk_l);
            addr_l = 4'd3;
            drv_l  = 8'hAA;
            rw_l   = 1'b0;
            @(posedge clk_l);
            rw_l   = 1'b1;
            @(posedge clk_l);
        end
    endtask
    
    task test_read_left_flow();
        begin
            $display("[%0t] TEST 2: Read from address 3 (Left Port, Flow-Through)", $time);
            @(posedge clk_l);
            addr_l = 4'd3;
            rw_l   = 1'b1;
            oe_l   = 1'b0;
            mode_l = 1'b0;
            repeat(3) @(posedge clk_l);
            oe_l   = 1'b1;
        end
    endtask
    
    task test_read_right_pipeline();
        begin
            $display("[%0t] TEST 3: Read from address 3 (Right Port, Pipeline)", $time);
            // Wait for a few cycles after the left write to ensure data is stable
            repeat(2) @(posedge clk_r);
            
            // Apply address and start read
            addr_r = 4'd3;
            rw_r   = 1'b1;
            mode_r = 1'b1;
            
            // Wait for pipeline to fill (2 cycles minimum)
            @(posedge clk_r);
            @(posedge clk_r);
            
            // Now enable output
            oe_r   = 1'b0;
            
            // Keep reading for a few more cycles
            repeat(3) @(posedge clk_r);
            oe_r   = 1'b1;
        end
    endtask
    
    task test_write_right();
        begin
            $display("[%0t] TEST 4: Write 0x55 to address 5 (Right Port)", $time);
            @(posedge clk_r);
            addr_r = 4'd5;
            drv_r  = 8'h55;
            rw_r   = 1'b0;
            @(posedge clk_r);
            rw_r   = 1'b1;
            @(posedge clk_r);
        end
    endtask
    
    task test_read_left_verify();
        begin
            $display("[%0t] TEST 5: Read from address 5 (Left Port, verify 0x55)", $time);
            @(posedge clk_l);
            addr_l = 4'd5;
            rw_l   = 1'b1;
            oe_l   = 1'b0;
            mode_l = 1'b0;
            repeat(3) @(posedge clk_l);
            oe_l   = 1'b1;
        end
    endtask
    
    task test_simultaneous_access();
        begin
            $display("[%0t] TEST 6: Simultaneous Access - Write Left, Read Right", $time);
            fork
                begin
                    @(posedge clk_l);
                    addr_l = 4'd7;
                    drv_l  = 8'hF0;
                    rw_l   = 1'b0;
                    @(posedge clk_l);
                    rw_l   = 1'b1;
                end
                begin
                    // Right port reads address 7 in pipeline mode
                    repeat(2) @(posedge clk_r);
                    addr_r = 4'd7;
                    rw_r   = 1'b1;
                    mode_r = 1'b1;
                    @(posedge clk_r);
                    @(posedge clk_r);
                    oe_r   = 1'b0;
                    repeat(3) @(posedge clk_r);
                    oe_r   = 1'b1;
                end
            join
            #(CLK_L_PERIOD * 2);
        end
    endtask
    
    task test_output_disable();
        begin
            $display("[%0t] TEST 7: Output Disable Test", $time);
            @(posedge clk_l);
            oe_l = 1'b1;
            oe_r = 1'b1;
            repeat(3) @(posedge clk_l);
        end
    endtask

endmodule