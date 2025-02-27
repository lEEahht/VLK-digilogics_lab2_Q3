/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none
`timescale 1ns / 1ps

module tt_um_Q3_project (
    input wire clk,          // Clock input
    input wire rst_n,        // Active low reset
    input wire [7:0] ui_in,  // Input A
    input wire [7:0] uio_in, // Input B
    output reg [7:0] uo_out, // Output C
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    // Output Enable Configuration (Always Output)
    assign uio_out = uo_out;
    assign uio_oe = 8'b11111111;  // Output enabled for all bits

    // Sequential Logic for Output with Reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uo_out <= 8'b00000000;
        end else begin
            // MUX-like behavior
            uo_out[6:0] <= (ui_in[7] == 0) ? ui_in[6:0] : uio_in[6:0];
            // Set C[7] to 1 (Fixed Value)
            uo_out[7] <= 1'b1;
        end
    end

endmodule
