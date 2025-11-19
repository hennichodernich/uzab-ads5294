
`timescale 1 ns / 1 ps

module hex_selector #
(
  parameter integer DOUT_WIDTH = 32
)
(
  input  wire [2:0]              cfg,
  input  wire [6*DOUT_WIDTH-1:0] din,
  output wire [DOUT_WIDTH-1:0]   dout
);

  assign dout = cfg[2] ?
     (cfg[1] ? 
	  (din[DOUT_WIDTH-1:0]) : 
	  (cfg[0] ? 
	  	din[6*DOUT_WIDTH-1:5*DOUT_WIDTH] : 
		din[5*DOUT_WIDTH-1:4*DOUT_WIDTH])) :
     (cfg[1] ? 
	  (cfg[0] ? 
	  	din[4*DOUT_WIDTH-1:3*DOUT_WIDTH] : 
		din[3*DOUT_WIDTH-1:2*DOUT_WIDTH]) : 
	  (cfg[0] ? 
	  	din[2*DOUT_WIDTH-1:DOUT_WIDTH] : 
		din[DOUT_WIDTH-1:0]));

endmodule
