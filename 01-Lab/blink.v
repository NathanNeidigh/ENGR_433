module blink (
    input  CLK,
    output LED_R,
    output LED_G,
    output LED_B
);

  localparam HALF_PERIOD = 500_000;

  reg [18:0] count = 19'd0;
  reg r_LED_R = 1'b0;
  reg r_LED_G = 1'b0;
  reg r_LED_B = 1'b0;

  always @(posedge CLK) begin
    if (count == HALF_PERIOD - 1) begin
      r_LED_R <= ~r_LED_R;
      r_LED_G <= ~r_LED_G;
      r_LED_B <= ~r_LED_B;
      count   <= 0;
    end else begin
      count <= count + 1;
    end
  end

  assign LED_R = r_LED_R;
  //assign LED_G = r_LED_G;
  //assign LED_B = r_LED_B;

endmodule
