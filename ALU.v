// module ALU (
//     input [31:0] a,
//     input [31:0] b,
//     input [2:0] control,
//     output reg [31:0] result,
//     output n,
//     z,
//     c,
//     v
// );

//   wire [31:0] a_or_b;
//   wire [31:0] a_and_b;
//   wire [31:0] not_b;
//   wire [31:0] mux_1;
//   wire [31:0] sum;
//   wire cout;
//   wire [31:0] slt;  // z extention 

//   assign a_and_b = a & b;
//   assign a_or_b = a | b;
//   assign not_b = ~b;
//   assign mux_1 = (control[0] == 1'b0) ? b : not_b;
//   assign {cout, sum} = a + mux_1 + control[0];
//   assign z = &(~result);  // flag z
//   assign n = result[31];

//   assign c = (~control[1]) & cout;

//   assign v = (~control[1]) & (a[31] ^ sum[31]) & (~(a[31] ^ b[31] ^ control[0]));


//   // z extention 

//   assign slt = {{31{1'b0}}, sum[31]};


//   always @(*) begin
//     case (control[2:0])
//       3'b000, 3'b001: result = sum;
//       3'b010: result = a_and_b;
//       3'b011: result = a_or_b;
//       3'b101: result = slt;
//       default: result = 32'h00000000;  // Handle default case
//     endcase
//   end

// endmodule


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