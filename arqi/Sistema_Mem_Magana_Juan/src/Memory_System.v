module Memory_System
#
(
parameter MEMORY_DEPTH = 64,
parameter DATA_WIDTH = 32
)
(
input clk_i,
input write_enable_i,
input [DATA_WIDTH-1:0] Write_Data,
input [DATA_WIDTH-1:0] Address_i,

output [DATA_WIDTH-1:0] Instruction_o

);
//wire sel;
//wire [$clog2(MEMORY_DEPTH)-2:0] outAddrRAM, outAddrROM;
//wire [(DATA_WIDTH-1):0] ram;
//wire [(DATA_WIDTH-1):0] rom;

//Decoder address from 32 bits to 6 bits
addrDecoderRAM #(
.WIDTH(DATA_WIDTH) ,
.numPosMem(MEMORY_DEPTH) 
)
addDecRAM
(
.addr(Address_i),
.outAddr(outAddrRAM)
);

//RAM instantiation
single_port_ram 
#(.DATA_WIDTH(DATA_WIDTH), 
.ADDR_WIDTH(MEMORY_DEPTH)
)
RAM1
(
	.data(Write_Data),
	.addr(outAddrRAM),
	.we(write_enable_i), 
	.clk(clk_i),
	.q(ram)
);


//Decoder address from 32 bits to 6 bits
addrDecoderROM 
#(
.WIDTH(DATA_WIDTH) ,
.numPosMem(MEMORY_DEPTH) 
)
addDecROM
(
.addr(Address_i),
.outAddr(outAddrROM)
);

//ROM instantiation
Program_Memory
#
(
	.DATA_WIDTH(DATA_WIDTH), 
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROM1
(
	.Address_i(outAddrROM),
	.Instruction_o(rom)
);

//Decoder for mux's sel signal
memDec
#(
.WIDTH(DATA_WIDTH))
decoder2MUX
(
.addr(Address_i),
.sel(sel)
);

//MUX for RAM and ROM output
mux 
#(.WIDTH(DATA_WIDTH) )
mux1
(
.ram(ram), 
.rom(rom), 
.sel(sel),
.regOut(Instruction_o)
);


endmodule 