//include all file_namne

`include "adder.v"
`include "substractor.v"
`include "multiplication.v"
`include "division.v"
`include "incrementer.v"
`include "decrementer.v"
`include "NOT.v"
`include "OR.v"
`include "EXOR.v"
`include "AND.v"
`include "NAND.v"
`include "NOR.v"
`include "EXNOR.v"
`include "mux.v"

module alu(a,b,opcode,result,zero_flag,sign_flag);
  input signed [63:0]a,b; // input of all operational modules
  input [3:0]opcode; // sel of mux
  output signed [127:0]result;
  output reg  zero_flag,sign_flag; // output of mux
  // This all wires would be inputs of mux. and output of all operational modules
  
  wire [64:0]add_out;
  wire [64:0]sub_out;
  wire [127:0]mult_out;
  wire [63:0]div_out;
  wire [64:0]incr_out1;
  wire [64:0]incr_out2;
  wire [64:0]decr_out1;
  wire [64:0]decr_out2;
  wire [63:0]not_out1;
  wire [63:0]not_out2;
  wire [63:0]or_out;
  wire [63:0]xor_out;
  wire [63:0]and_out;
  wire [63:0]nand_out;
  wire [63:0]nor_out;
  wire [63:0]xnor_out;
  
  
  
  adder_64_bit add1(a,b,add_out);			
  substractor_64_bit sub1(a,b,sub_out);		
  multiplier_64_bit mult1(a,b,mult_out);	
  divisor_64_bit div1(a,b,div_out);			
  incrementer_64_bit incr1(a, incr_out1);
  incrementer_64_bit incr2(b, incr_out2);
  decrementer_64_bit decr1(a, decr_out1 );
  decrementer_64_bit decr2(b, decr_out2 );
  not_64_bit not1(a, not_out1);
  not_64_bit not2(b, not_out2);
  or_64_bit or1(a,b,or_out);
  exor_64_bit xor1(a,b,xor_out);
  and_64_bit and1(a,b,and_out);
  nand_64_bit nand1(a,b,nand_out);
  nor_64_bit nor1(a,b,nor_out);
  exnor_64_bit xnor1(a,b,xnor_out);
//			0		1			2		3		4			5  
  mux mux1(add_out, sub_out, mult_out, div_out, incr_out1, incr_out2,
//			6				7		8			9		10		11           
           decr_out1,  decr_out2, not_out1, not_out2, and_out, or_out,
//			12			13		14			15		16
           xor_out,  nand_out, nor_out, xnor_out, opcode, result);
  



     
always @(result)
begin
	if (result==0)
		zero_flag =1;
	else
		zero_flag=0;
end

always @(result)
begin
	if (result[127])
		sign_flag =1;
	else
		sign_flag=0;
end


endmodule






