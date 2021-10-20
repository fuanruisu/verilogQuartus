module adder(SW,LEDR);


//	input 		     [1:0]		SW;
//	output 			  [1:0]     LEDR;
//	wire in1, in2;
//	assign in1=SW[0];
//	assign in2=SW[1];
//	assign LEDR[0]=in1^in2;
//	assign LEDR[1]=in1&in2;


input [1:0] SW;
output [1:0] LEDR;
wire cout, sum;
wire in1, in2;
assign in1=SW[0];
assign in2=SW[1];
assign LEDR[0]=cout;
assign LEDR[1]=sum;

halfAdder(in1, in2, sum, cout);

endmodule 


module halfAdder(in1,in2,sum,cout);

input in1,in2;
output sum, cout;
assign sum=in1^in2;
assign cout=in1&in2;

endmodule 