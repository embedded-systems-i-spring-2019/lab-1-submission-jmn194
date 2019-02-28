----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2019 06:10:52 PM
-- Design Name: 
-- Module Name: debounce_tb - tb
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_tb is
end debounce_tb;

architecture tb of debounce_tb is

--declare component
component debounce
Port (btn, clk : in std_logic;
      dbnc : out std_logic);
end component;

--declare signals to map to component ports
signal tb_btn : std_logic := '0';
signal tb_clk : std_logic := '0';
signal tb_dbnc : std_logic := '0';

begin

--port mapping of debounce component
dut: Debounce port map(btn => tb_btn,
                       clk => tb_clk,
                       dbnc => tb_dbnc);

  process begin
      tb_clk <= '0';	    --set clock low
      wait for 4 ns;        --delay for 125MHz clock
      tb_clk <= '1';	    --set clock high
      wait for 4 ns;        --delay for 125MHz clock
  end process;

process
begin

--the following are various button inputs to test debouncing

--output should stay low because button only pressed for 5ms
tb_btn <= '1';	--"push" button
wait for 5 ms;	--hold button for 5 ms
tb_btn <= '0';	--reset button

wait for 5 ms;	--5 ms delay just to clear up synthesis output

--output should go high for 1 ms at the end of the button press
tb_btn <= '1';
wait for 21 ms;
tb_btn <= '0';

wait for 4 ms;	--4 ms delay to clear up synthesis output

--output should go high after 20 ms and stay high for 21 ms
tb_btn <= '1';
wait for 41 ms;
tb_btn <= '0';

wait;


end process;

end tb;
