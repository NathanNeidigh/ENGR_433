`include "color_mixer.v"

module tb ();

  reg clk = 1'b0, switch = 1'b0;
  wire led_r, led_g, led_b;

  color_mixer #() UUT (
      .CLK  (clk),
      .SW2  (switch),
      .LED_R(led_r),
      .LED_G(led_g),
      .LED_B(led_b)
  );

  always #10 clk = ~clk;  //10 MHz Clock

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    repeat (8) begin
      switch <= 1'b1;
      #100;
      switch <= 1'b0;
      #100;
      $display("Red: %0b Green: %0b Blue: %0b", led_r, led_g, led_b);
    end

    $finish();
  end
endmodule
