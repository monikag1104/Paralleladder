`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
     $dumpfile("adder8_tb.vcd");
     $dumpvars(0, adder8_tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;    // Operand A
  reg [7:0] uio_in;   // Operand B
  wire [7:0] uo_out;  // SUM
  wire [7:0] uio_out; // Not used
  wire [7:0] uio_oe;  // Not used

  // Instantiate the user project
  tt_um_adder8 user_project (
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

  // Test stimulus
  initial begin
    // Initialize
    clk   = 0;
    rst_n = 1;
    ena   = 1;

    // Apply test cases
    ui_in  = 8'b00001100; uio_in = 8'b00000111; #10; // 12 + 7 = 19
    ui_in  = 8'b11110000; uio_in = 8'b00001111; #10; // 240 + 15 = 255
    ui_in  = 8'b10101010; uio_in = 8'b01010101; #10; // 170 + 85 = 255
    ui_in  = 8'b11111111; uio_in = 8'b00000001; #10; // 255 + 1 = 0 (with carry)

    $finish;
  end
endmodule
