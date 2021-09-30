// alu.v
// author: Ryan Wenger
// ECE 154A Lab 1

module alu(
	input [31:0] a, b,
	input [2:0] f,
	output reg [31:0] y,
	output reg zero
);
    always @(*) begin
        casez (f)
            // AND
            3'b?00: y = a & b; 
            // OR
            3'b?01: y = a | b;
            // ADD
            3'b?10: y = a + b;
            // SUB
            3'b110: y = a - b;
            // SLT
            3'b111: y = (a < b);
            default: break;
        endcase
        zero = (y == 32'b0);
    end
endmodule
