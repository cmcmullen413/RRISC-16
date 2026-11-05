module Reg_File
(
    // Read Lines
    input wire [2:0] rs1,
    output reg [15:0] data_a,
    input wire [2:0] rs2,
    output reg [15:0] data_b,
    // Write Lines
    input wire [2:0] rd,
    input wire [15:0] write_data,
    input wire we,
    // Other Lines
    input wire clk,
    input wire reset
);

// Declare the registers
reg [15:0] REG[2**3-1:0];

// Initialize everything to 0
integer i;
initial begin
    for (i = 0; i < 2**3; i = i + 1) begin
        if (i == 2) begin
            // sp starts as 0xFFFF not 0
            REG[i] = 16'hFFFF;
        end else begin
            REG[i] = 16'h0000;
        end
    end
end

// Write synced to the posedge
always @(posedge clk) begin
    // Reset everything to zero on the reset signal
    if (reset == 1'b1) begin
        for (i = 0; i < 2**3; i = i + 1) begin
        if (i == 2) begin
            // sp starts as 0xFFFF not 0
            REG[i] = 16'hFFFF;
        end else begin
            REG[i] = 16'h0000;
        end
    end
    end
    // If we is high, update the value at rd
    // Cannot write to rd, it is always 0
    else if (we == 1'b1 && rd != 3'b000) begin
        REG[rd] <= write_data;
        // If rd == rs1 or rd == rs2, update the output so async reads properly
        if (rd == rs1) begin
            data_a <= write_data;
        end else if (rd == rs2) begin
            data_b <= write_data;
        end
    end
end

// Async read
always @(rs1, rs2) begin
    data_a <= REG[rs1];
    data_b <= REG[rs2];
end

endmodule