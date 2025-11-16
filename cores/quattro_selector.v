
`timescale 1 ns / 1 ps

module quattro_selector #
(
  parameter integer DOUT_WIDTH = 32
)
(
  input  wire [1:0]              cfg,
  input  wire [4*DOUT_WIDTH-1:0] din,
  output wire [DOUT_WIDTH-1:0]   dout
);

  case (cfg)
	  2'b00: assign dout = din[DOUT_WIDTH-1:0];
	  2'b01: assign dout = din[2*DOUT_WIDTH-1:DOUT_WIDTH];
	  2'b10: assign dout = din[3*DOUT_WIDTH-1:2*DOUT_WIDTH];
	  2'b11: assign dout = din[4*DOUT_WIDTH-1:3*DOUT_WIDTH];
  endcase

endmodule
