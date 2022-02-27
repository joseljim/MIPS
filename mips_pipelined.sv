//---------------------------------------------------------------------------------------------------//
// MIT License
//
// Copyright (c) 2022 José Luis Jiménez Arévalo, Eduardo García Olmos, Luis Alfredo Aceves Astengo
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//---------------------------------------------------------------------------------------------------//

import definitions::*;

module mips_pipeline
	#(parameter INS_SIZE=32)
	 (input logic clk
	 );

logic[INS_SIZE-1:0] instruction;
logic[INS_SIZE-1:0] instruction2;

logic[31:0] dm_q;
logic[31:0] dm_q2;

logic dm_we;
logic dm_we2;
logic dm_we3;

logic [15:0] dm_address;
logic [15:0] dm_address2;

logic [31:0] dm_d;

logic[31:0] pc;
logic[31:0] pc2;
logic[31:0] pc3;
logic[31:0] pc4;
logic[31:0] pc5;

//data memory
ram ram0
	   (.clk(clk),
	    .dm_we(dm_we3),
	    .dm_address(dm_address2),
	    .dm_d(dm_d),
	    .dm_q(dm_q)
	);
//instruction memory
rom rom0
	(.rom_address(pc),
	  .rom_out(instruction)
	);


opcode ins_op;
logic[4:0] ins_rs;

logic[4:0] ins_rt;
logic[4:0] ins_rt2;
logic[4:0] ins_rt3;
logic[4:0] ins_rt4;

logic[4:0] ins_rd;
logic[4:0] ins_rd2;
logic[4:0] ins_rd3;
logic[4:0] ins_rd4;

logic[4:0] ins_sa;
logic[5:0] ins_func;

logic[15:0] ins_imm;
logic[15:0] ins_imm2;
logic[15:0] ins_imm3;

operation alu_op;
operation alu_op2;

logic rf_we;
logic rf_we2;
logic rf_we3;
logic rf_we4;

logic sel_op_a;
logic sel_op_a2;
logic sel_op_b;
logic sel_op_b2;

logic zero_or_sign;

logic [1:0]rd_sel;
logic [1:0]rd_sel2;
logic [1:0]rd_sel3;
logic [1:0]rd_sel4;

logic [1:0]rf_data_sel;
logic [1:0]rf_data_sel2;
logic [1:0]rf_data_sel3;
logic [1:0]rf_data_sel4;

logic mem_ad_sel;
logic mem_ad_sel2;

logic[31:0] operandA;
logic[31:0] operandB;

logic[31:0] result;
logic[31:0] result2;
logic[31:0] result3;

logic zero;
logic zero2;

logic[31:0] ext_sa;
logic[31:0] ext_sa2;

logic[31:0] ext_imm;
logic[31:0] ext_imm2;

logic[31:0] Qs;
logic[31:0] Qs2;
logic[31:0] Qs3;

logic[31:0] Qt;
logic[31:0] Qt2;

logic[31:0] D;
logic[4:0] rd;

logic beq;
logic beq2;
logic beq3;

logic bne;
logic bne2;
logic bne3;

logic[31:0] next_pc;

logic[2:0] pc_sel;
logic[2:0] pc_sel2;
logic[2:0] pc_sel3;

logic[25:0] ins_addr;
logic[25:0] ins_addr2;
logic[25:0] ins_addr3;

logic rs_sel;
logic [4:0]rs;

logic negative;
logic negative2;


controller controller0
		(.op(ins_op),
		 .func(ins_func),
		 .rf_we(rf_we),
		 .sel_op_a(sel_op_a),
		 .sel_op_b(sel_op_b),
		 .zero_or_sign(zero_or_sign),
		 .rd_sel(rd_sel),
		 .rf_data_sel(rf_data_sel),
		 .mem_ad_sel(mem_ad_sel),
		 .dm_we(dm_we),
		 .beq(beq),
		 .bne(bne),
		 .pc_sel(pc_sel),
		 .rs_sel(rs_sel)
		 );
regfile regfile0
	 (.rs(rs),
	  .rt(ins_rt),
	  .rd(rd),
	  .D(D),
	  .we(rf_we4),
	  .clk(clk),
	  .Qs(Qs),
	  .Qt(Qt)
	 );
alu alu0
	 (.a(operandA),
	  .b(operandB),
	  .op(alu_op2),
	  .r(result),
	  .z(zero),
	  .n(negative)
	);
