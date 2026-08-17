`timescale 1ns / 1ps

module tb_Digital_Clock;

    // Parameters
    parameter DIV = 50_000_000; // Clock divider for 1Hz

    // Inputs
    logic clk;
    logic rst;

    // Outputs
    logic CA, CB, CC, CD, CE, CF, CG;
    logic DP;
    logic [7:0] AN;

    // Instantiate the Digital Clock
    Digital_Clock #(.DIV(DIV)) uut (
        .clk(clk),
        .rst(rst),
        .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG),
        .DP(DP),
        .AN(AN)
    );

    ////////////////////////////
    // Clock Generation (100MHz)
    ////////////////////////////
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz clock period = 10 ns

    ////////////////////////////
    // Test Stimulus
    ////////////////////////////
    initial begin
        // Initialize inputs
        rst = 1;

        // Apply reset for 50 ns
        #50;
        rst = 0;

        // Let the clock run for some time to see counting
        #1_000_000_000; // simulate for 1 second (approx)

        // Finish simulation
        $stop;
    end

    ////////////////////////////
    // Optional: Monitor Outputs
    ////////////////////////////
    initial begin
        $display("Time\tRST\tAN\tDP\tCA CB CC CD CE CF CG");
        $monitor("%0t\t%b\t%8b\t%b\t%b %b %b %b %b %b %b",
                 $time, rst, AN, DP, CA, CB, CC, CD, CE, CF, CG);
    end

endmodule