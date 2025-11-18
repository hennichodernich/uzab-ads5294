
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

  assign dout = cfg[1] ? (cfg[0] ? din[4*DOUT_WIDTH-1:3*DOUT_WIDTH] : din[3*DOUT_WIDTH-1:2*DOUT_WIDTH]) : (cfg[0] ? din[2*DOUT_WIDTH-1:DOUT_WIDTH] : din[DOUT_WIDTH-1:0]);

endmodule
