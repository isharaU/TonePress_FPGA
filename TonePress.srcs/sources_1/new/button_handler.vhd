----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/08/2024 11:32:27 PM
-- Design Name: 
-- Module Name: button_handler - Behavioral
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

entity button_handler is
    Port (
        btnL      : in std_logic;    -- Button Left
        btnR      : in std_logic;    -- Button Right
        btnU      : in std_logic;    -- Button Up
        btnD      : in std_logic;    -- Button Down
        tone_freq : out unsigned(31 downto 0)  -- Output frequency for clock divider
    );
end button_handler;

architecture Behavioral of button_handler is
    -- Declare constants for different frequencies (calculated based on 100 MHz clock)
    constant FREQ_A4 : unsigned(31 downto 0) := to_unsigned(227272, 32);  -- 440 Hz (A4)
    constant FREQ_B4 : unsigned(31 downto 0) := to_unsigned(202478, 32);  -- 493.88 Hz (B4)
    constant FREQ_C5 : unsigned(31 downto 0) := to_unsigned(191113, 32);  -- 523.25 Hz (C5)
    constant FREQ_D5 : unsigned(31 downto 0) := to_unsigned(170648, 32);  -- 587.33 Hz (D5)
    constant FREQ_80 : unsigned(31 downto 0) := to_unsigned(625000, 32);  -- 80 Hz

begin
    -- Process to handle the button presses and assign corresponding frequencies
    process (btnL, btnR, btnU, btnD)
    begin
        if btnL = '1' then
            tone_freq <= FREQ_A4;  -- Button Left: Set frequency for A4 (440 Hz)
        elsif btnR = '1' then
            tone_freq <= FREQ_B4;  -- Button Right: Set frequency for B4 (493.88 Hz)
        elsif btnU = '1' then
            tone_freq <= FREQ_C5;  -- Button Up: Set frequency for C5 (523.25 Hz)
        elsif btnD = '1' then
            tone_freq <= FREQ_D5;  -- Button Down: Set frequency for D5 (587.33 Hz)
        else
            tone_freq <= FREQ_80;  -- Default: A4 (440 Hz) if no button is pressed
        end if;
    end process;

end Behavioral;
