
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
