`timescale 1ns / 1ps

module UART_BAUD_GEN_tb;

    // Signals
    logic sys_clk;
    logic arst;
    logic [1:0] baud_sel;
    logic bclk;
    logic bclkx8;

    // DUT
    UART_BAUD_GEN uut(
        .sys_clk(sys_clk),
        .arst(arst),
        .baud_sel(baud_sel),
        .bclk(bclk),
        .bclkx8(bclkx8)
    );

    //----------------------------------
    // Clock Generation (100 MHz)
    //----------------------------------
    initial begin
        sys_clk = 0;
        forever #5 sys_clk = ~sys_clk; // 10ns period
    end

    //----------------------------------
    // Monitor outputs
    //----------------------------------
    initial begin
        $monitor("TIME=%0t | baud_sel=%b | bclkx8=%b | bclk=%b", 
                  $time, baud_sel, bclkx8, bclk);
    end

    //----------------------------------
    // Stimulus
    //----------------------------------
    initial begin

        // Reset
        arst = 1;
        baud_sel = 2'b00;
        #50;
        arst = 0;

        //----------------------------------
        // Test 9600 baud
        //----------------------------------
        baud_sel = 2'b00; // 9600
        #200000;            // simulate for a while

        //----------------------------------
        // Test 19200 baud
        //----------------------------------
        baud_sel = 2'b01; // 19200
        #100000;            // simulate for a while

        //----------------------------------
        // Test 38400 baud
        //----------------------------------
        baud_sel = 2'b10; // 38400
        #50000;             // simulate for a while

        //----------------------------------
        // Test 57600 baud
        //----------------------------------
        baud_sel = 2'b11; // 57600
        #30000;             // simulate for a while

        //----------------------------------
        $stop;  // end simulation
    end

endmodule