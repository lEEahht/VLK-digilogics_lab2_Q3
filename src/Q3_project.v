/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none
`timescale 1ns / 1ps

module tt_um_Q3_project (
    input wire clk,          // Clock input
    input wire rst_n,        // Active low reset
    input wire ena,          // Enable signal
    input wire [7:0] ui_in,  // Input A
    input wire [7:0] uio_in, // Input B
    output reg [7:0] uo_out, // Output C
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    // Internal Wire for MUX result
    wire [6:0] mux_result;

    // MUX Logic for Lower 7 Bits
    assign mux_result = (ui_in[7] == 0) ? ui_in[6:0] : uio_in[6:0];

    // Output Enable Configuration (Active high: 1=output)
    assign uio_out = uo_out;
    assign uio_oe = 8'b11111111;

    // Sequential Logic for Output with Reset and Enable
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uo_out <= 8'b00000000;
        end else if (ena) begin
            // Assign MUX result to uo_out[6:0]
            uo_out[6:0] <= mux_result;
            // uo_out[7] is AND of ui_in[7] and uio_in[7]
            uo_out[7] <= ui_in[7] & uio_in[7];
        end
    end

endmodule
