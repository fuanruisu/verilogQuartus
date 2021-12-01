/******************************************************************
* Description
*	This is the verifaction envioroment ofr testeting the register file.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	12/06/2015
******************************************************************/

module Program_Memory_TB;

parameter MEMORY_DEPTH = 64;
parameter DATA_WIDTH = 32;
reg clk_tb = 0, we_tb = 0;
//wire sel_tb;
reg [(DATA_WIDTH-1):0] Address_i_tb, data_tb;
wire [(DATA_WIDTH-1):0] Instruction_o_tb;
wire [$clog2(MEMORY_DEPTH)-2:0] addrMemDepth_tb;
wire [DATA_WIDTH-1:0] outAddrROM, outAddrRAM;

//ROM module instantiation  
/*Program_Memory
#
(
	.MEMORY_DEPTH(MEMORY_DEPTH),
	.DATA_WIDTH(DATA_WIDTH)
)
DUV1
(
	.Address_i(Address_i_tb),
	.Instruction_o(Instruction_o_tb)
);*/

//RAM module instantiation

/*single_port_ram 
#
(
	.ADDR_WIDTH(MEMORY_DEPTH),
	.DATA_WIDTH(DATA_WIDTH)
)
DUV
(
	//With addr I can write and read the address 
	.addr(Address_i_tb),
	.data(data_tb),
	.clk(clk_tb),
	.we(we_tb),
	.q(Instruction_o_tb)
);*/

//Decoder RAM/ROM address instantiation
/*
memDec
#(.WIDTH(DATA_WIDTH))
DUV
(
.addr(Address_i_tb),
.sel(sel_tb)
);*/

//DecoderRAM instantiation
/*
addrDecoderRAM 
#(
.WIDTH(DATA_WIDTH),
.numPosMem(MEMORY_DEPTH)
)DUV(
.addr(Address_i_tb),
.outAddr(addrMemDepth_tb)
);*/

//DecoderRAM instantiation
/*addrDecoderROM #(
.WIDTH(DATA_WIDTH),
.numPosMem(MEMORY_DEPTH)
)DUV(
.addr(Address_i_tb),
.outAddr(addrMemDepth_tb)
);*/

Memory_System
#
(.MEMORY_DEPTH(MEMORY_DEPTH),
.DATA_WIDTH(DATA_WIDTH))
DUV
(
.clk_i(clk_tb),
.write_enable_i(we_tb),
.Write_Data(data_tb),
.Address_i(Address_i_tb),
.Instruction_o(Instruction_o_tb)

);
/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk_tb = !clk_tb;
  end
/*********************************************************/


initial begin: TB
	integer i;

	

	//Decoder RAM/ROM adddres testing
	for (i = 0; i<=32; i = i+1)begin
		#50 Address_i_tb = i;
		//#50 Address_i_tb = 32'h10010000+i;
	end

	//start RAM testing
	/*#1 we_tb = 1;
	#50 Address_i_tb = 1;
	#1 data_tb = 32'hFFFFFFFF;

	#50 Address_i_tb = 2;
	#1 data_tb = 32'h12345678;
	
	#50 Address_i_tb = 3;
	#1 data_tb = 32'h98761234;

	#50 Address_i_tb = 4;
	#1 data_tb = 32'hA0A0A0A0;
	
	#50 Address_i_tb = 5;
	#1 data_tb = 32'hABCDEF12;

	#50 Address_i_tb = 6;
	#1 data_tb = 32'h12345678;*/
	//finish RAM testing


	//for loop to access ROM's addresses
	/*for (i = 0; i<=66; i = i+1)
		#50 Address_i_tb = i;*/

end


/*********************************************************/

endmodule