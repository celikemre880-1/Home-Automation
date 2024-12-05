module home_automation(
    input motion,               
    input daylight,             
    input [2:0] color_select,   
    output reg light_on,        
    output reg [2:0] light_color 
);

   
    always @(*) begin
        if (motion && !daylight) begin
            light_on = 1; 
            light_color = color_select; 
        end else begin
            light_on = 0; 
            light_color = 3'b000; 
        end
    end

endmodule


module tb_home_automation();

    reg motion;
    reg daylight;
    reg [2:0] color_select;
    wire light_on;
    wire [2:0] light_color;

   
    home_automation uut (
        .motion(motion),
        .daylight(daylight),
        .color_select(color_select),
        .light_on(light_on),
        .light_color(light_color)
    );

    initial begin
        // Test senaryoları
        $monitor("motion=%b, daylight=%b, color_select=%b => light_on=%b, light_color=%b", 
                 motion, daylight, color_select, light_on, light_color);

        
        motion = 0; daylight = 1; color_select = 3'b001; #10;
        motion = 0; daylight = 0; color_select = 3'b010; #10;
        motion = 1; daylight = 1; color_select = 3'b011; #10;
        motion = 1; daylight = 0; color_select = 3'b100; #10;
        motion = 1; daylight = 0; color_select = 3'b000; #10;

        $finish;
    end

endmodule

