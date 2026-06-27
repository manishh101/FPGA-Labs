`timescale 1ns / 1ps

module alu_8bit_tb;

    // Inputs (registers in testbench)
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] ALU_Sel;

    // Outputs (wires in testbench)
    wire [7:0] ALU_Out;
    wire CarryOut;
    wire Zero;

    // Instantiate the Unit Under Test (UUT)
    alu_8bit uut (
        .A(A), 
        .B(B), 
        .ALU_Sel(ALU_Sel), 
        .ALU_Out(ALU_Out), 
        .CarryOut(CarryOut), 
        .Zero(Zero)
    );

    initial begin
        // Enable waveform dump
        $dumpfile("alu_8bit.vcd");
        $dumpvars(0, alu_8bit_tb);
        
        $display("==========================================================================");
        $display("                   8-BIT ALU TESTBENCH START                              ");
        $display("==========================================================================");
        $display("Time(ns) | ALU_Sel |  A (Hex) |  B (Hex) | ALU_Out (Hex) | CarryOut | Zero");
        $display("---------+---------+-----------+-----------+---------------+----------+-----");

        // --- Test Case 1: ADD without carry ---
        A = 8'h12; B = 8'h34; ALU_Sel = 3'b000;
        #10;
        $display("%8d |   ADD   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 2: ADD with carry ---
        A = 8'hFF; B = 8'h01; ALU_Sel = 3'b000;
        #10;
        $display("%8d |   ADD   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 3: SUB without borrow ---
        A = 8'h50; B = 8'h20; ALU_Sel = 3'b001;
        #10;
        $display("%8d |   SUB   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 4: SUB with borrow (underflow) ---
        A = 8'h10; B = 8'h20; ALU_Sel = 3'b001;
        #10;
        $display("%8d |   SUB   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 5: AND ---
        A = 8'hAA; B = 8'h55; ALU_Sel = 3'b010;
        #10;
        $display("%8d |   AND   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 6: OR ---
        A = 8'hAA; B = 8'h55; ALU_Sel = 3'b011;
        #10;
        $display("%8d |   OR    |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 7: XOR ---
        A = 8'hF0; B = 8'h0F; ALU_Sel = 3'b100;
        #10;
        $display("%8d |   XOR   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 8: NOT ---
        A = 8'h0F; B = 8'h00; ALU_Sel = 3'b101;
        #10;
        $display("%8d |   NOT   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 9: SLL by 1 ---
        A = 8'h01; B = 8'h01; ALU_Sel = 3'b110;
        #10;
        $display("%8d |   SLL   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 10: SLL by 4 ---
        A = 8'h0F; B = 8'h04; ALU_Sel = 3'b110;
        #10;
        $display("%8d |   SLL   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 11: SRL by 1 ---
        A = 8'h80; B = 8'h01; ALU_Sel = 3'b111;
        #10;
        $display("%8d |   SRL   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 12: SRL by 4 ---
        A = 8'hF0; B = 8'h04; ALU_Sel = 3'b111;
        #10;
        $display("%8d |   SRL   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        // --- Test Case 13: Zero Flag Verification ---
        A = 8'hFF; B = 8'hFF; ALU_Sel = 3'b001; // Subtraction resulting in zero
        #10;
        $display("%8d |   SUB   |    %2h     |    %2h     |      %2h       |    %b     |  %b", $time, A, B, ALU_Out, CarryOut, Zero);

        $display("==========================================================================");
        $display("                   8-BIT ALU TESTBENCH COMPLETED                          ");
        $display("==========================================================================");
        $finish;
    end
      
endmodule
