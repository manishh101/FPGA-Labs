// 8-Bit Arithmetic Logic Unit (ALU)
// Module Name: alu_8bit
// Description: Implements 8 ALU operations based on a 3-bit selector.

module alu_8bit (
    input  wire [7:0] A,          // 8-bit input A
    input  wire [7:0] B,          // 8-bit input B
    input  wire [2:0] ALU_Sel,    // 3-bit operation selector
    output reg  [7:0] ALU_Out,    // 8-bit ALU output
    output reg        CarryOut,   // Carry out flag (for addition/subtraction)
    output wire       Zero        // Zero flag (1 if ALU_Out is 0)
);

    // Temporary 9-bit register to capture addition carry / subtraction borrow
    reg [8:0] temp_res;

    // Zero Flag: Set to 1 if the output is all zeros
    assign Zero = (ALU_Out == 8'b0);

    always @(*) begin
        // Defaults to avoid latch inference
        CarryOut = 1'b0;
        temp_res = 9'b0;
        
        case (ALU_Sel)
            3'b000: begin // ADD: Addition
                temp_res = A + B;
                ALU_Out  = temp_res[7:0];
                CarryOut = temp_res[8];
            end
            
            3'b001: begin // SUB: Subtraction
                temp_res = A - B;
                ALU_Out  = temp_res[7:0];
                CarryOut = temp_res[8]; // Borrow out (indicates underflow)
            end
            
            3'b010: begin // AND: Bitwise AND
                ALU_Out  = A & B;
            end
            
            3'b011: begin // OR: Bitwise OR
                ALU_Out  = A | B;
            end
            
            3'b100: begin // XOR: Bitwise XOR
                ALU_Out  = A ^ B;
            end
            
            3'b101: begin // NOT: Bitwise NOT of input A
                ALU_Out  = ~A;
            end
            
            3'b110: begin // SLL: Logical Shift Left A by B[2:0] positions
                ALU_Out  = A << B[2:0];
            end
            
            3'b111: begin // SRL: Logical Shift Right A by B[2:0] positions
                ALU_Out  = A >> B[2:0];
            end
            
            default: begin
                ALU_Out  = 8'b0;
                CarryOut = 1'b0;
            end
        endcase
    end

endmodule
