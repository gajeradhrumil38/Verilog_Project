module Reg_file (
    input clk,we3,rst,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    output  [31:0] rd1,
    output [31:0] rd2
);
    
 reg [31:0] Registers [31:0];

 assign rd1  = (!rst) ? 32'h00000000 : Registers[A1];
 assign rd2  = (!rst) ? 32'h00000000: Registers[A2];
 

always @(posedge clk ) begin
    
    if (we3) begin
        Registers[A3] <= WD3 ;
    end

end


    initial begin

        Registers[9] = 32'h00000020;
    end


endmodule