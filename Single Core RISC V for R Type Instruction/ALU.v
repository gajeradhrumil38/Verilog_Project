
module ALU(a,b,result,control,v,c,z,n);

    input [31:0]a,b;
    input [2:0]control;
    output c,v,z,n;
    output [31:0]result;

    wire cout;
    wire [31:0]sum;

    assign sum = (control[0] == 1'b0) ? a + b :
                                          (a + ((~b)+1)) ;
    assign {cout,result} = (control == 3'b000) ? sum :
                           (control == 3'b001) ? sum :
                           (control == 3'b010) ? a & b :
                           (control == 3'b011) ? a | b :
                           (control == 3'b101) ? {{32{1'b0}},(sum[31])} :
                           {33{1'b0}};
    assign v = ((sum[31] ^ a[31]) & 
                      (~(control[0] ^ b[31] ^ a[31])) &
                      (~control[1]));
    assign c = ((~control[1]) & cout);
    assign z = &(~result);
    assign n = result[31];

endmodule
