# Create ports
create_bd_port -dir I lclk_p_0 
create_bd_port -dir I lclk_n_0
create_bd_port -dir I aclk_p_0
create_bd_port -dir I aclk_n_0
create_bd_port -dir I -from 1 -to 0 din_a_p_0
create_bd_port -dir I -from 1 -to 0 din_a_n_0
create_bd_port -dir I -from 1 -to 0 din_b_p_0
create_bd_port -dir I -from 1 -to 0 din_b_n_0

create_bd_port -dir O adc_spi_sclk
create_bd_port -dir O adc_spi_mosi
create_bd_port -dir I adc_spi_miso
create_bd_port -dir O adc_spi_cs
create_bd_port -dir O dac_spi_cs
create_bd_port -dir O adc_reset

create_bd_port -dir O -from 13 -to 0 dac_dat_o
create_bd_port -dir O dac_clk

create_bd_port -dir IO -from 7 -to 0 exp_p_tri_io
create_bd_port -dir IO -from 3 -to 0 exp_n_tri_io
create_bd_port -dir IO -from 3 -to 0 exp_n_alex

# Create xlconstant
cell xilinx.com:ip:xlconstant const_0

# Create clk_wiz
cell xilinx.com:ip:clk_wiz:6.0 mmcm_0 {
    PRIMITIVE MMCM
    NUM_OUT_CLKS 3
    PRIM_IN_FREQ 272.16
    PRIM_SOURCE Differential_clock_capable_pin
    USE_RESET false
    CLKOUT1_DRIVES BUFG
    CLKOUT1_JITTER 109.769
    CLKOUT1_PHASE_ERROR 81.996
    CLKOUT1_REQUESTED_OUT_FREQ 77.76
    CLKOUT1_REQUESTED_PHASE 180
    CLKOUT1_USED true
    CLKOUT2_DRIVES BUFG
    CLKOUT2_JITTER 85.845
    CLKOUT2_PHASE_ERROR 81.996
    CLKOUT2_REQUESTED_OUT_FREQ 272.16
    CLKOUT2_REQUESTED_PHASE 180.000
    CLKOUT2_USED true
    CLKOUT3_DRIVES BUFG
    CLKOUT3_JITTER 126.149
    CLKOUT3_PHASE_ERROR 81.996
    CLKOUT3_REQUESTED_OUT_FREQ 38.88
    CLKOUT3_REQUESTED_PHASE 90.000
    CLKOUT3_USED true
    FEEDBACK_SOURCE FDBK_AUTO
} {
  clk_in1_p lclk_p_0
  clk_in1_n lclk_n_0
  locked led_o
  clk_out1 dac_clk
}

# Create processing_system7
cell xilinx.com:ip:processing_system7 ps_0 {
  PCW_IMPORT_BOARD_PRESET cfg/hnchzynqboard.xml
  PCW_USE_M_AXI_GP1 1
  PCW_FPGA0_PERIPHERAL_FREQMHZ 200
  PCW_CLK0_FREQ 200000000
  PCW_FPGA_FCLK0_ENABLE 1
} {
  M_AXI_GP0_ACLK mmcm_0/clk_out1
  M_AXI_GP1_ACLK mmcm_0/clk_out1
  SPI0_SCLK_O adc_spi_sclk
  SPI0_MOSI_O adc_spi_mosi
  SPI0_MISO_I adc_spi_miso
  SPI0_SS_I const_0/dout
  SPI0_SS_O adc_spi_cs
  SPI0_SS1_O dac_spi_cs
}

# Create all required interconnections
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {
  make_external {FIXED_IO, DDR}
  Master Disable
  Slave Disable
} [get_bd_cells ps_0]

# Create proc_sys_reset
cell xilinx.com:ip:proc_sys_reset rst_0 {} {
  ext_reset_in const_0/dout
  dcm_locked mmcm_0/locked
  slowest_sync_clk mmcm_0/clk_out3
}

# HUB

# Create axi_hub
cell pavel-demin:user:axi_hub hub_0 {
  CFG_DATA_WIDTH 320
  STS_DATA_WIDTH 96
} {
  S_AXI ps_0/M_AXI_GP0
  aclk mmcm_0/clk_out1
  aresetn rst_0/peripheral_aresetn
}

