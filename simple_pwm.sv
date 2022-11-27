module simple_pwm (input logic clk,
                   input logic rst_n,
                   output logic y);
  
  enum logic {STATE_OFF, STATE_ON} state_current, state_next;
  
  logic [7:0] t;
  
  const logic [7:0] T_OFF = 'd16;
  const logic [7:0] T_ON = 'd64;
  const logic [7:0] t_max = T_ON - 1;
  

  
  // Timer control strategy #1
  always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      t <= 0;
    end else if (state_current != state_next) begin
      t <= 0;
    end else if (t != t_max) begin
      t <= t + 1;
    end
  end

  
  always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      state_current <= STATE_OFF;
    end else begin
      state_current <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_current;
    y = 0;
    
    case(state_current)
      STATE_OFF: begin
        if (t == (T_OFF-1)) begin
          state_next = STATE_ON;
        end
      end
      
      STATE_ON: begin
        y = 1;
        if (t == (T_ON-1)) begin
          state_next = STATE_OFF;
        end
      end
      
    endcase
  end
  
  
endmodule
