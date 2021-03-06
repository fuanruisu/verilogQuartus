module Lab5(SW, HEX0, HEX1, HEX2, HEX3);
input [9:0] SW;
output [6:0] HEX0, HEX1, HEX2, HEX3;
    // SW        =     [9:8] selects for HEX 
    //                [7:0] toggle to display 'H', 'E', 'L', 'P' 
    //
    // Ch3   SW[7:6]    0  0      H
    // Ch2     SW[5:4]    0  1        E
    // Ch1     SW[3:2]    1  0        L 
    // Ch0     SW[1:0]    1  1        P 

    // SW  9  8    Displayed Characters
    //     0  0    HELP 
    //     0  1    ELPH
    //     1  0    LPHE
    //     1  1    PHEL

    wire [1:0] Ch_Sel, Ch3, Ch2, Ch1, Ch0;
    wire [1:0] mux3_out, mux2_out, mux1_out, mux0_out;
    wire [6:0] hex3_out, hex2_out, hex1_out, hex0_out;
    assign Ch_Sel = SW[9:8];
    assign Ch3 = SW[7:6];
    assign Ch2 = SW[5:4];
    assign Ch1 = SW[3:2];
    assign Ch0 = SW[1:0];
    assign HEX3[6:0] = hex3_out;
    assign HEX2[6:0] = hex2_out;
    assign HEX1[6:0] = hex1_out;
    assign HEX0[6:0] = hex0_out;


    // 3x Instantiations of Mux/Display Modules
    mux2bit_4to1 m0 (Ch_Sel,Ch0,Ch1,Ch2,Ch3,mux0_out);
    mux2bit_4to1 m1 (Ch_Sel,Ch3,Ch0,Ch1,Ch2,mux1_out);
    mux2bit_4to1 m2 (Ch_Sel,Ch2,Ch3,Ch0,Ch1,mux2_out);
    mux2bit_4to1 m3 (Ch_Sel,Ch1,Ch2,Ch3,Ch0,mux3_out);
    SEG7 s0 (mux0_out, hex0_out);
    SEG7 s1 (mux1_out, hex1_out);
    SEG7 s2 (mux2_out, hex2_out);
    SEG7 s3 (mux3_out, hex3_out);

endmodule

// Mux Module
module mux2bit_4to1 (S, U, V, W, X, M);
    input [1:0] S, U, V, W, X;
    output [1:0] M;

    wire [1:0] s;
    wire [1:0] u;
    wire [1:0] v;
    wire [1:0] w;
    wire [1:0] x;

    assign u = U[1:0];
    assign v = V[1:0];
    assign w = W[1:0];
    assign x = X[1:0];
    assign s = S[1:0];
    reg [1:0] m;

    always @(*)
    begin;
    case(s)
        2'b01 : m = v;
        2'b10 : m = w;
        2'b11 : m = x;
        default : m = u;
    endcase
    end
    assign M = m;

endmodule


module SEG7(C,Display);
input [1:0] C;
output [6:0] Display;
/* Functions to deploy on the display H,E,L,P */ 
assign Display[0] = ~(C[0]^C[1]);
assign Display[1] = C[1];
assign Display[2] = ~(~C[0]&~C[1]);
assign Display[3] = ~C[1];
assign Display[4] = 0;
assign Display[5] = 0;
assign Display[6] = ~(~C[1]|C[1]&~C[0]);

endmodule