# Map lowest GPIO to adc_reset
cell pavel-demin:user:port_slicer adc_reset_slice {
  DIN_WIDTH 64 DIN_FROM 0 DIN_TO 0
} {
  din ps_0/GPIO_O
  dout adc_reset
}
# Map second lowest GPIO to bit_slip 
cell pavel-demin:user:port_slicer bit_slip_slice {
  DIN_WIDTH 64 DIN_FROM 1 DIN_TO 1
} {
  din ps_0/GPIO_O
}

# ADC

cell hnch:user:axis_ads5294_twolane_doubleword axis_ads5294_twolane_0 {
  NUMBER_OF_LANES 2
} {
  frame_clock_p aclk_p_0
  frame_clock_n aclk_n_0
  sample_clk mmcm_0/clk_out1
  bit_clock mmcm_0/clk_out2
  half_clk mmcm_0/clk_out3
  din_a_p din_a_p_0
  din_a_n din_a_n_0
  din_b_p din_b_p_0
  din_b_n din_b_n_0
  serdes_rst rst_0/peripheral_reset
  bit_slip bit_slip_slice/dout
}
# idelay_ctrl
cell xilinx.com:ip:util_idelay_ctrl util_idelay_ctrl_0 {
} {
  ref_clk ps_0/FCLK_CLK0
  rst rst_0/peripheral_reset
}
# Split ADC output word to apply sign extension individually
cell pavel-demin:user:port_slicer slice_201 {
  DIN_WIDTH 28 DIN_FROM 13 DIN_TO 0
} {
  din axis_ads5294_twolane_0/data_out
}
cell pavel-demin:user:port_slicer slice_202 {
  DIN_WIDTH 28 DIN_FROM 27 DIN_TO 14
} {
  din axis_ads5294_twolane_0/data_out
}

# DAC

# Create axis_ad9117_dac
cell hnch:user:axis_ad9117_dac dac_0 {
  DAC_WIDTH 14
} {
  clk_in mmcm_0/clk_out1
  data_out dac_dat_o
  data_valid const_0/dout
  reset_in rst_0/peripheral_reset
}

# GPIO


# Create gpio_debouncer
cell pavel-demin:user:gpio_debouncer gpio_0 {
  DATA_WIDTH 4
  CNTR_WIDTH 16
} {
  gpio_data exp_n_tri_io
  aclk mmcm_0/clk_out1
}

# Create util_vector_logic
cell xilinx.com:ip:util_vector_logic not_0 {
  C_SIZE 4
  C_OPERATION not
} {
  Op1 gpio_0/deb_data
}

# Slice out config bits
cell pavel-demin:user:port_slicer out_slice_0 {
  DIN_WIDTH 320 DIN_FROM 31 DIN_TO 24
} {
  din hub_0/cfg_data
}
cell pavel-demin:user:port_slicer ptt_slice_0 {
  DIN_WIDTH 320 DIN_FROM 21 DIN_TO 21
} {
  din hub_0/cfg_data
}

# Create util_vector_logic
cell xilinx.com:ip:util_vector_logic or_0 {
  C_SIZE 1
  C_OPERATION or
} {
  Op1 ptt_slice_0/dout
  Op2 not_0/Res
}

# Create util_vector_logic
cell xilinx.com:ip:util_vector_logic or_1 {
  C_SIZE 8
  C_OPERATION or
} {
  Op1 out_slice_0/dout
  Op2 or_0/Res
  Res exp_p_tri_io
}

# ALEX

# Create axis_fifo
cell pavel-demin:user:axis_fifo fifo_0 {
  S_AXIS_TDATA_WIDTH 32
  M_AXIS_TDATA_WIDTH 32
  WRITE_DEPTH 1024
} {
  S_AXIS hub_0/M03_AXIS
  aclk mmcm_0/clk_out1
  aresetn rst_0/peripheral_aresetn
}

# Create axis_alex
cell pavel-demin:user:axis_alex alex_0 {} {
  S_AXIS fifo_0/M_AXIS
  aclk mmcm_0/clk_out1
  aresetn rst_0/peripheral_aresetn
}

# RX 0

