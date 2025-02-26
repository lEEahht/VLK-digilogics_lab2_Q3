/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module Q3_project (
    input  wire        clk,     // Clock input
    input  wire        rst_n,   // Active low reset
    input  wire [7:0]  A,       // Input A
    input  wire [7:0]  B,       // Input B
    output reg  [7:0]  C        // Output C
);

    // Internal Wires for OR and XOR results
    wire [6:0] or_result;
    wire [6:0] xor_result;

    // Bitwise OR for lower 7 bits
    assign or_result = A[6:0] | B[6:0];
    
    // Bitwise XOR for lower 7 bits
    assign xor_result = A[6:0] ^ B[6:0];

    // Sequential Logic for Output with Reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            C <= 8'b00000000;
        end else begin
            // MUX to select between OR and XOR
            C[6:0] <= (A[7] == 0) ? or_result : xor_result;
            // C[7] is always set to 1
            C[7] <= 1;
        end
    end

endmodule
