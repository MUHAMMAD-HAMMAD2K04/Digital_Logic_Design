`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 11:34:49 AM
// Design Name: 
// Module Name: DEBOUNCER_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DEBOUNCER_TB;

    // Inputs
    logic reset_in;
    logic clock_in;
    logic noisy_in;

    // Outputs
    logic clean_out;

    // Instantiate the DUT
    DEBOUNCER DUT (
        .reset_in(reset_in),
        .clock_in(clock_in),
        .noisy_in(noisy_in),
        .clean_out(clean_out)
    );

    // Clock generation: 10ns period (100 MHz)
    initial clock_in = 0;
    always #5 clock_in = ~clock_in;

        // Test stimulus
        initial begin
        // Initialize inputs
        reset_in = 1;
        noisy_in = 0;

        // Hold reset for some time
        #20;
        reset_in = 0;

        // Apply noisy signal pattern (simulate button bounce)
        #10 noisy_in = 1;
        #5  noisy_in = 0;
        #5  noisy_in = 1;
        #5  noisy_in = 0;
        #10 noisy_in = 1;

        // Wait long enough for debounce to register clean output
        #(20*1000000); // waiting 20M ns to cover debounce count

        // Change input to 0
        noisy_in = 0;

        // Wait again for debounce
        #(20*1000000);

        // Finish simulation
        $stop;
    end

    // Monitor signals
    initial begin
        $display("Time\treset_in\tnoisy_in\tclean_out");
        $monitor("%0t\t%b\t\t%b\t\t%b", $time, reset_in, noisy_in, clean_out);
    end

endmodule
