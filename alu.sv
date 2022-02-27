/*
MIT License

Copyright (c) 2022 José Luis Jiménez Arévalo, Eduardo García Olmos, Luis Alfredo Aceves Astengo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import definitions::*;

module alu
	#(parameter DATA_SIZE=32)
	 (input logic signed[DATA_SIZE-1:0] a,
	  input logic signed[DATA_SIZE-1:0] b,
	  input operation op,
	  output logic signed[DATA_SIZE-1:0] r,
	  output logic z, 
	  output logic n //added negative flag, to support multiplication
	);

always_comb
begin
	case(op)
		//ALU_ADD
		ALU_ADD: r = a + b;
		//ALU_SUB
		ALU_SUB: r = a - b;
		//ALU_AND
		ALU_AND: r = a & b;
		//ALU_OR
		ALU_OR: r = a | b;
		//ALU_XOR
		ALU_XOR: r = a ^ b;
		//ALU_SLL
		ALU_SLL: r = b << a;
		//ALU_SRL
		ALU_SRL: r = b >> a;
		//ALU_SLA
		ALU_SLA: r = b <<< a;
		//ALU_SRA
		ALU_SRA: r = b >>> a;
		//ALU_LUI
		ALU_LUI: r = {b[15:0],16'b0};
		//ALU_LLI
		ALU_LLI: r = {16'b0,b[15:0]};
		//ALU_NOT
		ALU_NOT: r = ~a;
		default: r = 'z;
	endcase
	z = (r==0) ? 1'b1 : 1'b0;
	n = r[DATA_SIZE-1];
end

endmodule
 
