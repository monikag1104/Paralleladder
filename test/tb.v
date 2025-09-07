module adder_tb();
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg        ena;
    reg        clk;
    reg        rst_n;

    // The top module has a specific pinout.
    // The testbench needs to connect to it correctly.
    tt_um_adder8 DUT (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tt_um_adder8_tb);

        // Control signals for the Tiny Tapeout harness
        ena = 1'b1;
        uio_oe = 8'b0; // Set to output enable low (input mode)
        rst_n = 1'b1;
        clk = 1'b0;

        // Test Case 1: 12 + 7 + 0 (12 + 7 = 19)
        ui_in  = 8'b00001100; // 12
        uio_in = 8'b00000111; // 7
        #10;
        
        // You can add a check here to verify the output
        if (uo_out == 8'd19) $display("Test Case 1 Passed!");
        else $display("Test Case 1 Failed!");

        // Test Case 2: 240 + 15 (240 + 15 = 255)
        ui_in  = 8'b11110000; // 240
        uio_in = 8'b00001111; // 15
        #10;

        if (uo_out == 8'd255) $display("Test Case 2 Passed!");
        else $display("Test Case 2 Failed!");
        
        // Test Case 3: 170 + 85 (170 + 85 = 255)
        ui_in  = 8'b10101010; // 170
        uio_in = 8'b01010101; // 85
        #10;
        
        if (uo_out == 8'd255) $display("Test Case 3 Passed!");
        else $display("Test Case 3 Failed!");

        // Test Case 4: 255 + 1 (255 + 1 = 256, but will be 0 with a carry-out)
        ui_in  = 8'b11111111; // 255
        uio_in = 8'b00000001; // 1
        #10;
        
        // Expecting 8'd0 since Cout is not part of uo_out
        if (uo_out == 8'd0) $display("Test Case 4 Passed!");
        else $display("Test Case 4 Failed!");

        #10 $finish;
    end
endmodule
