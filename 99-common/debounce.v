module debounce #(
    parameter DEBOUNCE_LIMIT = 20
) (
    input CLK,
    input bouncy_i,
    output reg debounced
);

  reg [$clog2(DEBOUNCE_LIMIT)-1:0] count = 0;

  always @(posedge CLK) begin
    if (bouncy_i != debounced && count < DEBOUNCE_LIMIT - 1) begin
      debounced <= ~debounced;
      count <= count + 1;
    end else begin
      count <= 0;
    end
  end
endmodule
