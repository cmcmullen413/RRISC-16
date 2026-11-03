// Arithmatic Logic Unit
// Cam perform the following operations depending on the ALU funct
// Funct may change, depends on exect implementation
// But the funct 3 is either the f2 and fr from the instruction
//   or it is add for mem instruction or sub for branches

module ALU(
    // Inputs and outputs
    input wire signed [15:0] a,
    input wire signed [15:0] b,
    output reg signed [15:0] out,
    // Control wires
    input wire [2:0] funct
);

//  Operation | ALUfunct
parameter add_op = 3'b000;
parameter sub_op = 3'b100;
parameter xor_op = 3'b001;
parameter or_op  = 3'b010;
parameter and_op = 3'b011;
parameter sll_op = 3'b101;
parameter srl_op = 3'b110;
parameter sra_op = 3'b111;

always @(a,b,funct) begin
    case (funct)
    add_op: out <= a+b;
    sub_op: out <= a-b;
    xor_op: out <= a^b;
    or_op:  out <= a|b;
    and_op: out <= a&b;
    sll_op: out <= a<<b;
    srl_op: out <= a>>b;
    sra_op: out <= a>>>b;
    endcase
end

endmodule