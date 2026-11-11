module ALU_Control(
    input wire [1:0] ALUOp,
    input wire [1:0] f2,
    input wire fr,
    output reg [2:0] ALUfunct
);

// Output values for the ALU function input
parameter add_op = 3'b000;
parameter sub_op = 3'b100;
parameter xor_op = 3'b001;
parameter or_op  = 3'b010;
parameter and_op = 3'b011;
parameter sll_op = 3'b101;
parameter srl_op = 3'b110;
parameter sra_op = 3'b111;

always @(ALUOp, f2, fr) begin
    // ALUOp == 00 -> look at f2 and fr
    if (ALUOp == 2'b00) begin
        case ({fr, f2})
        3'b000: ALUfunct <= add_op;
        3'b001: ALUfunct <= sll_op;
        3'b010: ALUfunct <= srl_op;
        3'b011: ALUfunct <= sra_op;
        3'b100: ALUfunct <= sub_op;
        3'b101: ALUfunct <= xor_op;
        3'b110: ALUfunct <= or_op;
        3'b111: ALUfunct <= and_op;
        endcase
    end
    // ALUOp == 01 -> look at f2
    else if (ALUOp == 2'b01) begin
        case (f2)
        2'b00: ALUfunct <= add_op;
        2'b01: ALUfunct <= sll_op;
        2'b10: ALUfunct <= srl_op;
        2'b11: ALUfunct <= sra_op;
        endcase
    end
    // ALUOp == 10 -> add
    else if (ALUOp == 2'b10) begin
        ALUfunct <= add_op;
    end
    // ALUOp == 11 -> sub
    else if (ALUOp == 2'b11) begin
        ALUfunct <= sub_op;
    end
end

endmodule