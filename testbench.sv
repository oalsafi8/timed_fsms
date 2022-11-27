module top;
  logic clk, rst_n;
  logic y;
  
  
  simple_pwm dut (.clk(clk),
                  .rst_n(rst_n),
                  .y(y));
  
  
  initial begin
    clk = 0;
    rst_n = 0;
    
    #50ns;
    rst_n = 1;
    
    forever begin
      clk = ~clk;
      #5ns;
    end
    
  end
  
  
  
  initial begin
    #7000ns;
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
  
endmodule