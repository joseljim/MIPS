module rom#(parameter DATA_SIZE=32,parameter SELEC_SIZE=32, parameter ADDRESSES=65536)
	    (input logic [SELEC_SIZE-1:0] rom_address,
	    output logic [DATA_SIZE-1:0] rom_out);
				
logic [DATA_SIZE-1:0] mem [ADDRESSES-1:0];
				
		
always_comb 
begin
	rom_out = mem[rom_address];
end

endmodule
