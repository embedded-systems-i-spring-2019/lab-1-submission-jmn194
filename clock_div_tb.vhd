----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2019 05:17:44 PM
-- Design Name: 
-- Module Name: clock_div_tb - tb
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
use IEEE.std_logic_1164.all;

entity clock_div_tb is
end clock_div_tb;

architecture tb of clock_div_tb is

--declare component
  component clock_div
  port (
    clk : in std_logic;
    div : out std_logic
  );
  end component;

--declare intermediate signals to map to component signals
  signal tb_clk : std_logic := '0';
  signal tb_div : std_logic := '0';
  
begin

--port map for clock_div
dut: clock_div port map (clk => tb_clk, div => tb_div);

  process begin
      tb_clk <= '0';	    --set clock low
      wait for 4 ns;        --delay for 125MHz clock
      tb_clk <= '1';	    --set clock high
      wait for 4 ns;        --delay for 125MHz clock
  end process;
  
end tb;
