module mux #(parameter WIDTH = 32)(input [WIDTH-1:0] ram, rom, 
input sel,
output [WIDTH-1:0] regOut);

assign regOut = sel ? rom : ram;

endmodule 