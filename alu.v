// alu.v
// author: Ryan Wenger
// ECE 154A Lab 1

module alu(
	input [31:0] a, b,
	input [2:0] f,
	output [31:0] y,
	output zero
);
//    always @(*) begin
//        casez (f)
//            // AND
//            3'b?00: y = a & b; 
//            // OR
//            3'b?01: y = a | b;
//            // ADD
//            3'b010: y = a + b;
//            // SUB
//            3'b110: y = a + (~b + 1'b1);
//            // SLT
//            3'b111: y = (a < b);
//            default: break;
//        endcase
//        zero = (y == 32'b0);
//    end
    
    wire [3:0] enables;
    decoder2to4 op(.in(f[1:0]), .out(enables));
    
    andgate AND(.enb(enables[0]), .a(a), .b(b), .y(y));
    orgate OR(.enb(enables[1]), .a(a), .b(b), .y(y));
    adder ADD(.enb(enables[2]), .a(a), .b(f[2] ? (~b + 1'b1) : b), .y(y));
    comparator SLT(.enb(enables[3] & f[2]), .a(a), .b(b), .y(y));
    
    assign zero = (y === 32'b0) ;
    
endmodule


// 2:4 decoder module
module decoder2to4(
    input [1:0] in,
    output [3:0] out
    );
    assign out[0] = ~in[0] & ~in[1];
    assign out[1] =  in[0] & ~in[1];
    assign out[2] = ~in[0] &  in[1];
    assign out[3] =  in[0] &  in[1]; 
endmodule

// 2:1 multiplexer
module mux2to1(
    input switch,
    input x0, x1,
    output y
    );
    assign y = switch ? x1 : x0;
endmodule

// 32-bit AND gate
module andgate(
    input enb,
    input [31:0] a, b,
    output [31:0] y
    );
    assign y = enb ? (a & b) : y;
endmodule

// 32-bit OR gate
module orgate(
    input enb,
    input [31:0] a, b,
    output [31:0] y
    );
    assign y = enb ? (a | b) : y;
endmodule

// 32-bit adder
module adder(
    input enb,
    input [31:0] a, b,
    output [31:0] y
    );
    assign y = enb ? (a + b) : y;
endmodule

// 32-bit comparator
module comparator(
    input enb,
    input [31:0] a, b,
    output [31:0] y
    );
    assign y = enb ? (a < b) : y;
endmodule
