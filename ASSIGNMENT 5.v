module light_control(
    input wire clk,        
    input wire reset,       
    input wire motion,      
    input wire daylight,    
    output reg light       
);

    
    typedef enum reg [1:0] {
        S0_IDLE = 2'b00,   
        S1_LIGHT_ON = 2'b01, 
        S2_DELAY = 2'b10    
    } state_t;

    state_t current_state, next_state;

  
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S0_IDLE;
        else 
            current_state <= next_state;
    end

   
    always @(*) begin
      
        next_state = current_state;
        light = 1'b0;

        case (current_state)
            S0_IDLE: begin
                if (motion && ~daylight)
                    next_state = S1_LIGHT_ON;
                else if (~motion && daylight)
                    next_state = S0_IDLE;
            end

            S1_LIGHT_ON: begin
                light = 1'b1;
                if (motion && daylight)
                    next_state = S2_DELAY;
                else if (~motion && daylight)
                    next_state = S0_IDLE;
            end

            S2_DELAY: begin
                light = 1'b1;
              if (/* Timer Expired Logic*/)
                    next_state = S0_IDLE;
            end
        endcase
    end
endmodule
