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
