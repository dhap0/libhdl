module des_feistel(input  logic [31:0] left_i,
                   input  logic [31:0] right_i,
                   input  logic [47:0] rkey_i,
                   output logic [31:0] left_o,
                   output logic [31:0] right_o);
    
    localparam byte E [0:47] = '{   
        32,  1,  2,  3,  4,  5,  
         4,  5,  6,  7,  8,  9,  
         8,  9, 10, 11, 12, 13, 
        12, 13, 14, 15, 16, 17, 
        16, 17, 18, 19, 20, 21, 
        20, 21, 22, 23, 24, 25, 
        24, 25, 26, 27, 28, 29, 
        28, 29, 30, 31, 32,  1
    };

    localparam byte P [0:31] = '{
        16,  7, 20, 21,
        29, 12, 28, 17,
         1, 15, 23, 26,
         5, 18, 31, 10,
         2,  8, 24, 14,
        32, 27,  3,  9,
        19, 13, 30,  6,
        22, 11,  4, 25
    };

    logic [47:0] expand_t;
    logic [47:0] xored_t;
    logic [31:0] sboxed_t;
    logic [31:0] permuted_t;
    
    // F function begins

    //expand right
    genvar i;
    generate
        for (i = 0; i < 48; i++) begin
            assign expand_t[47-i] = right_i[E[i]-1];
        end
    endgenerate
    //
    // xor expanded with key
    assign xored_t = expand_t ^ rkey_i;
    //
    //sbox xored
    des_sboxes des_boxes_inst(.block_i(xored_t),
                              .block_o(sboxed_t));
    //
    //permute sboxed
    genvar j;
    generate
        for (j = 0; j < 32; j++) begin
            assign permuted_t[31-j] = sboxed_t[P[j]-1];
        end
    endgenerate
    
    // F function ends

    assign right_o = left_i ^ permuted_t; 
    assign left_o  = right_i;


endmodule
