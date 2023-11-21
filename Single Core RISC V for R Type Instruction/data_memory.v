module data_mem (
    
    input clk,rst,we,
    input [31:0] A,
    input [31:0] WD,
    output  [31:0] rd

);
    
    reg [31:0] data_array [1023:0] ;
    // assign rd = (we == 1'b0) ? data_array[A] : 32'h00000000;

    // always @(posedge clk ) begin
    //     if(we == 1'b1)
    //     data_array[A] <= WD; 
    // end 

    always @ (posedge clk)
    begin
        if(we)
            data_array[A] <= WD;
    end

    assign rd = (~rst) ? 32'h00000000 : data_array[A];

initial begin
    
    data_array[28] = 32'h00000020;
    data_array[40] = 32'h00000002;
end

endmodule