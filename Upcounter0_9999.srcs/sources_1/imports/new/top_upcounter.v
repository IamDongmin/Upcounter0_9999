`timescale 1ns / 1ps


module top_upcounter(
    input i_clk,
    input i_reset, i_en,

    output [3:0] o_digit,
    output [7:0] o_fndfont
    );

    wire w_clk_1khz;
    wire w_clk_10hz;
    wire [1:0] w_counter1;
    wire [13:0] w_counter2;

    wire [3:0] w_1000_value, w_100_value, w_10_value, w_1_value;
    wire [3:0] w_value;

    clock_divider clockDivider1k(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk_1khz)
    );

    counter_fnd counter_fnd(
        .i_clk(w_clk_1khz),
        .i_reset(i_reset),
        .o_counter(w_counter1)
    );

    decoder_2x4 decoder2x4(
        .i_digitSelect(w_counter1),
        .i_en(i_en),
        .o_digit(o_digit)
    );


    clock_divider_10Hz clockDivider10hz(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk_10hz)
    );

    counter_data dataCounter(
        .i_clk(w_clk_10hz),
        .i_reset(i_reset),
        .o_counter(w_counter2)
    );

    digit_divider digitDivider(
        .i_value(w_counter2),
        .o_1000(w_1000_value),
        .o_100(w_100_value),
        .o_10(w_10_value),
        .o_1(w_1_value)
    );

    mux_4x1 mux4x1(
        .i_1Value(w_1_value),
        .i_10Value(w_10_value),
        .i_100Value(w_100_value),
        .i_1000Value(w_1000_value),
        .i_counter(w_counter1),
        .o_value(w_value)
    );

    BCDtoFND_decoder BCDtoFND(
        .i_value(w_value),
        .i_en(i_en),
        .o_fndfont(o_fndfont)
    );
    
endmodule