extender extender0
	(.sa(ins_sa),
	 .imm(ins_imm),
	 .zero_or_sign(zero_or_sign),
	 .ext_sa(ext_sa),
	 .ext_imm(ext_imm) 
	);
instruction_decoder instruction_decoder0
	 (.op(ins_op),
	  .func(ins_func),
	  .alu_op(alu_op)
	 );
//muxes
mux2 #(.DATA_SIZE(32)) //operandA = (sel_op_a) ? ext_sa : Qs;
operandA_mux 	
(.inA(Qs2),
.inB(ext_sa2),
.select(sel_op_a2),
.out(operandA));

mux2 #(.DATA_SIZE(32)) //operandB = (sel_op_b) ? ext_imm : Qt;
operandB_mux 	
(.inA(Qt2),
.inB(ext_imm2),
.select(sel_op_b2),
.out(operandB));

mux2 #(.DATA_SIZE(16)) //dm_address = (mem_ad_sel) ? ins_imm : Qs;
dm_address_mux	
(.inA(Qs2),
.inB(ins_imm2),
.select(mem_ad_sel2),
.out(dm_address));

mux2 #(.DATA_SIZE(5)) //rs = (rs_sel) ? 5'd31 : ins_rs; 
rs_mux	
(.inA(ins_rs),
.inB(5'd31),
.select(rs_sel),
.out(rs));

//larger muxes
mux4 #(.DATA_SIZE(5))
rd_mux
(.inA(ins_rd4),
.inB(ins_rt4),
.inC(5'd31),
.inD(),
.select(rd_sel4),
.out(rd));

mux4 #(.DATA_SIZE(32))
D_mux
(.inA(result3),
.inB(dm_q2),
.inC(pc5+1),
.inD(),
.select(rf_data_sel4),
.out(D));

//next pc logic
next_pc_select next_pc_sel0(
	.pc_sel(pc_sel3),
	.zero(zero2),
	.beq(beq3),
	.bne(bne3),
	.negative(negative2),
	.pc(pc),
	.Qs(Qs3),
	.ins_addr(ins_addr3),
	.ins_imm(ins_imm3),
	.next_pc(next_pc));








always_comb
begin
	//wiring
	ins_op = opcode'(instruction2[31:26]);
	ins_rs = instruction2[25:21];
	ins_rt = instruction2[20:16];
	ins_rd = instruction2[15:11];
	ins_sa = instruction2[10:6];
	ins_func = instruction2[5:0];
	ins_imm = instruction2[15:0];
	ins_addr = instruction2[25:0];

end


always_ff@(posedge clk)
begin
	pc <= next_pc;
	
	pc2 <= pc;
	pc3 <= pc2;
	pc4 <= pc3;
	pc5 <= pc4;

	instruction2 <= instruction;

	alu_op2 <= alu_op;
	sel_op_a2 <= sel_op_a;
	sel_op_b2 <= sel_op_b;

	dm_we2 <= dm_we;
 	dm_we3 <= dm_we2;

	mem_ad_sel2 <= mem_ad_sel;

	rf_we2 <= rf_we;
	rf_we3 <= rf_we2;
	rf_we4 <= rf_we3;

	rf_data_sel2 <= rf_data_sel;
	rf_data_sel3 <= rf_data_sel2;
	rf_data_sel4 <= rf_data_sel3;

	rd_sel2 <= rd_sel;
	rd_sel3 <= rd_sel2;
	rd_sel4 <= rd_sel3;

	ins_rt2 <= ins_rt;
	ins_rt3 <= ins_rt2;
	ins_rt4 <= ins_rt3;

	ins_rd2 <= ins_rd;
	ins_rd3 <= ins_rd2;
	ins_rd4 <= ins_rd3;

	Qt2 <= Qt;
	dm_d <= Qt2;

	ext_sa2 <= ext_sa;
	ext_imm2 <= ext_imm;

	result2 <= result;
	result3 <= result2;

	dm_q2 <= dm_q;

	pc_sel2 <= pc_sel;
	pc_sel3 <= pc_sel2;

	beq2 <= beq;
	beq3 <= beq2;

	bne2 <= bne;
	bne3 <= bne2;

	ins_addr2 <= ins_addr;
	ins_addr3 <= ins_addr2;

	Qs2 <= Qs;
	Qs3 <= Qs2;

	ins_imm2 <= ins_imm;
	ins_imm3 <= ins_imm2;

	zero2 <= zero;
	negative2 <= negative;

	dm_address2 <= dm_address;
end


endmodule


