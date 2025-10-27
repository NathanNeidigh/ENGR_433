module trigger (
    input  wire  clk,
    input  wire  sw2,
    output logic rLed,
    output logic gLed,
    output logic bLed,
    output logic ch3,
    output logic ch4,
    output logic ch6,
    output logic ch7,
    output logic ch8
);
  localparam integer signal_len = 9;
  logic [signal_len-1:0] signal1 = 9'b000111000;
  logic [signal_len-1:0] signal2 = 9'b010110010;
  logic [2:0] color_state;
  logic [3:0] state;
  logic send_sig, send_seq, send_comb, send_time, send_edge;
  assign send_sig = send_seq | send_comb | send_time | send_edge;
  logic ch6_comb;
  assign ch6 = ch6_comb;
  logic ch7_seq, ch7_comb;
  assign ch7 = ch7_seq | ch7_comb;
  logic ch8_seq, ch8_comb, ch8_edge;
  assign ch8 = ch8_seq | ch8_comb | ch8_edge;
  logic [$clog2(signal_len):0] count = 0;

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

  seq_trig #() seq_trig_inst (
      .clk(clk),
      .active(state[0]),
      .ch7(ch7_seq),
      .ch8(ch8_seq),
      .send_sig(send_seq)
  );
  comb_trig #() comb_trig_inst (
      .clk(clk),
      .active(state[1]),
      .ch6(ch6_comb),
      .ch7(ch7_comb),
      .ch8(ch8_comb),
      .send_sig(send_comb)
  );
  time_trig #() time_trig_inst (
      .clk(clk),
      .active(state[2]),
      .send_sig(send_time)
  );
  edge_trig #() edge_trig_inst (
      .clk(clk),
      .active(state[3]),
      .ch8(ch8_edge),
      .send_sig(send_edge)
  );

  always_ff @(posedge clk) begin
    if (!send_sig) begin
      count <= 0;
    end else if (count == signal_len) begin
      count <= 0;
    end else begin
      ch3   <= signal1[count];
      ch4   <= signal2[count];
      count <= count + 1;
    end
  end
endmodule

module seq_trig (
    input  logic clk,
    input  logic active,
    output logic ch7,
    output logic ch8,
    output logic send_sig
);
  // Trigger on channel 7 rising edge and then a falling edge of channel
  // 8 within 10 clock cycles


endmodule

module comb_trig (
    input  logic clk,
    input  logic active,
    output logic ch6,
    output logic ch7,
    output logic ch8,
    output logic send_sig
);
  // TODO: Implement combinational trigger
endmodule

module time_trig (
    input  logic clk,
    input  logic active,
    output logic send_sig
);
  // TODO: implement time trigger
endmodule

module edge_trig #(
    parameter integer signal_len = 20
) (
    input  logic clk,
    input  logic active,
    output logic ch8,
    output logic send_sig
);
  // Trigger on negative edge of channel 8

  logic [$clog2(signal_len/2):0] count = 0;

  always_ff @(posedge clk) begin
    if (active) begin
      if (count < signal_len / 2) count <= count + 1;
      else begin
        count <= 0;
        ch8 <= ~ch8;
        send_sig <= ch8;
      end
    end
  end
endmodule
