module regfile
	#(parameter DATA_SIZE=32, parameter SELEC_SIZE=5, parameter ADDRESSES=32)
	 (input logic[SELEC_SIZE-1:0] rs,
	  input logic[SELEC_SIZE-1:0] rt,
	  input logic[SELEC_SIZE-1:0] rd,
	  input logic[DATA_SIZE-1:0] D,
	  input logic we,
	  input logic clk,
	  output logic[DATA_SIZE-1:0] Qs,
	  output logic[DATA_SIZE-1:0] Qt
	 );

logic [DATA_SIZE-1:0] mem [ADDRESSES-1:0];

always_ff@(posedge clk) 
begin
    if(we)
    begin
        if(rd != 0)
		mem[rd] <= D;
    end
end

always_comb 
begin
    Qs = mem[rs];
    Qt = mem[rt];
end

endmodule
