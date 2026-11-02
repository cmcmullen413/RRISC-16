// RAM to be used for instructions
module Data_Memory
#(parameter DATA_WIDTH = 16, parameter ADDR_WIDTH = 8)
(
    input [DATA_WIDTH-1:0] in,
    input [ADDR_WIDTH-1:0] addr, 
    input we, 
    output reg [DATA_WIDTH-1:0] out,
    input clk
);

// Declare the RAM
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

integer i;
initial begin
    // Initialize everything to 0
    for (i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
        ram[i] = {DATA_WIDTH{1'b0}};
    end
end

// Update the input on the clock edge
always @ (posedge clk) begin
    if (we) begin
        ram[addr] <= in;
    end
end
// Update the output on the clock edge
always @ (posedge clk) begin
    out <= ram[addr];
end

endmodule