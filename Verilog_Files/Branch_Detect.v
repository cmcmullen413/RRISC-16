module Branch_Detect(
    input wire branch,
    input wire zero,
    input wire msb,
    input wire [1:0] f2,
    output reg branchControl
);

parameter eq_f2 = 2'b00;
parameter ne_f2 = 2'b01;
parameter lt_f2 = 2'b10;
parameter ge_f2 = 2'b11;

always @(branch, zero, msb, f2) begin
    if (~branch) begin
        branchControl <= 1'b0;
    end else if (f2 == eq_f2) begin
        branchControl <= zero;
    end else if (f2 == ne_f2) begin
        branchControl <= ~zero;
    end else if (f2 == lt_f2) begin
        branchControl <= msb;
    end else begin
        branchControl <= ~msb;
    end
end

endmodule