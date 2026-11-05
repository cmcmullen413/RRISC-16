module Mux_4to1(
    input wire[31:0] in_0,
    input wire[31:0] in_1,
    input wire[31:0] in_2,
    input wire[31:0] in_3,

    input wire[1:0] control,

    output wire[31:0] out
);

assign out = (control === 2'b00) ? in_0 :
             (control === 2'b01) ? in_1 :
             (control === 2'b10) ? in_2 : in_3;

endmodule