// Read Only Memory to be used for instructions
module Instr_Memory
#(parameter DATA_WIDTH = 16, parameter ADDR_WIDTH = 8)
(
    input [DATA_WIDTH-1:0] in,
    input [ADDR_WIDTH-1:0] addr, 
    input clk,
    input we, 
    output reg [DATA_WIDTH-1:0] out
);

// Declare the RAM
reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

integer i;
initial begin
    // Currently just starts everything as zeros
    for (i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
        rom[i] = {DATA_WIDTH{1'b0}};
    end
    // TODO: Make this load from a text file
end

// Update the output on the clock edge edge
always @ (posedge clk) begin
    out <= rom[addr];
end

endmodule