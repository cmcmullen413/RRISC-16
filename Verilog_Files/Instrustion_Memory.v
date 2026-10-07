// Read Only Memory specifically for instructions
// Reads on the clock's rising edge
module Instr_Mem
#(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 16)
(
    input wire [ADDR_WIDTH-1:0] addr,
    input wire clk,
    output wire [ADDR_WIDTH-1:0] q
)

// Declare the ROM
reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];
// Declare the register to hold to current address
reg [ADDR_WIDTH-1:0] addr_reg;

initial begin
    // Currently just starts everything as zeros
    integer i;;
    for (i = 0; i < 2**ADDR_WIDTH-1; i = i + 1) begin
        rom[i] = {DATA_WIDTH{0}};
    end
    // TODO: Make this load from a text file
end

// Update address on rising edge
always @ (posedge clk) begin
    addr_reg = addr;
end

// Continuously assign the output wire to the current address's reg
assign q = {rom[addr_reg], rom[addr_reg+1]};