# Create port_slicer
cell pavel-demin:user:port_slicer rst_slice_0 {
  DIN_WIDTH 320 DIN_FROM 7 DIN_TO 0
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer rst_slice_1 {
  DIN_WIDTH 320 DIN_FROM 15 DIN_TO 8
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer cfg_slice_0 {
  DIN_WIDTH 320 DIN_FROM 159 DIN_TO 32
} {
  din hub_0/cfg_data
}

module rx_0 {
  source projects/sdr_transceiver_hpsdr/rx.tcl
} {
  slice_0/din rst_slice_0/dout
  slice_1/din rst_slice_1/dout
  slice_2/din rst_slice_1/dout
  slice_3/din cfg_slice_0/dout
  slice_4/din cfg_slice_0/dout
  slice_5/din cfg_slice_0/dout
  slice_6/din cfg_slice_0/dout
  slice_7/din cfg_slice_0/dout
  slice_8/din cfg_slice_0/dout
  slice_9/din cfg_slice_0/dout
  slice_10/din cfg_slice_0/dout
}

# TX 0

# Create port_slicer
cell pavel-demin:user:port_slicer rst_slice_2 {
  DIN_WIDTH 320 DIN_FROM 16 DIN_TO 16
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer rst_slice_3 {
  DIN_WIDTH 320 DIN_FROM 17 DIN_TO 17
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer key_slice_0 {
  DIN_WIDTH 320 DIN_FROM 18 DIN_TO 18
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer key_slice_1 {
  DIN_WIDTH 320 DIN_FROM 19 DIN_TO 19
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer sel_slice_0 {
  DIN_WIDTH 320 DIN_FROM 20 DIN_TO 20
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer cfg_slice_1 {
  DIN_WIDTH 320 DIN_FROM 255 DIN_TO 160
} {
  din hub_0/cfg_data
}

module tx_0 {
  source projects/sdr_transceiver_hpsdr/tx.tcl
} {
  fifo_0/aresetn rst_slice_2/dout
  keyer_0/key_flag key_slice_0/dout
  sel_0/cfg_data sel_slice_0/dout
  slice_0/din rst_slice_1/dout
  slice_1/din cfg_slice_1/dout
  slice_2/din cfg_slice_1/dout
  slice_3/din cfg_slice_1/dout
  slice_4/din cfg_slice_1/dout
  slice_5/din cfg_slice_1/dout
  slice_6/din cfg_slice_1/dout
  dds_0/m_axis_data_tdata rx_0/dds_slice_6/din
  dds_0/m_axis_data_tdata rx_0/dds_slice_7/din
  dds_0/m_axis_data_tdata rx_0/dds_slice_8/din
  dds_0/m_axis_data_tdata rx_0/dds_slice_9/din
  concat_1/dout dac_0/data_in
  mult_2/P rx_0/adc_slice_8/din
  mult_2/P rx_0/adc_slice_9/din
}

# CODEC

# Create port_slicer
cell pavel-demin:user:port_slicer cfg_slice_2 {
  DIN_WIDTH 320 DIN_FROM 319 DIN_TO 256
} {
  din hub_0/cfg_data
}

module codec {
  source projects/sdr_transceiver_hpsdr/codec.tcl
} {
  fifo_0/aresetn rst_slice_3/dout
  keyer_0/key_flag key_slice_1/dout
  slice_0/din rst_slice_0/dout
  slice_1/din rst_slice_0/dout
  slice_2/din cfg_slice_2/dout
  slice_3/din cfg_slice_2/dout
  slice_4/din cfg_slice_2/dout
  i2s_0/gpio_data exp_n_alex
  i2s_0/alex_data alex_0/alex_data
}

# STS

# Create xlconcat
cell xilinx.com:ip:xlconcat concat_0 {
  NUM_PORTS 5
  IN0_WIDTH 16
  IN1_WIDTH 16
  IN2_WIDTH 16
  IN3_WIDTH 16
  IN4_WIDTH 4
} {
  In0 rx_0/fifo_0/read_count
  In1 tx_0/fifo_0/write_count
  In2 codec/fifo_0/write_count
  In3 codec/fifo_1/read_count
  In4 not_0/Res
  dout hub_0/sts_data
}

wire rx_0/fifo_0/M_AXIS hub_0/S00_AXIS
wire tx_0/fifo_0/S_AXIS hub_0/M00_AXIS

wire codec/fifo_0/S_AXIS hub_0/M01_AXIS
wire codec/fifo_1/M_AXIS hub_0/S01_AXIS

wire tx_0/bram_0/BRAM_PORTA hub_0/B04_BRAM
wire codec/bram_0/BRAM_PORTA hub_0/B05_BRAM

# RX 1

module rx_1 {
  source projects/ads_receiver_77_76/rx.tcl
} {
  hub_0/S_AXI ps_0/M_AXI_GP1
}
