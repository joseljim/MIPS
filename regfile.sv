/*
MIT License

Copyright (c) 2022 José Luis Jiménez Arévalo, Eduardo García Olmos, Luis Alfredo Aceves Astengo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
