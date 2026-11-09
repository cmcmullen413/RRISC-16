module Mux_2to1(
    input wire[15:0] in_0,
    input wire[15:0] in_1,

    input wire control,

    output wire[15:0] out
);

assign out = (control) ? in_1 : in_0;

endmodule