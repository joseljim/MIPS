//---------------------------------------------------------------------------------------------------//
// MIT License
//
// Copyright (c) 2022 José Luis Jiménez Arévalo, Eduardo García Olmos and Luis Alfredo Aceves Astengo
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

module mips_pipeline_tb;

logic clk;


mips_pipeline dut_mips
	 (.clk(clk)
	);

initial begin
	
	//important initializations
	mips_pipeline_tb.dut_mips.pc = 0;	
	mips_pipeline_tb.dut_mips.regfile0.mem[0] = 0;

	//LLI useful to load numbers in registers
	/*mips_pipeline_tb.dut_mips.rom0.mem[0]={LLI,5'd0,5'd1,16'd10}; //R1 = 10
	mips_pipeline_tb.dut_mips.rom0.mem[1]={LLI,5'd0,5'd2,16'd20}; //R2 = 20
	//LUI can help to load negative numbers
	mips_pipeline_tb.dut_mips.rom0.mem[2]={LUI,5'd0,5'd6,16'b1111111111111111}; //R6 = 16 ones and 16 zeroes
	mips_pipeline_tb.dut_mips.rom0.mem[3]={LUI,5'd0,5'd7,16'b1111111100000000}; //R7 = 8 ones and 24 zeroes
	//More loads to make time for LUIs to be ready
	mips_pipeline_tb.dut_mips.rom0.mem[4]={LLI,5'd0,5'd3,16'd30}; //R3 = 30
	mips_pipeline_tb.dut_mips.rom0.mem[5]={LLI,5'd0,5'd4,16'd40}; //R4 = 40
	mips_pipeline_tb.dut_mips.rom0.mem[6]={LLI,5'd0,5'd5,16'd50}; //R5 = 50
 	//Some arithmetic
 	mips_pipeline_tb.dut_mips.rom0.mem[7]={RTYPE,5'd1,5'd6,5'd8,5'd0,2'b0,ALU_ADD}; //R8 = R1 + R6 should be negative
	mips_pipeline_tb.dut_mips.rom0.mem[8]={RTYPE,5'd2,5'd7,5'd9,5'd0,2'b0,ALU_SUB}; //R9 = R2 - R7 should be positive
	//Now with immediates
	mips_pipeline_tb.dut_mips.rom0.mem[9]={ADDI,5'd3,5'd10,16'b1111111111111111}; //R10 = R3 + (-1)
	mips_pipeline_tb.dut_mips.rom0.mem[10]={SUBI,5'd4,5'd11,16'd80}; //R11 = R4 - (80)
	//Bitwise operations
	mips_pipeline_tb.dut_mips.rom0.mem[11]={RTYPE,5'd6,5'd7,5'd12,5'd0,2'b0,ALU_AND}; // R12 = R6 and R7, should be R7 (8 ones and 24 zeroes) 
	mips_pipeline_tb.dut_mips.rom0.mem[12]={RTYPE,5'd6,5'd7,5'd13,5'd0,2'b0,ALU_OR}; //R13 = R6 or R7, should be R6 (16 ones and 16 zeroes)
	mips_pipeline_tb.dut_mips.rom0.mem[13]={RTYPE,5'd6,5'd7,5'd14,5'd0,2'b0,ALU_XOR}; //R14 = R6 xor R7, should be 8 zeroes 8 ones and 16 zeroes
	mips_pipeline_tb.dut_mips.rom0.mem[14]=0; //STALL for XOR to be completed
	mips_pipeline_tb.dut_mips.rom0.mem[15]={BNE,5'd8,5'd9,16'd30}; //we know R8 != R9 so branch must follow
	mips_pipeline_tb.dut_mips.rom0.mem[16]=0; //Some STALL to wait for branch (assuming smart compiler)
	mips_pipeline_tb.dut_mips.rom0.mem[17]=0; //STALL
	//BEQ returns here
	mips_pipeline_tb.dut_mips.rom0.mem[18]={LWR,5'd5,5'd18,16'd0}; //R18 = Mem[R5] = Mem[50]
	mips_pipeline_tb.dut_mips.rom0.mem[19]={LWI,5'd0,5'd19,16'd51}; //R19 = Mem[51]
	mips_pipeline_tb.dut_mips.rom0.mem[20]={JAL,26'd40};
	//RET gets us here
	mips_pipeline_tb.dut_mips.rom0.mem[21]=0; //STALL for JAL to complete
	mips_pipeline_tb.dut_mips.rom0.mem[22]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[23]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[24]={RTYPE,5'd4,5'd5,5'd24,5'd0,2'b0,ALU_ADD}; //R24 = R4 + R5; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[25]=0; //STALL for ADD to be done before JUMP
	mips_pipeline_tb.dut_mips.rom0.mem[26]={J,26'd50};
	mips_pipeline_tb.dut_mips.rom0.mem[27]=0;
	mips_pipeline_tb.dut_mips.rom0.mem[28]=0;
	mips_pipeline_tb.dut_mips.rom0.mem[29]=0;
	//BNE returns here	
	mips_pipeline_tb.dut_mips.rom0.mem[30]={SWR,5'd5,5'd2,16'd0}; //Mem[R5]=Mem[50]=R2  
	mips_pipeline_tb.dut_mips.rom0.mem[31]={SWI,5'd0,5'd3,16'd51}; //Mem[51]=R3
	//More instructions for Stores to be ready
	//R1 = 10 = 1010 (binary)
	mips_pipeline_tb.dut_mips.rom0.mem[32]={ANDI,5'd1,5'd15,16'd128}; //we should get a 0
	mips_pipeline_tb.dut_mips.rom0.mem[33]={ORI,5'd1,5'd16,16'd2000}; //we should get a 2010
	mips_pipeline_tb.dut_mips.rom0.mem[34]={XORI,5'd1,5'd17,16'd5}; //we should get a 15
	mips_pipeline_tb.dut_mips.rom0.mem[35]=0; //STALL for XOR to be completed before BEQ
	mips_pipeline_tb.dut_mips.rom0.mem[36]={BEQ,5'd6,5'd13,16'd18};//we know R6 = R13 so branch must follow
	mips_pipeline_tb.dut_mips.rom0.mem[37]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[38]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[39]=0; //STALL
	//JAL gets here
	//left shifts should look the same
	mips_pipeline_tb.dut_mips.rom0.mem[40]={RTYPE,5'd0,5'd13,5'd20,5'd2,2'b0,ALU_SLL};
	mips_pipeline_tb.dut_mips.rom0.mem[41]={RTYPE,5'd0,5'd13,5'd21,5'd2,2'b0,ALU_SLA};
	//right arithmetic shift keeps sign
	mips_pipeline_tb.dut_mips.rom0.mem[42]={RTYPE,5'd0,5'd13,5'd22,5'd4,2'b0,ALU_SRL};
	mips_pipeline_tb.dut_mips.rom0.mem[43]={RTYPE,5'd0,5'd13,5'd23,5'd4,2'b0,ALU_SRA};
	mips_pipeline_tb.dut_mips.rom0.mem[44]= 0; //STALL for SRA to be completed 
	mips_pipeline_tb.dut_mips.rom0.mem[45]={RET,26'd0}; //should return to ins 21
	mips_pipeline_tb.dut_mips.rom0.mem[46]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[47]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[48]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[49]=0;
	//END
	mips_pipeline_tb.dut_mips.rom0.mem[50]={J,26'd50};
	mips_pipeline_tb.dut_mips.rom0.mem[51]=0; //STALL
	mips_pipeline_tb.dut_mips.rom0.mem[52]=0;
	mips_pipeline_tb.dut_mips.rom0.mem[53]=0;*/

	//ROM loaded from file
	$readmemb("general_rom.dat", mips_pipeline_tb.dut_mips.rom0.mem);
end

always begin
	clk = 0;
	#5ns;
	clk = 1;
	#5ns;
end

endmodule
