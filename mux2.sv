module mux2
	#(parameter DATA_SIZE=32)
	(input logic[DATA_SIZE-1:0] inA,
	input logic[DATA_SIZE-1:0] inB,
	input logic select,
	output logic[DATA_SIZE-1:0] out);

always_comb
begin
	if(select)
		out = inB;
	else
		out = inA;
end

endmodule
