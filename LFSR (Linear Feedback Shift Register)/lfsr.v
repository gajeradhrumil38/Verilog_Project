module lfsr #(
    parameter seed = 4'b1001
) (
    output reg [3:0] LFSRregister,
    input clk
);

  reg newbit;
  reg [3:0] counter;

  // initially register will contain seed value
  initial begin
    LFSRregister = seed;
    counter = 4'b0;
  end

  // at edge of each clock pulse, shift and XOR required bits
  always @(posedge clk) begin
    if (counter <= 15) begin

      newbit = (LFSRregister ^ (LFSRregister >> 1)) & 1 ;
      LFSRregister = (LFSRregister >> 1) | (newbit << 3);

  
      counter = counter + 1;
    end
  end
endmodule

