----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024 04:22:39 PM
-- Design Name: 
-- Module Name: clock_divider_tb - Behavioral
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

-- Entity for the testbench
entity clock_divider_tb is
end clock_divider_tb;

architecture Behavioral of clock_divider_tb is

    -- Signals to connect to the clock_divider entity
    signal clk      : std_logic := '0';  -- Clock signal
    signal reset    : std_logic := '0';  -- Reset signal
    signal tone_freq: unsigned(31 downto 0) := (others => '0');  -- Frequency control signal
    signal clk_out  : std_logic;  -- Output clock signal
    
    -- Clock period definition
    constant clk_period : time := 10 ns;  -- 100 MHz clock (10 ns period)

    -- Unit Under Test (UUT)
    component clock_divider is
        Port (
            clk      : in std_logic;
            reset    : in std_logic;
            tone_freq : in unsigned(31 downto 0);
            clk_out  : out std_logic
        );
    end component;

begin
    -- Instantiate the clock_divider
    uut: clock_divider
        Port map (
            clk => clk,
            reset => reset,
            tone_freq => tone_freq,
            clk_out => clk_out
        );

    -- Clock generation process (100 MHz clock)
    clk_process: process
    begin
        while True loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;
    
    -- Test process to apply stimulus
    stim_proc: process
    begin
        -- Apply reset for the first few cycles
        reset <= '1';
        wait for 20 ns;  -- Shorter reset duration
        reset <= '0';
        
        -- Test case 1: Tone frequency 10 (divide clock by 10 cycles)
        tone_freq <= to_unsigned(10, 32);
        wait for 100 ns;  -- Observe output for some time

        -- Test case 2: Tone frequency 20 (divide clock by 20 cycles)
        tone_freq <= to_unsigned(20, 32);
        wait for 100 ns;

        -- Test case 3: Tone frequency 40 (divide clock by 40 cycles)
        tone_freq <= to_unsigned(40, 32);
        wait for 100 ns;

        -- End simulation within 1000 ns
        wait for 200 ns;  -- Simulation stops after 500 ns total

        wait;
    end process;

end Behavioral;
