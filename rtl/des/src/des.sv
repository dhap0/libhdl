module des( input  logic [63:0] block_i,
            input  logic [63:0] key_i,
            output logic [63:0] block_o);
   
    logic [63:0] block_ip;
    logic [31:0] part_l;
    logic [31:0] part_r;

    des_ip des_ip_inst(.block_i(block_i),
                       .block_o(block_ip)
    ); 

    des_feistel des_feistel_inst(.left_i(block_ip[31:16]),
                                 .right_i(block_ip[15:0]),
                                 .rkey_i('h0),
                                 .left_o(part_l),
                                 .right_o(part_r));
    
    
    assign block_o = block_ip;

endmodule
