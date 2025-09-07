/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_adder8_tb;
  // Testbench signals
  reg  [7:0] ui_in;
  reg  [7:0] uio_in;
  reg  [7:0] uio_oe;
  reg        ena;
  reg        clk;
  reg        rst_n;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] sum;
  wire       cout;

  // Instantiate the Device Under Test (DUT)
  tt_um_adder8 DUT (
    .ui_in   (ui_in),
    .uo_out  (uo_out),
    .uio_in  (uio_in),
    .uio_out (uio_out),
    .uio_oe  (uio_oe),
    .ena     (ena),
    .clk     (clk),
    .rst_n   (rst_n)
  );

  // Initial stimulus
  initial begin
    $dumpfile("adder8_tb.vcd"); // For GTKWave
    $dumpvars(0, adder8_tb);

    // Set control signals
    ena   = 1'b1;
    clk   = 1'b0;
    rst_n = 1'b1;
    uio_oe = 8'b0;

    // Test Case 1: 12 + 7
    ui_in  = 8'b00001100; // 12
    uio_in = 8'b00000111; // 7
    #15;

    // Test Case 2: 240 + 15 + 1 (with carry)
    ui_in  = 8'b11110000; // 240
    uio_in = 8'b00001111; // 15
    #15;

    // Test Case 3: 170 + 85
    ui_in  = 8'b10101010; // 170
    uio_in = 8'b01010101; // 85
    #15;

    // Test Case 4: 255 + 1
    ui_in  = 8'b11111111; // 255
    uio_in = 8'b00000001; // 1
    #15;

    $display("Simulation finished.");
    $finish;
  end



endmodule
