# MIPS

The objective was to design and model a single-cycle MIPS with Interlocked Pipeline Stage. The design supports J-Type instructions, R-type instructions that are useful to make operations and save data between registers, I-type instructions to read write instructions from the data memory and J-type instructions to make program counter moves.

The designed architecture works as follows, first a controller that can read instructions and send flags to our diferent modules in order to enable MUX modules, decoders and logic gates to select the desired path for the data, an instruction decoder that selects the operation that must be done and sends that information to the ALU. The ALU is capable of doing a variety of operations and finally the register file of 32 directions that allows to move data between instructions.

## Encoding

<img width="641" alt="Screen Shot 2022-02-22 at 20 21 22" src="https://user-images.githubusercontent.com/78834111/155374385-96c7286f-befb-4d9e-989c-09afcb2b8177.png">

In addition to this, in order to add support for signed multiplication, the following instructions were added

* BNEG: Branch on negative. Treated as an I-type instruction with opcode **010001**, it changes the program counter to an immediate value if a register’s value is less than 0. A negative flag in the ALU was also implemented for this instruction to work. This instruction was used to handle the cases when a multiplication operand was negative.

* NOT: Not. Treated as an R-type instruction with func **001011**, it performs a bitwise not to a register’s value, and stores it in a register. This instruction was used to change a number’s sign in two’s complement format.


## RTL View

<img width="1359" alt="Screen Shot 2022-02-22 at 20 07 49" src="https://user-images.githubusercontent.com/78834111/155250713-8acd1de4-5dc0-4f93-8a6c-a31e64a24dbc.png">

## Schematic

<img width="1726" alt="Screen Shot 2022-02-22 at 20 00 34" src="https://user-images.githubusercontent.com/78834111/155250841-bc3051fd-4498-41da-807b-7258b3e00f58.png">

