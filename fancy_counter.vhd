----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2019 06:33:26 PM
-- Design Name: 
-- Module Name: fancy_counter - f_count
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

entity fancy_counter is
--declare all inputs/outputs
Port (clk, clk_en, dir, en, ld, rst, updn : in std_logic;
      val : in std_logic_vector(3 downto 0);
      cnt : out std_logic_vector(3 downto 0));
end fancy_counter;

architecture f_count of fancy_counter is

signal counter : std_logic_vector(3 downto 0) := (others => '0'); --counter used to count from 0 to 15
signal value : std_logic_vector(3 downto 0) := (others => '0');	  --used to store the current value
signal direction : std_logic := '0';			--represents counting direction (up or down)

begin

process(clk, en)
begin
if ( en = '1') then	--check if enable is high, do nothing if enable is low
  if (rising_edge(clk)) then	--check if the clock is high, do nothing is the clock is low
    if ( clk_en = '1') then	--check if the clock enable is high
      if ( ld = '1') then	--check if ld is high
        value <= val;		--update intermediate value using val from entity input
      end if;
      if (updn = '1') then	--check if up/down signal is high
        direction <= dir;	--update direction signal
      end if;
        if (direction = '1') then	--check if the direction is 1 (incrementing)
          if (unsigned(counter) < unsigned(value)) then		--ensure counter doesn't go beyond 15 (4 bits)
            counter <= std_logic_vector(unsigned(counter) + 1);	--increment the counter signal
            cnt <= counter;					--update cnt entity output
          else counter <= (others => '0');	--reset counter if it goes over 15
          end if;
        else	--runs when direction is 0 (decrementing)
          if (unsigned(counter) > "0000") then	--check for underflow
            counter <= std_logic_vector(unsigned(counter) - 1);	--decrement counter
            cnt <= counter;	--update cnt entity output
          else counter <= value;	--update counter from value
            cnt <= counter;		--update cnt entity output
          end if;
          end if;
      elsif (rst = '1') then	--if clock enable is not high, check if reset is high
          counter <= (others => '0');	--reset the counter intermediate signal
          cnt <= counter;		--reset the cnt output signal using counter
        end if;
  end if;
end if;

end process;

end f_count;
