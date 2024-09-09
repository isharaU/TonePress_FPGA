----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/08/2024 11:00:58 PM
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    Port (
        clk      : in std_logic;  -- 100 MHz clock input
        reset    : in std_logic;  -- Reset signal
        tone_freq : in unsigned(31 downto 0); -- Frequency control input (e.g., 227272 for 440 Hz)
        clk_out  : out std_logic  -- Output clock for the PWM (divided clock)
    );
end clock_divider;

architecture Behavioral of clock_divider is

    signal clk_counter : unsigned(31 downto 0) := (others => '0');  -- Clock counter
    signal pwm_out     : std_logic := '0';  -- Divided clock signal (square wave)
    
begin
    -- Clock divider process
    process (clk, reset)
    begin
        if reset = '1' then
            clk_counter <= (others => '0');  -- Reset the counter
            pwm_out <= '0';  -- Reset the PWM output
        elsif rising_edge(clk) then
            if clk_counter = tone_freq then
                clk_counter <= (others => '0');  -- Reset the counter
                pwm_out <= not pwm_out;  -- Toggle the PWM output
            else
                clk_counter <= clk_counter + 1;  -- Increment the counter
            end if;
        end if;
    end process;
    
    -- Output the divided clock signal
    clk_out <= pwm_out;
    
end Behavioral;

