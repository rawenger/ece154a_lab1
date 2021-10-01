`timescale 1ns / 1ns
`define NUM_TESTS 25
//`define VECTORSIZE (`NUM_TEST*5 - 1)

module alu_tb;

logic clk;

logic [31:0] a, b;
logic [2:0] f;
wire [31:0] y;
wire zero;

logic [31:0] testvectors [`NUM_TESTS*5-1:0];
integer rownum, errors;
logic [31:0] test_y;
logic test_zero;

alu dut(.a(a), .b(b), .f(f), .y(y), .zero(zero));

// clock signal
always begin
	clk = 1; #5; clk = 0; #5;
end

// initialize test vectors
initial begin
	$readmemh("alu.tv", testvectors);
	rownum = 0; errors = 0;
end

// apply test vectors at rising clock edge
always @(posedge clk) begin
	f = testvectors[0 + 5*rownum];
	a = testvectors[1 + 5*rownum];
	b = testvectors[2 + 5*rownum];
	test_y = testvectors[3 + 5*rownum];
	test_zero = testvectors[4 + 5*rownum];
end

// check results at falling clock edge
always @(negedge clk) begin
	assert (y === test_y && zero === test_zero) else begin errors++; $error("Test failed line %d. Expected y = %h, zero = %b. Actual y = %h, zero = %b.", rownum + 1, test_y, test_zero, y, zero); end
	//$display("a = %h, b = %h, f = %d, test_y = %h, test_zero = %b", a, b, f, test_y, test_zero);
	//$display("testvectors = %p", testvectors);
	if (++rownum == `NUM_TESTS) begin
		$display("Testing finished with %d errors.", errors);
		// end simulation after 200ns
		// uncomment below line if not running in ModelSim
		// $finish
	end
end

endmodule
