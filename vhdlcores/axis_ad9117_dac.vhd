library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity axis_ad9117_dac is
    generic(dac_width : integer := 14); 
    Port ( data_out : out STD_LOGIC_VECTOR (dac_width-1 downto 0);
           data_in : in STD_LOGIC_VECTOR (31 downto 0);
           clk_in : in STD_LOGIC;
           data_valid : in STD_LOGIC;
           reset_in : in STD_LOGIC);
end axis_ad9117_dac;

architecture Behavioral of axis_ad9117_dac is

signal reset_i: std_logic;
signal data_rising_in, data_falling_in : STD_LOGIC_VECTOR (dac_width-1 downto 0);

begin

    reset_i <= reset_in;

    process(clk_in)
    begin
	    if (data_valid='1') then
		 data_rising_in <= (not data_in(15)) & data_in(14 downto (16-dac_width));
		 data_falling_in <= (not data_in(31)) & data_in(30 downto (32-dac_width));
	    else
		 data_rising_in <= (others => '0');
		 data_falling_in <= (others => '0');
	    end if;
    end process;

    ddr_mux: for i in 0 to (dac_width-1) generate
        ODDR_inst : ODDR 
        generic map (
            DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE" 
                                             -- or "SAME_EDGE_PIPELINED" 
            INIT => '0', -- Initial value of Q '0' or '1'
            SRTYPE => "SYNC") -- Set/Reset type: "SYNC" or "ASYNC" 
        port map (
            Q => data_out(i),
            C => clk_in,   -- 1-bit clock input
            CE => '1', -- 1-bit clock enable input
            D1 => data_falling_in(i), 
            D2 => data_rising_in(i),            
            R => reset_i,   -- 1-bit reset
            S => '0'    -- 1-bit set
        );
      end generate ddr_mux;


end Behavioral;					
