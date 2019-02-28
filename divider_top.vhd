----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2019 05:31:04 PM
-- Design Name: 
-- Module Name: divider_top - div_top
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider_top is
  Port (clk : in std_logic;	--clk is input clock signal
        led0 : out std_logic);	--led0 is the output LED signal
end divider_top;

architecture div_top of divider_top is

--declare component to utilize clock_div from other VHDL file
component clock_div
port (
  clk : in std_logic;
  div : out std_logic
);
end component;

--declare signals to be used in port mapping
signal div : std_logic := '0';
signal led : std_logic := '0';

begin

-declare clock_div component named U1 and define port mapping
U1: clock_div port map(clk => clk,
                       div => div);
                       
process(clk)
  begin
    if rising_edge(clk) then
      if div = '1' then
        led <= not led;	--invert led output when div is high
      end if;
    end if;

--update entity led0 with signal led
led0 <= led;
end process;

end div_top;
