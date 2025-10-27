module tb ();

  logic ch3, ch4;
  logic ch6, ch7, ch8;
  logic switch;
  logic rLed, gLed, bLed;
  logic clk = 1'b0;
  always #100 clk <= ~clk;

  trigger #() trigger_inst (
      .clk(clk),
      .sw2(switch),
      .rLed(rLed),
      .gLed(gLed),
      .bLed(bLed),
      .ch3(ch3),
      .ch4(ch4),
      .ch6(ch6),
      .ch7(ch7),
      .ch8(ch8)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    repeat (3) @(posedge clk);
    $display("=== Sequential trigger test ===");
    switch <= 1'b1;
    @(posedge clk);
    switch <= 1'b0;

    @(posedge clk);
    $display("=== Combinational Trigger test ===");
    switch <= 1'b1;
    @(posedge clk);
    switch <= 1'b1;

    @(posedge clk);
    $display("=== Time-based Trigger ===");
    switch <= 1'b1;
    @(posedge clk);
    switch <= 1'b1;

    @(posedge clk);
    $display("=== Edge-based Trigger ===");
    switch <= 1'b1;
    @(posedge clk);
    switch <= 1'b1;

    @(negedge ch8) begin
      $monitor("Ch3: %0b Ch4: %0b RGB %0b%0b%0b", ch3, ch4, rLed, gLed, bLed);
    end
    @(posedge ch8) $monitoroff;

    $display("Finished Simulation!");
    $finish();
  end
endmodule
