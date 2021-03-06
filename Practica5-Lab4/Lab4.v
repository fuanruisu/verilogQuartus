
module Lab4(


	//////////// SW //////////
	input 		     [9:0]		SW,


	//////////// SEG7 //////////
	output		     [6:0]		HEX0

	
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire C0;
wire C1;

assign C1 = SW[0];
assign C0 = SW[1];


//=======================================================
//  Structural coding
//=======================================================

assign HEX0[0] = ~(C0^C1);
assign HEX0[1] = C1;
assign HEX0[2] = ~(~C0&~C1);//1->1 0->0 
assign HEX0[3] = ~C1;
assign HEX0[4] = 0;
assign HEX0[5] = 0;
assign HEX0[6] = ~(~C1|C1&~C0);

endmodule