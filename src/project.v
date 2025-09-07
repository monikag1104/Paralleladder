/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_adder8 (
    input  wire [7:0] ui_in,    // Dedicated inputs (X)
    output wire [7:0] uo_out,   // Dedicated outputs (SUM[7:0])
    input  wire [7:0] uio_in,   // IOs: Input path (Y)
    output wire [7:0] uio_out,  // IOs: Output path (not used)
    output wire [7:0] uio_oe,   // IOs: Enable path (not used, keep 0)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock (not used here)
    input  wire       rst_n     // reset_n - low to reset (not used here)
);

  // Internal wires
  wire [7:0] A = ui_in;    // First operand
  wire [7:0] B = uio_in;   // Second operand
  wire [7:0] SUM; 
  wire Cout;
  wire c1,c2,c3,c4,c5,c6,c7;

  // Instantiate 8 full adders
  fulladd FA0 (A[0], B[0], 1'b0, SUM[0], c1);
  fulladd FA1 (A[1], B[1], c1,   SUM[1], c2);
  fulladd FA2 (A[2], B[2], c2,   SUM[2], c3);
  fulladd FA3 (A[3], B[3], c3,   SUM[3], c4);
  fulladd FA4 (A[4], B[4], c4,   SUM[4], c5);
  fulladd FA5 (A[5], B[5], c5,   SUM[5], c6);
  fulladd FA6 (A[6], B[6], c6,   SUM[6], c7);
  fulladd FA7 (A[7], B[7], c7,   SUM[7], Cout);

  // Outputs
  assign uo_out  = SUM;     // Final 8-bit sum
  assign uio_out = 0;       // Not used
  assign uio_oe  = 0;       // Not used

  // Prevent unused signal warnings
  wire _unused = &{ena, clk, rst_n, Cout, 1'b0};

endmodule

// Full Adder Module
module fulladd(
    input  wire x, y, carryin,
    output wire s, carryout
);
  assign s       = x ^ y ^ carryin;
  assign carryout = (x & y) | (y & carryin) | (carryin & x);
endmodule
