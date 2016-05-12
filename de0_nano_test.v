module de0_nano_test(clk, led);
    input clk; // 50 MHz
    output [7:0] led;
    
    reg [31:0] count = 0;
    always @(posedge clk)
        count <= count + 1;

    genvar i;
    generate
        for(i = 0; i < 8; i = i+1) begin : led_control
            wire [31:0] phase = (count<<5)+(i<<28);
            wire [31:0] intensity = (phase[31] ? ~phase : phase)<<1;
            assign led[i] = intensity[31:16] < count[15:0];
        end
    endgenerate
endmodule
