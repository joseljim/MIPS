//---------------------------------------------------------------------------------------------------//
// MIT License
//
// Copyright (c) 2022 José Luis Jiménez Arévalo, Eduardo García Olmos, Luis Alfredo Aceves Astengo
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//---------------------------------------------------------------------------------------------------//

module mux4
	#(parameter DATA_SIZE=32)
	(input logic[DATA_SIZE-1:0] inA,
	input logic[DATA_SIZE-1:0] inB,
	input logic[DATA_SIZE-1:0] inC,
	input logic[DATA_SIZE-1:0] inD,
	input logic[1:0] select,
	output logic[DATA_SIZE-1:0] out);

always_comb
begin
	case(select)
	2'd0: out = inA;
	2'd1: out = inB;
	2'd2: out = inC;
	2'd3: out = inD;
	default: out = inA;
	endcase
end

endmodule
