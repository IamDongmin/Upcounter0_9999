`timescale 1ns / 1ps

module decoder_2x4(
    input [1:0] i_digitSelect,
    input i_en,

    output [3:0] o_digit
    );

    reg [3:0] r_digit;

    assign o_digit = r_digit;
    
    always @(i_en, i_digitSelect) begin
        if (i_en) begin
            r_digit = 4'b1111;            
        end        
        else begin
            case (i_digitSelect)
                2'b00 : r_digit = 4'b1110;
                2'b01 : r_digit = 4'b1101;
                2'b10 : r_digit = 4'b1011;
                2'b11 : r_digit = 4'b0111;
            endcase
        end

    end
endmodule
