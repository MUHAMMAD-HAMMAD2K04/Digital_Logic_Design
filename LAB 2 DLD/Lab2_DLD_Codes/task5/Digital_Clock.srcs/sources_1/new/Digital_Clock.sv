`timescale 1ns / 1ps

/////////////////////////////////////////////////
// Top Module
/////////////////////////////////////////////////

module Digital_Clock
#(parameter DIV = 50_000_000)
(
    input  logic clk,          // 100 MHz Nexys A7 clock
    input  logic rst,          // reset button
    output logic CA, CB, CC, CD, CE, CF, CG,
    output logic DP,
    output logic [7:0] AN
);

    /////////////////////////////////
    // Internal Signals
    /////////////////////////////////

    logic clk_1Hz;
    logic [5:0] seconds;
    logic [5:0] minutes;
    logic [4:0] hours;

    logic [3:0] sec_ones, sec_tens;
    logic [3:0] min_ones, min_tens;
    logic [3:0] hr_ones, hr_tens;

    logic [2:0] scan;
    logic [3:0] digit;
    logic [6:0] seg;

    /////////////////////////////////
    // Clock Divider (1 Hz)
    /////////////////////////////////

    clock_divider_1Hz #(.DIV(DIV)) clk_div (
        .clk(clk),
        .rst(rst),
        .clk_1Hz(clk_1Hz)
    );

    /////////////////////////////////
    // Digital Clock Logic
    /////////////////////////////////

    digital_clock clock_logic (
        .clk_1Hz(clk_1Hz),
        .rst(rst),
        .seconds(seconds),
        .minutes(minutes),
        .hours(hours)
    );

    /////////////////////////////////
    // Digit Extraction
    /////////////////////////////////

    assign sec_ones = seconds % 10;
    assign sec_tens = seconds / 10;

    assign min_ones = minutes % 10;
    assign min_tens = minutes / 10;

    assign hr_ones  = hours % 10;
    assign hr_tens  = hours / 10;

    /////////////////////////////////
    // Display Refresh Counter
    /////////////////////////////////

    logic [16:0] refresh_counter;

    always_ff @(posedge clk)
        refresh_counter <= refresh_counter + 1;

    assign scan = refresh_counter[16:14];

    /////////////////////////////////
    // Digit Multiplexing
    /////////////////////////////////

    always_comb
    begin
        case(scan)

            3'd0: begin AN = 8'b11111110; digit = sec_ones; end
            3'd1: begin AN = 8'b11111101; digit = sec_tens; end
            3'd2: begin AN = 8'b11111011; digit = min_ones; end
            3'd3: begin AN = 8'b11110111; digit = min_tens; end
            3'd4: begin AN = 8'b11101111; digit = hr_ones;  end
            3'd5: begin AN = 8'b11011111; digit = hr_tens;  end

            default: begin AN = 8'b11111111; digit = 0; end

        endcase
    end

    /////////////////////////////////
    // 7 Segment Decoder (Active LOW)
    /////////////////////////////////

    always_comb
    begin
        case(digit)

            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;

            default: seg = 7'b1111111;

        endcase
    end

    /////////////////////////////////
    // Segment Output Mapping
    /////////////////////////////////

    assign {CA, CB, CC, CD, CE, CF, CG} = seg;

    /////////////////////////////////
    // Blinking Colon using DP
    /////////////////////////////////

    assign DP = ~clk_1Hz;

endmodule


/////////////////////////////////////////////////
// Clock Divider (100MHz ? 1Hz)
/////////////////////////////////////////////////

module clock_divider_1Hz
#(parameter DIV = 100_000_000)
(
    input  logic clk,
    input  logic rst,
    output logic clk_1Hz
);

    logic [31:0] counter;

    always_ff @(posedge clk or negedge rst)
    begin
        if(!rst)
        begin
            counter <= 0;
            clk_1Hz <= 0;
        end
        else
        begin
            if(counter == (DIV/2 - 1))
            begin
                counter <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else
                counter <= counter + 1;
        end
    end

endmodule


/////////////////////////////////////////////////
// Clock Counter (HH:MM:SS)
/////////////////////////////////////////////////

module digital_clock
(
    input  logic clk_1Hz,
    input  logic rst,
    output logic [5:0] seconds,
    output logic [5:0] minutes,
    output logic [4:0] hours
);

    always_ff @(posedge clk_1Hz or negedge rst)
    begin
        if(!rst)
        begin
            seconds <= 0;
            minutes <= 0;
            hours   <= 0;
        end
        else
        begin

            if(seconds == 59)
            begin
                seconds <= 0;

                if(minutes == 59)
                begin
                    minutes <= 0;

                    if(hours == 23)
                        hours <= 0;
                    else
                        hours <= hours + 1;
                end
                else
                    minutes <= minutes + 1;

            end
            else
                seconds <= seconds + 1;

        end
    end

endmodule