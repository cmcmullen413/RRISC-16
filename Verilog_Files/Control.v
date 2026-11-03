// Takes in the opcode and spits out all the control signals
module Control(
    // Opcode from instruction
    input wire [2:0] opcode,
    // Control lines
    // Register Write
    output reg regWrite,
    // Memory Read
    output reg memRead,
    // Memory Write
    output reg memWrite,
    // ALU B input source (rs2 or imm)
    output reg ALUSrc,
    // ALU operation (Tells the alu control to sub on a branch (11) or add on a memory instr (10) or look at f2 and fr (00) or look at just f2 (01))
    output reg [1:0] ALUOp,
    // Branch?
    output reg branch,
    // Jump?
    output reg jump,
    // Jump to Register value?
    output reg jumpReg,
    // RegFile input source (alu, mem, linkAddr, imm)
    output reg [1:0] regSrc,
    // Load Upper Immediate rd control (Since lui can only write to the upper half of the registers)
    output reg lurd
);

// The opcodes for each type
// Exect values may change, depending on what makes the digital logic easier
parameter Reg_opcode = 3'b000;
parameter Imm_opcode = 3'b001;
parameter LW_opcode = 3'b010;
parameter SW_opcode = 3'b011;
parameter LUI_opcode = 3'b100;
parameter Branch_opcode = 3'b101;
parameter Jump_opcode = 3'b110;
parameter JumpReg_opcode = 3'b111;

always @(opcode) begin
    case (opcode)
    Reg_opcode: begin
            regWrite <= 1'b1;
            memRead <= 1'bx;
            memWrite <= 1'b0;
            ALUSrc <= 1'b0;
            ALUOp <= 2'b00;
            branch <= 1'b0;
            jump <= 1'b0;
            jumpReg <= 1'b0;
            regSrc <= 2'b00;
            lurd <= 1'b0;
        end
    Imm_opcode: begin
            regWrite <= 1'b1;
            memRead <= 1'bx;
            memWrite <= 1'b0;
            ALUSrc <= 1'b1;
            ALUOp <= 2'b01;
            branch <= 1'b0;
            jump <= 1'b0;
            jumpReg <= 1'b0;
            regSrc <= 2'b00;
            lurd <= 1'b0;
        end
    LW_opcode: begin
            regWrite <= 1'b1;
            memRead <= 1'b1;
            memWrite <= 1'b0;
            ALUSrc <= 1'b1;
            ALUOp <= 2'b10;
            branch <= 1'b0;
            jump <= 1'b0;
            jumpReg <= 1'b0;
            regSrc <= 2'b01;
            lurd <= 1'b0;
        end
    SW_opcode: begin
            regWrite <= 1'b0;
            memRead <= 1'bx;
            memWrite <= 1'b1;
            ALUSrc <= 1'b1;
            ALUOp <= 2'b10;
            branch <= 1'b0;
            jump <= 1'b0;
            jumpReg <= 1'b0;
            regSrc <= 2'bxx;
            lurd <= 1'bx;
        end
    LUI_opcode: begin
            regWrite <= 1'b1;
            memRead <= 1'bx;
            memWrite <= 1'b0;
            ALUSrc <= 1'bx;
            ALUOp <= 2'bxx;
            branch <= 1'b0;
            jump <= 1'b0;
            jumpReg <= 1'b0;
            regSrc <= 2'b10;
            lurd <= 1'b1;
        end
    Branch_opcode: begin
            regWrite <= 1'b0;
            memRead <= 1'bx;
            memWrite <= 1'b0;
            ALUSrc <= 1'b0;
            ALUOp <= 2'b11;
            branch <= 1'b0;
            jump <= 1'b0;
            jumpReg <= 1'b0;
            regSrc <= 2'bxx;
            lurd <= 1'bx;
        end
    Jump_opcode: begin
            regWrite <= 1'b0;
            memRead <= 1'bx;
            memWrite <= 1'b0;
            ALUSrc <= 1'b0;
            ALUOp <= 2'b11;
            branch <= 1'b0;
            jump <= 1'b0;
            jumpReg <= 1'b0;
            regSrc <= 2'bxx;
            lurd <= 1'bx;
        end
    
    endcase
end

endmodule