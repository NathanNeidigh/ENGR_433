module color_mixer (
    input  CLK,
    input  SW2,
    output LED_R,
    output LED_G,
    output LED_B
);
  localparam IDLE_S = 3'b000;
  localparam RED_S = 3'b001;
  localparam GREEN_S = 3'b010;
  localparam BLUE_S = 3'b011;
  localparam YELLOW_S = 3'b100;
  localparam CYAN_S = 3'b0101;
  localparam MAGENTA_S = 3'b110;
  localparam WHITE_S = 3'b111;

  localparam IDLE = 3'b000;
  localparam RED = 3'b100;
  localparam GREEN = 3'b010;
  localparam BLUE = 3'b001;
  localparam YELLOW = 3'b110;
  localparam CYAN = 3'b011;
  localparam MAGENTA = 3'b101;
  localparam WHITE = 3'b111;

  reg [2:0] state;
  reg [2:0] led_r;

  always @(posedge switch) begin
    state <= state + 1;
    case (state)
      IDLE_S: led_r = IDLE;
      RED_S: led_r = RED;
      GREEN_S: led_r = GREEN;
      BLUE_S: led_r = BLUE;
      YELLOW_S: led_r = YELLOW;
      CYAN_S: led_r = CYAN;
      MAGENTA_S: led_r = MAGENTA;
      WHITE_S: led_r = WHITE;
      default led_r = IDLE;
    endcase
  end

  assign LED_R = ~led_r[2];
  assign LED_G = ~led_r[1];
  assign LED_B = ~led_r[0];

  debouncer #() debounce_inst (
      .CLK(CLK),
      .SW2(SW2),
      .debounced_w(switch)
  );

endmodule

module debouncer #(
    parameter DEBOUNCE_LIMIT = 120_000  //10ms wait for a 12Mhz clock
) (
    input  CLK,
    input  SW2,
    output debounced_w
);

  reg [$clog2(DEBOUNCE_LIMIT)-1:0] count_r = 0;

  always @(posedge CLK) begin
    if (SW2 !== debounced_w && count_r < DEBOUNCE_LIMIT - 1) begin
      count_r <= count_r + 1;
    end else if (count_r == DEBOUNCE_LIMIT - 1) begin
      debounced_w <= ~debounced_w;
      count_r <= 0;
    end else begin
      count_r <= 0;
    end
  end

endmodule
