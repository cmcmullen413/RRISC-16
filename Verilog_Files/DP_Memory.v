// Dual Port Memory to be used for instruction and regular memory
//
// Reduced ADDR_WIDTH so my computer doesn't blow up
// Real one will probably have a full 16 bit addr width
module DP_Memory
#(parameter DATA_WIDTH = 16, parameter ADDR_WIDTH = 12)
(
    input [DATA_WIDTH-1:0] in_a, 
    input [DATA_WIDTH-1:0] in_b,
    input [ADDR_WIDTH-1:0] addr_a, 
    input [ADDR_WIDTH-1:0] addr_b,
    input clk_a,                            // Two clocks allows for reading and writing of each port on different edges
    input clk_b, 
    input we_a, 
    input we_b,
    output reg [DATA_WIDTH-1:0] out_a,
    output reg [DATA_WIDTH-1:0] out_b
);

// Declare the RAM
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

initial begin
    // Currently just starts everything as zeros
    integer i;
    for (i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
        ram[i] = {DATA_WIDTH{1'b0}};
    end
    // TODO: Make this load from a text file
end

// Update outputs on rising edge for the respecive clock
// To do a falling edge, the input clock can be inverted
always @ (posedge clk_a) begin
    // If writing is enabled, update the value
    if (we_a) begin
        ram[addr_a] <= in_a;
    end
    // Update the output
    out_a <= ram[addr_a];
end
always @ (posedge clk_b) begin
    // If writing is enabled, update the value
    if (we_b) begin
        ram[addr_b] <= in_b;
    end
    // Update the output
    out_b <= ram[addr_b];
end


endmodule