module home_automation_system (
    input wire clk,             
    input wire reset,           
    input wire motion,          
    input wire daylight,        
    input wire [2:0] color_select, 
    output wire light_on,      
    output wire [2:0] light_color 
);

    
    wire fsm_light; 
    light_control_fsm fsm (
        .clk(clk),
        .reset(reset),
        .motion(motion),
        .daylight(daylight),
        .light(fsm_light)
    );

    
    wire [2:0] combinational_color; 
    home_automation_combinational color_ctrl (
        .motion(motion),
        .daylight(daylight),
        .color_select(color_select),
        .light_on(fsm_light), 
        .light_color(combinational_color)
    );

    
    assign light_on = fsm_light;        
    assign light_color = combinational_color; 

endmodule


module light_control_fsm (
    input wire clk,
    input wire reset,
    input wire motion,
    input wire daylight,
    output reg light
);

    
    typedef enum reg [1:0] {OFF, ON} state_t;
    state_t current_state, next_state;

  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    
    always @(*) begin
        case (current_state)
            OFF: if (motion && !daylight) next_state = ON;
                 else next_state = OFF;
            ON: if (!motion || daylight) next_state = OFF;
                else next_state = ON;
            default: next_state = OFF;
        endcase
    end
    
    always @(*) begin
        light = (current_state == ON);
    end

endmodule

module home_automation_combinational (
    input wire motion,
    input wire daylight,
    input wire [2:0] color_select,  
    input wire light_on,           
    output reg [2:0] light_color   
);

  
    always @(*) begin
        if (light_on) begin
            light_color = color_select;  
        end else begin
            light_color = 3'b000;  
        end
    end

endmodule
