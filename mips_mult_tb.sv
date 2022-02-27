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

module mips_mult_tb;

logic clk;

mips_pipeline dut_mips
	 (.clk(clk)
	 );

initial begin
	//Needed initializations
	mips_mult_tb.dut_mips.pc = 0;
	mips_mult_tb.dut_mips.regfile0.mem[0] = 0;
	//Numbers to multiply
	mips_mult_tb.dut_mips.ram0.mem[0] = 6; //A
	mips_mult_tb.dut_mips.ram0.mem[1] = -7; //B
	mips_mult_tb.dut_mips.ram0.mem[2] = 0; //R
	
	/*=============================================
	=========FIRST APPROACH: LONGER STALLS =======
	=============================================*/
	//ROM code
	/*mips_mult_tb.dut_mips.rom0.mem[0] = {LWI,5'd0,5'd1,16'd0}; //A
	mips_mult_tb.dut_mips.rom0.mem[1] = {LWI,5'd0,5'd2,16'd1}; //B
	mips_mult_tb.dut_mips.rom0.mem[2] = {LWI,5'd0,5'd3,16'd2}; //R
	mips_mult_tb.dut_mips.rom0.mem[3] = 0; //STALL wait for B (R2) ready
	mips_mult_tb.dut_mips.rom0.mem[4] = 0; 
	mips_mult_tb.dut_mips.rom0.mem[5] = 0;
	mips_mult_tb.dut_mips.rom0.mem[6] = {BNEG,5'd2,5'd0,16'd25}; //Branch if B negative
	mips_mult_tb.dut_mips.rom0.mem[7] = 0; //STALL wait for branch ready
	mips_mult_tb.dut_mips.rom0.mem[8] = 0;
	mips_mult_tb.dut_mips.rom0.mem[9] = 0;
	//Multiplication algorithm (for loop)
	mips_mult_tb.dut_mips.rom0.mem[10] = {RTYPE,5'd1,5'd3,5'd3,5'd0,2'b0,ALU_ADD};
	mips_mult_tb.dut_mips.rom0.mem[11] = {SUBI,5'd2,5'd2,16'd1};
	mips_mult_tb.dut_mips.rom0.mem[12] = 0; //STALL wait for jump
	mips_mult_tb.dut_mips.rom0.mem[13] = 0;
	mips_mult_tb.dut_mips.rom0.mem[14] = 0;
	mips_mult_tb.dut_mips.rom0.mem[15] = 0;
	mips_mult_tb.dut_mips.rom0.mem[16] = {BNE,5'd0,5'd2,16'd10};
	mips_mult_tb.dut_mips.rom0.mem[17] = 0; //STALL wait for branch ready
	mips_mult_tb.dut_mips.rom0.mem[18] = 0;
	mips_mult_tb.dut_mips.rom0.mem[19] = 0;
	mips_mult_tb.dut_mips.rom0.mem[20] = {SWI,5'd0,5'd3,16'd2};
	mips_mult_tb.dut_mips.rom0.mem[21] = {J,26'd36};
	mips_mult_tb.dut_mips.rom0.mem[22] = 0; //STALL wait for jump
	mips_mult_tb.dut_mips.rom0.mem[23] = 0;
	mips_mult_tb.dut_mips.rom0.mem[24] = 0;
	//If B is negative and A positive, we need to switch signs for the algorithm to work 
	//(we need B positive and A negative to keep the sign). On the other side, if both are negative,
	//we need to change both signs to multiply them as positives. Either way, we change both signs.
	//Change A and B sign
	mips_mult_tb.dut_mips.rom0.mem[25] = {RTYPE,5'd2,5'd0,5'd2,5'd0,2'b0,ALU_NOT}; //NOT B
	mips_mult_tb.dut_mips.rom0.mem[26] = {RTYPE,5'd1,5'd0,5'd1,5'd0,2'b0,ALU_NOT}; //NOT A
	mips_mult_tb.dut_mips.rom0.mem[27] = 0; //STALL wait for B read
	mips_mult_tb.dut_mips.rom0.mem[28] = 0;
	mips_mult_tb.dut_mips.rom0.mem[29] = 0;
	mips_mult_tb.dut_mips.rom0.mem[30] = {ADDI,5'd2,5'd2,16'd1}; //NOT B + 1
	mips_mult_tb.dut_mips.rom0.mem[31] = {ADDI,5'd1,5'd1,16'd1}; //NOT A + 1
	mips_mult_tb.dut_mips.rom0.mem[32] = {J,26'd11};
	mips_mult_tb.dut_mips.rom0.mem[33] = 0; //STALL wait for jump
	mips_mult_tb.dut_mips.rom0.mem[34] = 0;
	mips_mult_tb.dut_mips.rom0.mem[35] = 0;
	//END
	mips_mult_tb.dut_mips.rom0.mem[36] = {J,26'd36};
	mips_mult_tb.dut_mips.rom0.mem[37] = 0; //STALL wait for jump
	mips_mult_tb.dut_mips.rom0.mem[38] = 0;
	mips_mult_tb.dut_mips.rom0.mem[39] = 0;*/

	/*=============================================
	=========SECOND APPROACH: SHORTER STALLS =======
	=============================================*/
	//ROM code
	/*mips_mult_tb.dut_mips.rom0.mem[0] = {LWI,5'd0,5'd1,16'd0}; //A
	mips_mult_tb.dut_mips.rom0.mem[1] = {LWI,5'd0,5'd2,16'd1}; //B
	mips_mult_tb.dut_mips.rom0.mem[2] = {LWI,5'd0,5'd3,16'd2}; //R
	mips_mult_tb.dut_mips.rom0.mem[3] = 0; //STALL wait for B (R2) ready
	mips_mult_tb.dut_mips.rom0.mem[4] = 0; 
	mips_mult_tb.dut_mips.rom0.mem[5] = {BNEG,5'd2,5'd0,16'd23}; //Branch if B negative
	mips_mult_tb.dut_mips.rom0.mem[6] = 0; //STALL wait for branch ready
	mips_mult_tb.dut_mips.rom0.mem[7] = 0;
	mips_mult_tb.dut_mips.rom0.mem[8] = 0;
	//Multiplication algorithm (for loop)
	mips_mult_tb.dut_mips.rom0.mem[9] = {RTYPE,5'd1,5'd3,5'd3,5'd0,2'b0,ALU_ADD};
	mips_mult_tb.dut_mips.rom0.mem[10] = {SUBI,5'd2,5'd2,16'd1};
	mips_mult_tb.dut_mips.rom0.mem[11] = 0; //STALL 
	mips_mult_tb.dut_mips.rom0.mem[12] = 0;
	mips_mult_tb.dut_mips.rom0.mem[13] = 0;
	mips_mult_tb.dut_mips.rom0.mem[14] = {BNE,5'd0,5'd2,16'd9};
	mips_mult_tb.dut_mips.rom0.mem[15] = 0; //STALL wait for branch ready
	mips_mult_tb.dut_mips.rom0.mem[16] = 0;
	mips_mult_tb.dut_mips.rom0.mem[17] = 0;
	mips_mult_tb.dut_mips.rom0.mem[18] = {SWI,5'd0,5'd3,16'd2};
	mips_mult_tb.dut_mips.rom0.mem[19] = {J,26'd33};
	mips_mult_tb.dut_mips.rom0.mem[20] = 0; //STALL wait for jump
	mips_mult_tb.dut_mips.rom0.mem[21] = 0;
	mips_mult_tb.dut_mips.rom0.mem[22] = 0;
	//If B is negative and A positive, we need to switch signs for the algorithm to work 
	//(we need B positive and A negative to keep the sign). On the other side, if both are negative,
	//we need to change both signs to multiply them as positives. Either way, we change both signs.
	//Change A and B sign
	mips_mult_tb.dut_mips.rom0.mem[23] = {RTYPE,5'd2,5'd0,5'd2,5'd0,2'b0,ALU_NOT}; //NOT B
	mips_mult_tb.dut_mips.rom0.mem[24] = {RTYPE,5'd1,5'd0,5'd1,5'd0,2'b0,ALU_NOT}; //NOT A
	mips_mult_tb.dut_mips.rom0.mem[25] = 0; //STALL wait for B ready
	mips_mult_tb.dut_mips.rom0.mem[26] = 0;
	mips_mult_tb.dut_mips.rom0.mem[27] = {ADDI,5'd2,5'd2,16'd1}; //NOT B + 1
	mips_mult_tb.dut_mips.rom0.mem[28] = {ADDI,5'd1,5'd1,16'd1}; //NOT A + 1
	//new
	//mips_mult_tb.dut_mips.rom0.mem[29] = 0;
	//mips_mult_tb.dut_mips.rom0.mem[30] = 0;
	mips_mult_tb.dut_mips.rom0.mem[29] = {J,26'd9};
	mips_mult_tb.dut_mips.rom0.mem[30] = 0; //STALL wait for jump
	mips_mult_tb.dut_mips.rom0.mem[31] = 0;
	mips_mult_tb.dut_mips.rom0.mem[32] = 0;
	//END
	mips_mult_tb.dut_mips.rom0.mem[33] = {J,26'd33};
	mips_mult_tb.dut_mips.rom0.mem[34] = 0; //STALL wait for jump
	mips_mult_tb.dut_mips.rom0.mem[35] = 0;
	mips_mult_tb.dut_mips.rom0.mem[36] = 0;*/


	//ROM loaded from file
	$readmemb("mult_rom.dat", mips_mult_tb.dut_mips.rom0.mem);
end

always begin
	clk = 0;
	#5ns;
	clk = 1;
	#5ns;
end

endmodule
