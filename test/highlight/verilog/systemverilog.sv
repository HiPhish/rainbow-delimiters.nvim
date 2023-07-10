// Comment
`timescale 1ns/1ns
`default_nettype none
`include "filename.svh"

module test #(
    parameter int PARAM = 1
) (
    input logic[15:0] a,
    input logic[15:0] b,

    output logic[15:0] c
);
    logic[15:0][8:0] packed_data;

    always_comb begin
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

    always_ff @(posedge a) begin
        c <= ((a + b) + b);
    end
endmodule

module test2 #(
    parameter int PARAM = 1,
    parameter int PARAM2 = ((2+2) / (4+4))
) (
    input logic[15:0] a,
    input logic[15:0] b,

    output logic[15:0] c
);
    logic[15:0][8:0] packed_data;

    always_comb begin
        if (a > b) begin
            c = 15'd1;
        end else if ((a == b) || (a == c)) begin
            c = 15'd2;

            if (c == 15'd2) begin
                c = 15'd3;
                packed_data[2][3] = $clog2($clog2((24)));
            end
        end
    end

    always_ff @(posedge a) begin
        c <= ((a + b) + b);
    end
endmodule
