module instr_mem (


    input [31:0] A,
    input rst,
    output [31:0] rd
);


  reg [31:0] Mem[1023:0];

  assign rd = (~rst) ? {32{1'b0}} : Mem[A[31:2]];

  initial begin
    Mem[0] = 32'hFFC4A303;
    Mem[1] = 32'h00832383;
  end


endmodule
