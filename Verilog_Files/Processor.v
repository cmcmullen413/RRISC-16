module Processor(
    input wire clk,
    input wire reset
);

//  PC Register
// Updates every falling edge with the new value
Register PC(
    .d(pcSrcMux.out),
    .clk(~clk),
    .we(1'b1),
    .reset(reset),
    .q()
);


// Instruction Memory
// Reads the new instruction every posedge
Instr_Memory instrMem(
    .addr(PC.q[7:0]), // Only need an 8 bit address
    .clk(clk),
    .out()
);


// Control Unit
// Takes the Opcode and generates all the control lines
Control control(
    .opcode(instrMem.out[2:0]),
    .regWrite(),
    .memRead(),
    .memWrite(),
    .ALUSrc(),
    .ALUOp(),
    .branch(),
    .jump(),
    .jumpReg(),
    .regSrc(),
    .lurd()
);


// Combine the rd and loadUpperRd into the destination register
wire [2:0] writeReg;
assign writeReg = {instrMem.out[5]|control.lurd, instrMem.out[4:3]}

// Register File
// Asyncronusly reads rs1 and rs2
// Writes into writeReg on the posedge if we is high
Reg_File regFile(
    .rs1(instrMem.out[8:6]),
    .data_a(),
    .rs2(instrMem.out[11:9]),
    .data_b(),
    .rd(writeReg),
    .write_data(regSrcMux.out),
    .we(control.regWrite),
    .clk(clk),
    .reset(reset)
);


// Immediate Generator
// Generates the correct immediate based on the opcode and immediate fields
Imm_Gen immGen(
    .instr(instrMem.out),
    .imm()
);


// Generates the control bits to decide the ALU's operation
// ALU funct is based on control's ALUOp, f2, and fr
ALU_Control aluControl(
    .ALUOp(control.ALUOp),
    .f2(instrMem.out[15:14]),
    .fr(instrMem.out[13]),
    .ALUfunct()
);

// The ALU
// Does aritmatic logic stuff
ALU alu(
    .a(regFile.data_a),
    .b(aluSrcMux.out),
    .out(),
    .zero(),
    .funct(aluControl.ALUfunct)
);


// Branch Detection Unit
// Output is combined with the jump signal to control if PC goes to PC+1 or to PC+IMM
Branch_Detect branchDetect(
    .branch(control.branch),
    .zero(alu.zero),
    .msb(alu.out[15]),
    .f2(instrMem.out[15:14]),
    .branchControl()
);


// PC Source Muxes
// First one chooses between pc+1 and pc+imm
//  Controlled by branchControl | jump
// Second one chooses between the first output and reg_a+imm
//  Controlled by jumpReg
Mux_2to1 branchJumpMux(
    .in_0(PC.q + 1),
    .in_1(PC.q + immGen.imm),
    .control(branchDetect.branchControl | control.jump),
    .out()
);
Mux_2to1 pcSrcMux(
    .in_0(branchJumpMux.out),
    .in_1(regFile.data_a + immGen.imm),
    .control(contro.jumpReg),
    .out()
);


// Data Memory
Data_Memory dataMem(
    .in(regFile.data_b),
    .addr(alu.out),
    .we(control.memWrite),
    .re(control.memRead),
    .out(),
    .clk(clk),
    .reset(reset)
);


// LinkAddr Register
// Holds the PC+1 value so it can be stored into rd of jump instructions
//   With out this, PC would update before it could be stored into the reg file
// Saves on the posedge
Register linkAddr(
    .d(PC.q + 1),
    .clk(clk),
    we(1'b1),
    reset(reset),
    .q()
);


// RegFile Input Mux
// Controls what value gets passed into the regfile to be stored into rd
Mux_4to1 regSrcMux(
    .in_0(alu.out),
    .in_1(dataMem.out),
    .in_2(immGen.imm),
    .in_3(linkAddr.q),
    .control(control.regSrc),
    .out()
);

endmodule