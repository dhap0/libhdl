module des( input  logic [63:0] block_i,
            input  logic [63:0] key_i,
            output logic [63:0] block_o);
   
    logic [63:0] block_ip;

    des_ip des_ip_inst(.block_i(block_i),
                       .block_o(block_ip)
    ); 

    logic [31:0] part_l [13];
    logic [31:0] part_r [13];

    genvar i;
    generate

        for (i = 0; i < 12; i++) begin
            des_feistel des_feistel_inst(
               .left_i(part_l[i]),
               .right_i(part_r[i]),
               .rkey_i(48'h0),
               .left_o(part_l[i+1]),
               .right_o(part_r[i+1])
            );

        end
    endgenerate
    assign part_r[0] =  block_ip[31:0];
    assign part_l[0] =  block_ip[63:32];

//    assign part_r[0] = block_ip[31:0];
//    assign part_l[0] = block_ip[63:32];
//
//    des_feistel des_feistel1_inst(.left_i(part_l[0]),
//                                     .right_i(part_r[0]);
//                                     .rkey_i(64'h0),
//                                     .left_o(part_l[1]),
//                                     .right_o(part_r[1]));
//    
//    des_feistel des_feistel2_inst(.left_i(part_l[0]),
//                                     .right_i(part_r[0]);
//                                     .rkey_i(64'h0),
//                                     .left_o(part_l[1]),
//                                     .right_o(part_r[1]));
//    
//    des_feistel des_feistel1_inst(.left_i(part_l[0]),
//                                     .right_i(part_r[0]);
//                                     .rkey_i(64'h0),
//                                     .left_o(part_l[1]),
//                                     .right_o(part_r[1]));
//    
    
    
    
    assign block_o = {part_l[12], part_r[12]} ;

endmodule
