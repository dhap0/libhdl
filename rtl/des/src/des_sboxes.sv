module des_sboxes(input logic [47:0] block_i,
                  output logic [31:0] block_o);
    logic [5:0] block_l [8];
    logic [31:0] block_s;

    assign block_l = block_i; 

    localparam bit [3:0] S1 [64] = '{
        14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
         0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
         4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
        15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13
    };

    always_comb begin

        block_s[0] = S1[block_l[0]];
        block_s[1] = S1[block_l[1]];
        block_s[2] = S1[block_l[2]];
        block_s[3] = S1[block_l[3]];
        block_s[4] = S1[block_l[4]];
        block_s[5] = S1[block_l[5]];
        block_s[6] = S1[block_l[6]];
        block_s[7] = S1[block_l[7]];
    end 

    assign block_o = block_s;

endmodule
