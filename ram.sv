module ram#(parameter DATA_SIZE=32,parameter SELEC_SIZE=16, parameter ADDRESSES=256)
	   (input logic clk,
	    input logic dm_we,
	    input logic [SELEC_SIZE-1:0] dm_address,
	    input logic [DATA_SIZE-1:0] dm_d,
	    output logic [DATA_SIZE-1:0] dm_q);
				
logic [DATA_SIZE-1:0] mem [ADDRESSES-1:0];
				
				
always_ff @(posedge clk) 
begin
	if (dm_we)
	begin
		mem[dm_address] <= dm_d;
	end
end
				
always_comb 
begin
	dm_q = mem[dm_address];
end

endmodule
