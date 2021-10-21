module adder(SW,LEDR);
/*
Designer: Ing. Juan Luis Magaña Paz
Description: Construction of a 4 bits adder from a half adder module
*/

//Implementation of Half adder without instantiate it
//	input 		     [1:0]		SW;
//	output 			  [1:0]     LEDR;
//	wire in1, in2;
//	assign in1=SW[0];
//	assign in2=SW[1];
//	assign LEDR[0]=in1^in2;
//	assign LEDR[1]=in1&in2;


input [9:0] SW;
output [9:0] LEDR;
wire cout;
//1 bit adder declarations
//wire in1 , in2 , cin;
//assign in1=SW[0];
//assign in2=SW[1];
//assign cin=SW[9];
//assign LEDR[0]=cout;
//assign LEDR[1]=sum;

wire cin;
assign cin = SW[9];
wire [3:0] num4b1, num4b2, num4bresult;
assign num4b1 = SW[3:0];
assign num4b2 = SW[7:4];
assign LEDR[3:0] = num4bresult;
assign LEDR[4] = cout;
assign LEDR [9:5] = 1'b0;

//Conection for use only the half adder

//halfAdder(in1, in2, sum, cout);
//FullAdder(in1,in2,cin,sum,cout);
RCA4 Adder4(num4b1,num4b2, cin, num4bresult, cout);
endmodule 


//half adder implementation
module halfAdder(in1,in2,sum,cout);

input in1,in2;
output sum, cout;
assign sum=in1^in2;
assign cout=in1&in2;

endmodule 


//FullAdder implementation using two half adders
module FullAdder(in1, in2, cin, sum, cout);
input in1, in2, cin;
output sum, cout;
wire w1,w2,w3;
//                     sum,cout
//                       ↓  ↓
halfAdder   HA1(in1,in2, w1,w2);
halfAdder 	HA2(w1,cin,sum,w3);
assign cout = w3|w2;

endmodule 

//
module RCA4(in1, in2, cin, sum, cout);
input [3:0] in1, in2; 
input cin;
output [3:0] sum;
output cout; 
wire w1, w2, w3;

FullAdder FA1(in1[0],in2[0],cin,sum[0],w1);
FullAdder FA2(in1[1],in2[1],w1,sum[1],w2);
FullAdder FA3(in1[2],in2[2],w2,sum[2],w3);
FullAdder FA4(in1[3],in2[3],w3,sum[3],cout);

endmodule 