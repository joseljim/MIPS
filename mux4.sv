module mux4
	#(parameter DATA_SIZE=32)
	(input logic[DATA_SIZE-1:0] inA,
	input logic[DATA_SIZE-1:0] inB,
	input logic[DATA_SIZE-1:0] inC,
	input logic[DATA_SIZE-1:0] inD,
	input logic[1:0] select,
	output logic[DATA_SIZE-1:0] out);

always_comb
begin
	case(select)
	2'd0: out = inA;
	2'd1: out = inB;
	2'd2: out = inC;
	2'd3: out = inD;
	default: out = inA;
	endcase
end

endmodule
