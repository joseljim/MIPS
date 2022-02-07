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
 