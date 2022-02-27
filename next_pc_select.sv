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

module next_pc_select(
	input logic[2:0] pc_sel,
	input logic zero,
	input logic beq,
	input logic bne,
	input logic negative,
	input logic [31:0] pc,
	input logic [31:0] Qs,
	input logic [25:0] ins_addr,
	input logic [15:0] ins_imm,
	output logic [31:0] next_pc);

always_comb
begin
	case(pc_sel)
		0:
		begin
			next_pc = pc +1;
		end
		1:
		begin
			if(beq)
			begin
				if(zero)
					next_pc = {16'b0,ins_imm};
				else
					next_pc = pc+1;
			end
			else
			begin
				if(bne)
				begin
					if(~(zero))
						next_pc = {16'b0,ins_imm};
					else
						next_pc = pc+1;
				end
				else
					next_pc = pc+1;
			end
		end
		2:
		begin
			next_pc = {6'b0,ins_addr};
		end
		3:
		begin
			next_pc = Qs;
		end
		4: //branch on negative
		begin
			if(negative)
				next_pc = {16'b0,ins_imm};
			else
				next_pc = pc+1;
		end
		default:
			next_pc = pc+1;
	endcase
end

endmodule
