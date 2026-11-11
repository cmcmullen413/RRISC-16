module Imm_Gen(
    input wire [15:0] instr,
    output reg [15:0] imm
);

parameter Reg_opcode = 3'b000;
parameter Imm_opcode = 3'b001;
parameter LW_opcode = 3'b010;
parameter SW_opcode = 3'b011;
parameter LUI_opcode = 3'b100;
parameter Branch_opcode = 3'b101;
parameter Jump_opcode = 3'b110;
parameter JumpReg_opcode = 3'b111;

wire [2:0] opcode = instr[2:0];

always @(instr) begin
    case (opcode)
    Reg_opcode:     imm <= 16'h0000;
    Imm_opcode:     imm <= {{12{instr[13]}}, instr[12:9]};
    LW_opcode:      imm <= {{11{instr[15]}}, instr[14:9]};
    SW_opcode:      imm <= {{11{instr[15]}}, instr[14:12], instr[5:3]};
    LUI_opcode:     imm <= {instr[15:5], 5'b00000};
    Branch_opcode:  imm <= {{12{instr[13]}}, instr[12], instr[5:3]};
    Jump_opcode:    imm <= {{7{instr[15]}}, instr[14:6]};
    JumpReg_opcode: imm <= {{11{instr[15]}}, instr[14:9]};
    endcase
end

endmodule