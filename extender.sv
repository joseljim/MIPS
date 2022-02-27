//---------------------------------------------------------------------------------------------------//
// MIT License
//
// Copyright (c) 2022 José Luis Jiménez Arévalo, Eduardo García Olmos and Luis Alfredo Aceves Astengo
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

module extender(input logic [4:0] sa,
		input logic [15:0] imm,
		input logic zero_or_sign,
		output logic [31:0] ext_sa,
		output logic [31:0] ext_imm 
		);

always_comb 
begin 
	if(sa[4]==0)
		ext_sa = {27'b0,sa[4:0]};
	else	
		ext_sa = {27'h7ffffff,sa[4:0]};
	
	if(zero_or_sign) //sign extend
	begin
		if(imm[15]==0)
			ext_imm = {16'b0,imm[15:0]};
		else	
			ext_imm = {16'hffff,imm[15:0]};	
	end
	else //zero extend
	begin
		ext_imm = {16'b0,imm[15:0]};
	end
end


endmodule
