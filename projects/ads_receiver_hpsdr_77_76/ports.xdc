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
set_property IOSTANDARD LVDS_25 [get_ports {din_b_p_0[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {din_b_n_0[*]}]

set_property DIFF_TERM true [get_ports {din_a_p_0[*]}]
set_property DIFF_TERM true [get_ports {din_a_n_0[*]}]
set_property DIFF_TERM true [get_ports {din_b_p_0[*]}]
set_property DIFF_TERM true [get_ports {din_b_n_0[*]}]

# ADC ch 8
set_property PACKAGE_PIN V13 [get_ports {din_a_p_0[0]}] 
set_property PACKAGE_PIN W13 [get_ports {din_a_n_0[0]}]
set_property PACKAGE_PIN Y14 [get_ports {din_b_p_0[0]}]
set_property PACKAGE_PIN AA14 [get_ports {din_b_n_0[0]}]
# ADC ch 7
set_property PACKAGE_PIN Y13 [get_ports {din_a_p_0[1]}] 
set_property PACKAGE_PIN AA13 [get_ports {din_a_n_0[1]}]
set_property PACKAGE_PIN W15 [get_ports {din_b_p_0[1]}]
set_property PACKAGE_PIN Y15 [get_ports {din_b_n_0[1]}]
# ADC ch 2
set_property PACKAGE_PIN Y20 [get_ports {din_a_p_0[2]}]
set_property PACKAGE_PIN Y21 [get_ports {din_a_n_0[2]}]
set_property PACKAGE_PIN T21 [get_ports {din_b_p_0[2]}]
set_property PACKAGE_PIN U21 [get_ports {din_b_n_0[2]}]
# ADC ch 6
set_property PACKAGE_PIN AA16 [get_ports {din_a_p_0[3]}]
set_property PACKAGE_PIN AB16 [get_ports {din_a_n_0[3]}]
set_property PACKAGE_PIN V14 [get_ports {din_b_p_0[3]}]
set_property PACKAGE_PIN V15 [get_ports {din_b_n_0[3]}]
# ADC ch 4
set_property PACKAGE_PIN AA22 [get_ports {din_a_p_0[4]}]
set_property PACKAGE_PIN AB22 [get_ports {din_a_n_0[4]}]
set_property PACKAGE_PIN AA21 [get_ports {din_b_p_0[4]}]
set_property PACKAGE_PIN AB21 [get_ports {din_b_n_0[4]}]
# ADC ch 1
set_property PACKAGE_PIN T22 [get_ports {din_a_p_0[5]}] 
set_property PACKAGE_PIN U22 [get_ports {din_a_n_0[5]}]
set_property PACKAGE_PIN V22 [get_ports {din_b_p_0[5]}]
set_property PACKAGE_PIN W22 [get_ports {din_b_n_0[5]}]





# SPI

set_property IOSTANDARD LVCMOS18 [get_ports adc_spi_*]

set_property PACKAGE_PIN Y9 [get_ports adc_spi_sclk]
set_property PACKAGE_PIN W10 [get_ports adc_spi_mosi]
set_property PACKAGE_PIN Y10 [get_ports adc_spi_miso]
set_property PACKAGE_PIN Y11 [get_ports adc_spi_cs]

# output enable

set_property IOSTANDARD LVCMOS18 [get_ports {adc_reset}]
set_property PACKAGE_PIN W11 [get_ports {adc_reset}]


