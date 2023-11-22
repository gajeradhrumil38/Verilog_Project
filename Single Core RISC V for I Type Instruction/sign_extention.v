module sign_extention (
    In,Imm_Exit
);
    
    input [31:0] In;
    output [31:0] Imm_Exit;


 assign Imm_Exit = (In[31]) ? {{20{1'b1}},In[31:20]} : 
                    {{20{1'b0}},In[31:20]} ;
endmodule