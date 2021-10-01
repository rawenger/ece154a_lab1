// alu.v
// author: Ryan Wenger
// ECE 154A Lab 1

module alu(
	input [31:0] a, b,
	input [2:0] f,
	output [31:0] y,
	output zero
);

//TODO: add a test case for the no-op! (f = 011)
    
    wire [3:0] enables;
    decoder2to4 op(.in(f[1:0]), .out(enables));
    
    wire [31:0] and_out, or_out, add_out, cmp_out;
    andgate AND(.enb(enables[0]), .a(a), .b(b), .y(and_out));
    orgate OR(.enb(enables[1]), .a(a), .b(b), .y(or_out));
    adder ADD(.enb(enables[2]), .a(a), .b(f[2] ? (~b + 1'b1) : b), .y(add_out));
    comparator SLT(.enb(enables[3] & f[2]), .a(a), .b(b), .y(cmp_out));
    
    assign y = (enables[3] === 1 && f[2] === 0) ? y : (and_out | or_out | add_out | cmp_out);
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
    assign y = enb ? (a & b) : 0;
endmodule

// 32-bit OR gate
module orgate(
    input enb,
    input [31:0] a, b,
    output [31:0] y
    );
    assign y = enb ? (a | b) : 0;
endmodule

// 32-bit adder
module adder(
    input enb,
    input [31:0] a, b,
    output [31:0] y
    );
    assign y = enb ? (a + b) : 0;
endmodule

// 32-bit comparator
module comparator(
    input enb,
    input [31:0] a, b,
    output [31:0] y
    );
    assign y = enb ? ((a - b) > 32'b1) : 0;
endmodule
