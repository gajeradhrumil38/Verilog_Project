module regfile #(

    parameter B = 16,  // number of bits
    w = 4  // number of address
) (

    input wire clk,
    wr_en,
    input wire [w-1:0] w_addr,
    input wire [w-1:0] r_addr,
    input wire [B-1:0] w_data,
    output reg [B-1:0] r_data
);


  reg [B-1:0] array[2**w-1:0];

  always @(posedge clk) begin

    if (wr_en) array[w_addr] <= w_data;


  r_data <= array[r_addr];


  end

 
endmodule

module regfile_tb;

  // Parameters
  parameter B = 8;  // number of bits
  parameter w = 2;  // number of address

  // Inputs and outputs
  reg clk;
  reg wr_en;
  reg [w-1:0] w_addr;
  reg [w-1:0] r_addr;
  reg [B-1:0] w_data;
  wire [B-1:0] r_data;

  // Instantiate the regfile module
  regfile #(
    .B(B),
    .w(w)
  ) uut (
    .clk(clk),
    .wr_en(wr_en),
    .w_addr(w_addr),
    .r_addr(r_addr),
    .w_data(w_data),
    .r_data(r_data)
  );

 
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end


  initial begin
 
    wr_en = 1;
    w_addr = 0;
    w_data = 8'b00000001;
    #10;

   
    wr_en = 0;
    r_addr = 0;
    #10;

   wr_en = 1;
    w_addr = 1;
    w_data = 8'b00000010;
    #10;

wr_en = 1;
    w_addr = 0;
    w_data = 8'b11111111;
    #10;

    wr_en = 0;
    r_addr = 0;
    #10;

    $finish;
  end

  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, regfile_tb);
  end

endmodule





// module regfile (

// input [2:0]r1,
// input [2:0]r2,
// input [2:0]w1,
// input we, // write enable
// input [31:0]d1, // 32 bit input
// output reg [31:0] out1,
// output reg [31:0] out2,

// );
//   reg [31:0] rf [7:0]; // 32 by 8 array


//   always @(*) begin

//     if (we)
//     rf[w1] <=d1;

//     out1 <= rf[r1];
//     out2 <= rf[r2];


//   end
// endmodule
