`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2026 08:26:25 PM
// Design Name: 
// Module Name: Counter_sequence
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


module Counter_sequence(

    input  logic [3:0] bcd,   // BCD input where bcd[3] is MSB and bcd[0] is LSB
    output logic [6:0] seg,   // seven segment outputs a to g
    output logic [7:0] an     // anode control signals for 8 displays
);

    always_comb begin

        // enable only the first seven segment display
        an = 8'b11111110;

        // select segment pattern based on BCD value
        case (bcd)
            4'd0: seg = 7'b100_0000; // display digit 0
            4'd1: seg = 7'b111_1001; // display digit 1
            4'd2: seg = 7'b010_0100; // display digit 2
            4'd3: seg = 7'b011_0000; // display digit 3
            4'd4: seg = 7'b001_1001; // display digit 4
            4'd5: seg = 7'b001_0010; // display digit 5
            4'd6: seg = 7'b000_0010; // display digit 6
            4'd7: seg = 7'b111_1000; // display digit 7
            4'd8: seg = 7'b000_0000; // display digit 8
            4'd9: seg = 7'b001_0000; // display digit 9
            default: seg = 7'b1111111; // blank display for invalid BCD
        endcase

    end

endmodule


// Clock Divider Module for FPGA Module : 

module clk_divider #(
    parameter SIM = 0
)(
    input  logic clk_in,   // input system clock
    input  logic rst_n,    // active low reset
    output logic clk_out   // divided clock output
);

    logic [26:0] clk_count; // counter used for clock division

    generate

        // bypass divider when running simulation
        if (SIM) begin
            assign clk_out = clk_in;
        end 

        else begin

            // divide the 100 MHz clock to a slower clock
            always_ff @(posedge clk_in or negedge rst_n) begin

                // reset counter and output clock
                if (!rst_n) begin
                    clk_count <= 0;
                    clk_out <= 0;
                end 

                else begin

                    // toggle output clock when count reaches limit
                    if (clk_count == 100_000_000-1) begin
                        clk_count <= 0;
                        clk_out <= ~clk_out;
                    end 

                    // otherwise increment counter
                    else
                        clk_count <= clk_count + 1;

                end
            end

        end

    endgenerate

endmodule


// Sequence Counter Module : 

module sequence_counter #(
    parameter SIM = 0
)(
    input  logic clk,       // system clock
    input  logic rst_n,     // active low reset
    output logic [3:0] count // output count value
);

    logic slow_clk; // slower clock from divider

    // instantiate clock divider
    clk_divider #(.SIM(SIM)) U_CLKDIV (
        .clk_in(clk),
        .rst_n(rst_n),
        .clk_out(slow_clk)
    );

    // current state and next state variables
    logic [3:0] state, next_state;

    // next state logic implementing required sequence
    always_comb begin

        case (state)

            4'd0: next_state = 4'd2;
            4'd2: next_state = 4'd4;
            4'd4: next_state = 4'd6;
            4'd6: next_state = 4'd1;
            4'd1: next_state = 4'd3;
            4'd3: next_state = 4'd5;
            4'd5: next_state = 4'd7;
            4'd7: next_state = 4'd0;

            // default state for invalid conditions
            default: next_state = 4'd0;

        endcase

    end

    // state register using flip flops
    always_ff @(posedge slow_clk or negedge rst_n) begin

        // reset initializes state to zero
        if (!rst_n)
            state <= 4'd0;

        // update state with next state value
        else
            state <= next_state;

    end

    // assign state to output
    assign count = state;

endmodule


module Counter2 #(  parameter SIM = 0)
(
    input  logic clk,      // system clock
    input  logic rst_n,    // active low reset
    output logic [6:0] seg, // seven segment outputs
    output logic [7:0] an   // anode control signals
);

    logic [3:0] count; // counter output

    // instantiate sequence counter
    sequence_counter #(.SIM(SIM)) U_CNT (
        .clk(clk),
        .rst_n(rst_n),
        .count(count)
    );

    // instantiate BCD to seven segment display module
     Counter_sequence U_BCD (
        .bcd(count),
        .seg(seg),
        .an(an)
    );

endmodule
