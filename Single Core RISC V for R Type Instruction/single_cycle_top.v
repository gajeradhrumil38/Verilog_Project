`include "PC.v"
`include "instrct_mem.v"
`include "Reg_file.v"
`include "sign_extention.v"
`include "ALU.v"
`include "control_unit.v"
`include "data_memory.v"
`include "PC_adder.v"

module single_cycle_top (
    input clk,
    rst
);


  wire [31:0] PC_top, RD_instr, 
  RD1_Top, Imm_Exit_Top,alu_result,
   read_data,PC_plus4,SrcB,Result;
  wire RegWrite, MemWrite, ALUSrc, ResultSrc;
  wire [1:0] ImmSrc;
  wire [2:0] ALUControl_Top;

  PC PC (

      .clk(clk),
      .rst(rst),
      .PC(PC_top),
      .PCNext(PC_plus4)
  );

  instr_mem instr_mem (

      .rst(rst),
      .A  (PC_top),
      .rd (RD_instr)

  );

  Reg_file Reg_file (

      .clk(clk),
      .rst(rst),
      .we3(RegWrite),
      .WD3(read_data),
      .rd1(RD1_Top),
      .rd2(),
      .A1 (RD_instr[19:15]),
      .A2 (),
      .A3 (RD_instr[11:7])

  );

  sign_extention sign_extention (

      .In(RD_instr),
      .Imm_Exit(Imm_Exit_Top)


  );

  ALU ALU (

      .a(RD1_Top),
      .b(Imm_Exit_Top),
      .result(alu_result),
      .control(ALUControl_Top),
      .n(),
      .z(),
      .c(),
      .v()

  );

  control_unit control_unit (
      .Op(RD_instr[6:0]),
      .RegWrite(RegWrite),
      .ImmSrc(ImmSrc),
      .ALUSrc(ALUSrc),
      .MemWrite(MemWrite),
      .ResultSrc(ResultSrc),
      .Branch(),
      .funct3(RD_instr[14:12]),
      .funct7(RD_instr[6:0]),
      .ALUControl(ALUControl_Top)


  );

  data_mem data_mem (
      .clk(clk),
      .rst(rst),
      .A  (alu_result),
      .WD (),
      .we (MemWrite),
      .rd (read_data)
  );


  PC_adder PC_adder (

      .a(PC_top),
      .b(32'd4),
      .c(PC_plus4)


  );


endmodule





module single_cycle_top_tb ();

 single_cycle_top single_cycle_top(
      .clk(clk),
      .rst(rst)
  );

  reg clk = 1'b1, rst;

  initial begin
    $dumpfile("single_cycle_top.vcd");
    $dumpvars(0);
  end

  always begin
    clk = ~clk;
    #50;
  end

  initial begin
    rst = 1'b0;
    #100;

    rst = 1'b1;
    #300;

    $finish;
  end

endmodule
