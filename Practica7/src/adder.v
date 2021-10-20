module adder(SW,LEDR);


//	input 		     [1:0]		SW;
//	output 			  [1:0]     LEDR;
//	wire in1, in2;
//	assign in1=SW[0];
//	assign in2=SW[1];
//	assign LEDR[0]=in1^in2;
//	assign LEDR[1]=in1&in2;


input [2:0] SW;
output [1:0] LEDR;
wire cout, sum;
wire in1, in2, cin;
assign in1=SW[0];
assign in2=SW[1];
assign cin=SW[2];
assign LEDR[0]=cout;
assign LEDR[1]=sum;

//halfAdder(in1, in2, sum, cout);
FullAdder(in1,in2,cin,sum,cout);
endmodule 


module halfAdder(in1,in2,sum,cout);

input in1,in2;
output sum, cout;
assign sum=in1^in2;
assign cout=in1&in2;

endmodule 

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