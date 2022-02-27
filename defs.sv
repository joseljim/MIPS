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

package definitions;

//opcodes
typedef enum logic[5:0]{
 RTYPE = 6'b000000,
 ADDI = 6'b000001,
 SUBI = 6'b000010,
 ANDI = 6'b000011,
 ORI = 6'b000100,
 XORI = 6'b000101,
 LUI = 6'b000110,
 LLI = 6'b000111,
 LWR = 6'b001000,
 SWR = 6'b001001,
 LWI = 6'b001010,
 SWI = 6'b001011,
 BEQ = 6'b001100,
 BNE = 6'b001101,
 J = 6'b001110,
 JAL = 6'b001111,
 RET = 6'b010000, 
 BNEG = 6'b010001 //added to support multiplication, treated a I-typr
} opcode;


//ALU operations
typedef enum logic[3:0]{
 ALU_ADD = 4'b0000,
 ALU_SUB = 4'b0001,
 ALU_AND = 4'b0010,
 ALU_OR = 4'b0011,
 ALU_XOR = 4'b0100,
 ALU_SLL = 4'b0101,
 ALU_SRL = 4'b0110,
 ALU_SLA = 4'b0111,
 ALU_SRA = 4'b1000,
 ALU_LUI = 4'b1001,
 ALU_LLI = 4'b1010,
 ALU_NOT = 4'b1011, //added to support multiplication, will be treated as R-type
 ALU_Z = 'z
} operation;

endpackage
