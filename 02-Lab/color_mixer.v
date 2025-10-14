`include "debounce.v"

module color_mixer (
    input  CLK,
    input  SW2,
    output LED_R,
    output LED_G,
    output LED_B
);
  localparam IDLE_S = 3'b000,
  RED_S = 3'b001,
  GREEN_S = 3'b010,
  BLUE_S = 3'b011,
  YELLOW_S = 3'b100,
  CYAN_S = 3'b101,
  MAGENTA_S = 3'b110,
  WHITE_S = 3'b111;

  localparam IDLE = 3'b000;
  localparam RED = 3'b100;
  localparam GREEN = 3'b010;
  localparam BLUE = 3'b001;
  localparam YELLOW = 3'b110;
  localparam CYAN = 3'b011;
  localparam MAGENTA = 3'b101;
  localparam WHITE = 3'b111;

  reg [2:0] state = IDLE_S;
  reg [2:0] led_r = 3'b000;
  wire switch;

  always @(posedge switch) begin
    state <= state + 1;
  end

  always @(state) begin
    case (state)
      IDLE_S: led_r <= IDLE;
      RED_S: led_r <= RED;
      GREEN_S: led_r <= GREEN;
      BLUE_S: led_r <= BLUE;
      YELLOW_S: led_r <= YELLOW;
      CYAN_S: led_r <= CYAN;
      MAGENTA_S: led_r <= MAGENTA;
      WHITE_S: led_r <= WHITE;
      default led_r <= IDLE;
    endcase
  end

  assign LED_R = ~led_r[2];
  assign LED_G = ~led_r[1];
  assign LED_B = ~led_r[0];

`ifdef SIMULATION
  assign switch = SW2;
`else
  debounce #() debounce_inst (
      .CLK(CLK),
      .bouncy_i(SW2),
      .debounced(switch)
  );
`endif
endmodule
