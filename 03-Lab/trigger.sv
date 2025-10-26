`ifndef COLOR_MIXER_V
`define COLOR_MIXER_V
`include "color_mixer.v"
`endif

module trigger (
    input wire clk,
    input wire sw2,
    output rLed,
    output gLed,
    output bLed
);
  wire  [2:0] color_state;
  logic [3:0] state;

  color_mixer #(
      .num_states(5)
  ) color_inst (
      .clk(clk),
      .sw2(sw2),
      .rLed(rLed),
      .gLed(gLed),
      .bLed(bLed),
      .state_o(color_state)
  );

  assign state = color_state[1] ? (color_state[0] ? 4'b1000 : 4'b0100) : (color_state[0] ? 4'b0010 : 4'b0001); // 2-4 multiplexer

  seq_trig #() seq_trig_inst (.active(state[0]));
  comb_trig #() comb_trig_inst (.active(state[1]));
  time_trig #() time_trig_inst (.active(state[2]));
  edge_trig #() edge_trig (.active(state[3]));

endmodule

module seq_trig (
    input wire active
);
endmodule

module comb_trig (
    input wire active
);
endmodule

module time_trig (
    input wire active
);
endmodule

module edge_trig (
    input wire active
);
endmodule
