module des_tb;

  // Declare input and output signals
  logic [63:0] block_i;
  logic [63:0] block_o;

  // Instantiate module under test
  des dut (
    .block_i(block_i),
    .block_o(block_o)
  );

  // Define test vectors
  logic [63:0] test_vector_1 = 'h0123456789ABCDEF;
  //logic [63:0] test_vector_2 = 'hFEDCBA9876543210;
  logic [63:0] test_vector_2 = 'h123456ABCD132536;

  // Run test case 1
  initial begin 
    $dumpfile("tb/dump");
    $dumpvars(0, dut);

    block_i = test_vector_1;
    #1; // Wait for 1 time unit to allow signals to settle
    if (block_o !== 'h008082840CAFCED) begin
      $display("ERROR: Test case 1 failed. Expected output = %h, actual output = %h", 'h008082840CAFCED, block_o);
      //$finish;
    end
    else begin
      $display("Test case 1 passed");
    end
    block_i = test_vector_2;
    #1; // Wait for 1 time unit to allow signals to settle
    if (block_o !== 'h14A7D67818CA18AD) begin
      $display("ERROR: Test case 2 failed. Expected output = %h, actual output = %h", 'h14A7D67818CA18AD, block_o);
      //$finish;
    end
    else begin
      $display("Test case 2 passed");
    end
  end

endmodule
