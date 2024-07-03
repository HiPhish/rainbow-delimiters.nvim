// Comment
`timescale 1ns/1ns
`default_nettype none
`include "filename.vh"

module test #(
    parameter PARAM = 1
) (
    input reg[15:0] a,
    input reg[15:0] b,

    output reg[15:0] c
);
    logic[15:0][8:0] packed_data;

    always @* begin
        if (a > b) begin
            c = 15'd1;
        end else if ((a == b) || (a == c)) begin
            c = 15'd2;

            if (c == 15'd2) begin
                c = 15'd3;
                packed_data[2][3] = 8'd4;
            end
        end
    end
endmodule

module test2 #(
    parameter PARAM = 1
) (
    input reg[15:0] a,
    input reg[15:0] b,

    output reg[15:0] c
);
    logic[15:0][8:0] packed_data;

    always @* begin
        if (a > b) begin
            c = 15'd1;
        end else if ((a == b) || (a == c)) begin
            c = 15'd2;

            if (c == 15'd2) begin
                c = 15'd3;
                packed_data[2][3] = 8'd4;
            end
        end
    end
endmodule
