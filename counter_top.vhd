----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2019 07:00:37 PM
-- Design Name: 
-- Module Name: counter_top - cnt_top
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

entity counter_top is
--declare all inputs/outputs
Port (btn, sw : in std_logic_vector(3 downto 0);
      clk : in std_logic;
      led : out std_logic_vector(3 downto 0));
end counter_top;

architecture cnt_top of counter_top is

--declare component clock_div
component clock_div
Port( clk : in std_logic;
      div : out std_logic);
end component;

--declare component debounce
component Debounce
Port (btn, clk : in std_logic;
      dbnc : out std_logic);
end component;

--declare component fancy_counter
component fancy_counter
Port (clk, clk_en, dir, en, ld, rst, updn : in std_logic;
      val : in std_logic_vector(3 downto 0);
      cnt : out std_logic_vector(3 downto 0));
end component;

--dbnc represents the output of all four  debounces
--instead of four separate signals, all four variables are stored in a single vector
signal dbnc : std_logic_vector(3 downto 0) := (others => '0');
--div represents the output from the clock divider
signal div : std_logic := '0';

begin

--port map for first debounce component
u1: debounce port map ( btn => btn(0),
                        clk => clk,
                        dbnc => dbnc(0));

--port map for second debounce component
u2: debounce port map ( btn => btn(1),
                        clk => clk,
                        dbnc => dbnc(1));
                        
--port map for third debounce component
u3: debounce port map ( btn => btn(2),
                        clk => clk,
                        dbnc => dbnc(2));
                                       
--port map for fourth debounce component         
u4: debounce port map ( btn => btn(3),
                        clk => clk,
                        dbnc => dbnc(3));

--port map for clock divider component
u5: clock_div port map ( clk => clk, 
                         div => div);
                         
--port map for fancy counter component
u6: fancy_counter port map ( clk => clk,
                             clk_en => div,
                             dir => sw(0),
                             en => dbnc(1),
                             ld => dbnc(3),
                             rst => dbnc(0),
                             updn => dbnc(2),
                             val => sw,
                             cnt => led);

end cnt_top;
