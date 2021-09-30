`timescale 1ns / 1ns

module alu_tb;

logic [31:0] a, b;
logic [2:0] f;
wire [31:0] y;
wire zero;

logic [101:0] testvectors [19:0];
integer mem_addr;
logic [31:0] test_y;
logic testzero;

alu dut(.a(a), .b(b), .f(f), .y(y), .zero(zero));

initial begin
//$dumpfile("dump.vcd");
//$dumpvars(0, alu_tb);
//end
//forever begin
	#10;
	$readmemh("alu.tv", testvectors);
	{f,a,b,test_y,test_zero} = testvectors[0];
//	f = test_vectors[0][2:0];
//	a = test_vectors[1];
//	b = test_vectors[2];
//	test_y = test_vectors[3];
//	test_zero = test_vectors[4];
    #1;
    $display("a = %h, b= %h, f = %d, test_y = %h, test_zero = %b", a, b, f, test_y, test_zero);

	
end

endmodule
