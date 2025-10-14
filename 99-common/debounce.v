module debounce #(
    parameter DEBOUNCE_LIMIT = 20
) (
    input CLK,
    input bouncy,
    output reg debounced
);

  reg [$clog2(DEBOUNCE_LIMIT)-1:0] count = 0;

  always @(posedge CLK) begin
    if (bouncy != debounced && count < DEBOUNCE_LIMIT - 1) begin
      count <= count + 1;
    end else begin
      debounced <= bouncy;
      count <= 0;
    end
  end
endmodule
