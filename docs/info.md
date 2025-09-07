<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project is an 8-bit ripple carry parallel adder. It takes two 8-bit binary numbers as inputs: ui_in[7:0] → Operand A uio_in[7:0] → Operand B It adds them using a chain of 8 full adders, where each stage passes its carry to the next stage. The final 8-bit sum is output on uo_out[7:0]. The final carry-out (Cout) is generated internally but not connected to an external pin in this version.


## How to test

You can test the design in simulation: Run the provided testbench (tb.v). The testbench applies different input combinations of A and B. Example: A = 00001100 (12) B = 00000111 (7) Sum = 00010011 (19)

## External hardware

No external hardware is required.
