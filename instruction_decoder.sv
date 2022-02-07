import definitions::*;

module instruction_decoder
	#(parameter FUNC_SIZE=6)
	 (input opcode op,
	  input logic[FUNC_SIZE-1:0] func,
	  output operation alu_op
	 );

always_comb
begin
	case(op)
		//Rtype	
		RTYPE:
		begin
			alu_op = operation'(func[3:0]);
		end
		
		//ADDI	
		ADDI:
		begin
			alu_op = ALU_ADD; //alu add
		end
		
		//SUBI
		SUBI:
		begin
			alu_op = ALU_SUB; //alu sub
		end
		
		//ANDI
		ANDI:
		begin
			alu_op = ALU_AND; //alu and
		end
		
		//ORI
		ORI:
		begin
			alu_op = ALU_OR; //alu or
		end
		
		//XORI
		XORI:
		begin
			alu_op = ALU_XOR; //alu xor
		end
		
		//LUI
		LUI:
		begin
			alu_op = ALU_LUI; //alu lui
		end
		
		//LLI
		LLI:
		begin
			alu_op = ALU_LLI; //alu lli
		end
		
		//LWR
		LWR:
		begin
			alu_op = ALU_Z;
		end
		
		//SWR
		SWR:
		begin
			alu_op = ALU_Z;
		end
		
		//LWI
		LWI:
		begin
			alu_op = ALU_Z;
		end
		
		//SWI
		SWI:
		begin
			alu_op = ALU_Z;
		end
		
		//BEQ
		BEQ:
		begin
			alu_op = ALU_SUB; //alu sub
		end
		
		//BNE
		BNE:
		begin
			alu_op = ALU_SUB; //alu sub
		end
		
		//J
		J:
		begin
			alu_op = ALU_Z; //alu sub
		end
		
		//JAL
		JAL:
		begin
			alu_op = ALU_Z; //alu sub
		end
		
		//RET
		RET:
		begin
			alu_op = ALU_Z; //alu sub
		end

		//BNEG
		BNEG:
		begin
			alu_op = ALU_ADD; //add number to check with 0 to see if negative
		end
		
		default:
			alu_op = ALU_Z;
	endcase	
end

endmodule

