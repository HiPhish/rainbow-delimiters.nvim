// Comment
`timescale 1ns/1ns
`default_nettype none
`include "filename.svh"

typedef enum {
    A,
    B,
    C
} Enum_t;

module test #(
    parameter int PARAM = 1
) (
    input logic[15:0] a,
    input logic[15:0] b,

    output logic[15:0] c
);
    logic[15:0][8:0] packed_data;
    logic[8:0] to_be_casted;

    divu #(
        .WIDTH(24),
        .FBITS(15)
    ) divider (
        .clk(i_clk),
        .rst(div_rst_actual),
        .start(div_start),
        .valid(o_avg_rdy),
        .done(),
        .dbz(),
        .ovf(),
        .busy(div_busy),
        .a(div_dividend),
        .b(div_divisor),
        .val(div_result_q15_9)
    );

    always_comb begin
        if (a > b) begin
            c = 15'd1;
        end else if ((a == b) || (a == c)) begin
            c = 15'd2;
            to_be_casted = 32'(c);

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

// This module implements an unsigned fixed point divider.
// Source: https://projectf.io/posts/division-in-verilog/ 
module divu #(
    parameter WIDTH=32,  // width of numbers in bits (integer and fractional)
    parameter FBITS=16   // fractional bits within WIDTH
    ) (
    input wire logic clk,    // clock
    input wire logic rst,    // reset
    input wire logic start,  // start calculation
    output     logic busy,   // calculation in progress
    output     logic done,   // calculation is complete (high for one tick)
    output     logic valid,  // result is valid
    output     logic dbz,    // divide by zero
    output     logic ovf,    // overflow
    input wire logic [WIDTH-1:0] a,   // dividend (numerator)
    input wire logic [WIDTH-1:0] b,   // divisor (denominator)
    output     logic [WIDTH-1:0] val  // result value: quotient
    );

    localparam FBITSW = (FBITS == 0) ? 1 : FBITS;  // avoid negative vector width when FBITS=0

    logic [WIDTH-1:0] b1;             // copy of divisor
    logic [WIDTH-1:0] quo, quo_next;  // intermediate quotient
    logic [WIDTH:0] acc, acc_next;    // accumulator (1 bit wider)

    localparam ITER = WIDTH + FBITS;  // iteration count: unsigned input width + fractional bits
    logic [$clog2(ITER)-1:0] i;       // iteration counter

    // division algorithm iteration
    always_comb begin
        if (acc >= {1'b0, b1}) begin
            acc_next = acc - b1;
            {acc_next, quo_next} = {acc_next[WIDTH-1:0], quo, 1'b1};
        end else begin
            {acc_next, quo_next} = {acc, quo} << 1;
        end
    end

    // calculation control
    always_ff @(posedge clk) begin
        done <= 0;
        if (start) begin
            valid <= 0;
            ovf <= 0;
            i <= 0;
            if (b == 0) begin  // catch divide by zero
                busy <= 0;
                done <= 1;
                dbz <= 1;
            end else begin
                busy <= 1;
                dbz <= 0;
                b1 <= b;
                {acc, quo} <= {{WIDTH{1'b0}}, a, 1'b0};  // initialize calculation
            end
        end else if (busy) begin
            if (i == ITER-1) begin  // done
                busy <= 0;
                done <= 1;
                valid <= 1;
                val <= quo_next;
            end else if (i == WIDTH-1 && quo_next[WIDTH-1:WIDTH-FBITSW] != 0) begin  // overflow?
                busy <= 0;
                done <= 1;
                ovf <= 1;
                val <= 0;
            end else begin  // next iteration
                i <= i + 1;
                acc <= acc_next;
                quo <= quo_next;
            end
        end
        if (rst) begin
            busy <= 0;
            done <= 0;
            valid <= 0;
            dbz <= 0;
            ovf <= 0;
            val <= 0;
        end
    end
endmodule
