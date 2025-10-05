set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets system_i/mmcm_0/inst/clk_in1_system_mmcm_0_0]

create_clock -period 3.6743 -name bit_clk -add [get_ports lclk_p_0]
create_clock -period 12.860 -name sample_clk -waveform {0.000 6.430} -add [get_ports aclk_p_0]

# clock

set_property IOSTANDARD LVDS_25 [get_ports lclk_p_0]
set_property IOSTANDARD LVDS_25 [get_ports lclk_n_0]

set_property DIFF_TERM TRUE [get_ports lclk_p_0]
set_property DIFF_TERM TRUE [get_ports lclk_n_0]

set_property PACKAGE_PIN Y18 [get_ports lclk_p_0]
set_property PACKAGE_PIN AA18 [get_ports lclk_n_0]

# clock

set_property IOSTANDARD LVDS_25 [get_ports aclk_p_0]
set_property IOSTANDARD LVDS_25 [get_ports aclk_n_0]

set_property DIFF_TERM TRUE [get_ports aclk_p_0]
set_property DIFF_TERM TRUE [get_ports aclk_n_0]

set_property PACKAGE_PIN Y19 [get_ports aclk_p_0]
set_property PACKAGE_PIN AA19 [get_ports aclk_n_0]

# data

set_property IOSTANDARD LVDS_25 [get_ports {din_a_p_0[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {din_a_n_0[*]}]

set_property DIFF_TERM true [get_ports {din_a_p_0[*]}]
set_property DIFF_TERM true [get_ports {din_a_n_0[*]}]

set_property PACKAGE_PIN T22 [get_ports {din_a_p_0[0]}]
set_property PACKAGE_PIN U22 [get_ports {din_a_n_0[0]}]
set_property PACKAGE_PIN AA22 [get_ports {din_a_p_0[1]}]
set_property PACKAGE_PIN AB22 [get_ports {din_a_n_0[1]}]

set_property IOSTANDARD LVDS_25 [get_ports {din_b_p_0[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {din_b_n_0[*]}]

set_property DIFF_TERM true [get_ports {din_b_p_0[*]}]
set_property DIFF_TERM true [get_ports {din_b_n_0[*]}]

set_property PACKAGE_PIN V22 [get_ports {din_b_p_0[0]}]
set_property PACKAGE_PIN W22 [get_ports {din_b_n_0[0]}]
set_property PACKAGE_PIN AA21 [get_ports {din_b_p_0[1]}]
set_property PACKAGE_PIN AB21 [get_ports {din_b_n_0[1]}]


# SPI

set_property IOSTANDARD LVCMOS18 [get_ports adc_spi_*]
set_property IOSTANDARD LVCMOS18 [get_ports dac_spi_*]

set_property PACKAGE_PIN Y9 [get_ports adc_spi_sclk]
set_property PACKAGE_PIN W10 [get_ports adc_spi_mosi]
set_property PACKAGE_PIN Y10 [get_ports adc_spi_miso]
set_property PACKAGE_PIN Y11 [get_ports adc_spi_cs]
set_property PACKAGE_PIN Y8 [get_ports dac_spi_cs]

set_property IOSTANDARD LVCMOS18 [get_ports dac_clk]
set_property PACKAGE_PIN AA8 [get_ports dac_clk]

# output enable

set_property IOSTANDARD LVCMOS18 [get_ports {adc_reset}]
set_property PACKAGE_PIN W11 [get_ports {adc_reset}]

set_property IOSTANDARD LVCMOS18 [get_ports {dac_dat_o[*]}]
set_property PACKAGE_PIN AB1 [get_ports {dac_dat_o[0]}]
set_property PACKAGE_PIN AB2 [get_ports {dac_dat_o[1]}]
set_property PACKAGE_PIN AA4 [get_ports {dac_dat_o[2]}]
set_property PACKAGE_PIN AB4 [get_ports {dac_dat_o[3]}]
set_property PACKAGE_PIN AB5 [get_ports {dac_dat_o[4]}]
set_property PACKAGE_PIN AA6 [get_ports {dac_dat_o[5]}]
set_property PACKAGE_PIN AB6 [get_ports {dac_dat_o[6]}]
set_property PACKAGE_PIN AA7 [get_ports {dac_dat_o[7]}]
set_property PACKAGE_PIN AB7 [get_ports {dac_dat_o[8]}]
set_property PACKAGE_PIN AA9 [get_ports {dac_dat_o[9]}]
set_property PACKAGE_PIN AB9 [get_ports {dac_dat_o[10]}]
set_property PACKAGE_PIN AB10 [get_ports {dac_dat_o[11]}]
set_property PACKAGE_PIN AA11 [get_ports {dac_dat_o[12]}]
set_property PACKAGE_PIN AB11 [get_ports {dac_dat_o[13]}]


set_property IOSTANDARD LVCMOS33 [get_ports {exp_p_tri_io[*]}]
set_property SLEW FAST [get_ports {exp_p_tri_io[*]}]
set_property DRIVE 8 [get_ports {exp_p_tri_io[*]}]

set_property PACKAGE_PIN A19 [get_ports {exp_p_tri_io[0]}]
set_property PACKAGE_PIN A21 [get_ports {exp_p_tri_io[1]}]
set_property PACKAGE_PIN A22 [get_ports {exp_p_tri_io[2]}]
set_property PACKAGE_PIN B21 [get_ports {exp_p_tri_io[3]}]
set_property PACKAGE_PIN B22 [get_ports {exp_p_tri_io[4]}]
set_property PACKAGE_PIN C22 [get_ports {exp_p_tri_io[5]}]
set_property PACKAGE_PIN D22 [get_ports {exp_p_tri_io[6]}]
set_property PACKAGE_PIN E21 [get_ports {exp_p_tri_io[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {exp_n_tri_io[*]}]
set_property SLEW FAST [get_ports {exp_n_tri_io[*]}]
set_property DRIVE 8 [get_ports {exp_n_tri_io[*]}]

set_property PACKAGE_PIN A18 [get_ports {exp_n_tri_io[0]}]
set_property PACKAGE_PIN C18 [get_ports {exp_n_tri_io[1]}]
set_property PACKAGE_PIN C17 [get_ports {exp_n_tri_io[2]}]
set_property PACKAGE_PIN C19 [get_ports {exp_n_tri_io[3]}]

set_property PULLTYPE PULLUP [get_ports {exp_n_tri_io[0]}]
set_property PULLTYPE PULLUP [get_ports {exp_n_tri_io[1]}]
set_property PULLTYPE PULLUP [get_ports {exp_n_tri_io[2]}]
set_property PULLTYPE PULLUP [get_ports {exp_n_tri_io[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {exp_n_alex[*]}]
set_property SLEW FAST [get_ports {exp_n_alex[*]}]
set_property DRIVE 8 [get_ports {exp_n_alex[*]}]

set_property PACKAGE_PIN B20 [get_ports {exp_n_alex[0]}]
set_property PACKAGE_PIN C20 [get_ports {exp_n_alex[1]}]
set_property PACKAGE_PIN D21 [get_ports {exp_n_alex[2]}]
set_property PACKAGE_PIN F22 [get_ports {exp_n_alex[3]}]
