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

module controller
		#(parameter FUNC_SIZE=6)
		(input opcode op,
		 input logic[FUNC_SIZE-1:0] func,
		 output logic rf_we,
		 output logic sel_op_a,
		 output logic sel_op_b,
		 output logic zero_or_sign,
		 output logic [1:0] rd_sel,
		 output logic [1:0] rf_data_sel,
		 output logic mem_ad_sel,
		 output logic dm_we,
		 output logic beq,
		 output logic bne,
		 output logic[2:0] pc_sel, //extra bit to support mult (bneg)
		 output logic rs_sel
		 );
always_comb
begin
	case(op)
		//Rtype	
		RTYPE:
		begin
			//op b comes from RF
			sel_op_b = 0;
			//all Rtype write to reg fil	
			rf_we = 1;
			//instruction is a shift
			if(func==5 || func==6 || func==7 || func==8)
				sel_op_a = 1;
			else
				sel_op_a = 0;
			//we dont use an imm
			zero_or_sign='z;
			//rd=[15:11]from instruction
			rd_sel = 0;
			//data from alu result
			rf_data_sel = 0;
			//no mem used
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//ADDI	
		ADDI:
		begin
			sel_op_a = 0;
			sel_op_b = 1;
			rf_we = 1;
			zero_or_sign = 1;
			rd_sel = 1;
			rf_data_sel = 0;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//SUBI
		SUBI:
		begin
			sel_op_a = 0;
			sel_op_b = 1;
			rf_we = 1;
			zero_or_sign = 1;
			rd_sel = 1;
			rf_data_sel = 0;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//ANDI
		ANDI:
		begin
			sel_op_a = 0;
			sel_op_b = 1;
			rf_we = 1;
			zero_or_sign = 0;
			rd_sel = 1;
			rf_data_sel = 0;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//ORI
		ORI:
		begin
			sel_op_a = 0;
			sel_op_b = 1;
			rf_we = 1;
			zero_or_sign = 0;
			rd_sel = 1;
			rf_data_sel = 0;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//XORI
		XORI:
		begin
			sel_op_a = 0;
			sel_op_b = 1;
			rf_we = 1;
			zero_or_sign = 0;
			rd_sel = 1;
			rf_data_sel = 0;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//LUI
		LUI:
		begin
			sel_op_a = 'z;
			sel_op_b = 1;
			rf_we = 1;
			zero_or_sign = 0; //just for the alu to receive 32 bits
			rd_sel = 1;
			rf_data_sel = 0;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//LLI
		LLI:
		begin
			sel_op_a = 'z;
			sel_op_b = 1;
			rf_we = 1;
			zero_or_sign = 0; //just for the alu to receive 32 bits
			rd_sel = 1;
			rf_data_sel = 0;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//LWR
		LWR:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 1;
			zero_or_sign = 'z;
			rd_sel = 1;
			rf_data_sel = 1;
			dm_we = 0;
			mem_ad_sel = 0;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//SWR
		SWR:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 1;
			mem_ad_sel = 0;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//LWI
		LWI:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 1;
			zero_or_sign = 'z;
			rd_sel = 1;
			rf_data_sel = 1;
			dm_we = 0;
			mem_ad_sel = 1;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//SWI
		SWI:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 1;
			mem_ad_sel = 1;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
		
		//BEQ
		BEQ:
		begin
			sel_op_a = 0;
			sel_op_b = 0;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 1;
			bne = 0;
			pc_sel = 1;
			rs_sel = 0;
		end
		
		//BNE
		BNE:
		begin
			sel_op_a = 0;
			sel_op_b = 0;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 1;
			pc_sel = 1;
			rs_sel = 0;
		end
		
		//J
		J:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 2;
			rs_sel = 0;
		end

		//JAL
		JAL:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 1;
			zero_or_sign = 'z;
			rd_sel = 2;
			rf_data_sel = 2;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 2;
			rs_sel = 0;
		end

		//RET
		RET:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 3;
			rs_sel = 1;
		end
		//BNEG
		BNEG:
		begin
			sel_op_a = 0;
			sel_op_b = 0;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 4;
			rs_sel = 0;
		end
		default:
		begin
			sel_op_a = 'z;
			sel_op_b = 'z;
			rf_we = 0;
			zero_or_sign = 'z;
			rd_sel = 'z;
			rf_data_sel = 'z;
			dm_we = 0;
			mem_ad_sel = 'z;
			beq = 0;
			bne = 0;
			pc_sel = 0;
			rs_sel = 0;
		end
	endcase

end

endmodule
