----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024
-- Design Name: 
-- Module Name: pwm_generator_tb - Testbench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for PWM generator module
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

-- Entity declaration for the testbench
entity pwm_generator_tb is
end pwm_generator_tb;

architecture Behavioral of pwm_generator_tb is

    -- Testbench signals
    signal clk_in   : std_logic := '0';         -- Clock input signal
    signal reset    : std_logic := '0';         -- Reset signal
    signal pwm_out  : std_logic;                -- PWM output signal
    
    -- Clock period constant (Assuming a 100 MHz clock)
    constant clk_period : time := 10 ns;

    -- Unit Under Test (UUT)
    component pwm_generator is
        Port (
            clk_in   : in std_logic;
            reset    : in std_logic;
            pwm_out  : out std_logic
        );
    end component;

begin

    -- Instantiate the PWM generator
    uut: pwm_generator
        Port map (
            clk_in => clk_in,
            reset  => reset,
            pwm_out => pwm_out
        );

    -- Clock generation process (100 MHz clock)
    clk_process: process
    begin
        while True loop
            clk_in <= '0';
            wait for clk_period / 2;
            clk_in <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: Apply reset
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        
        -- Wait for some time to observe PWM output
        wait for 500 ns;

        -- Test case 2: Apply reset again
        reset <= '1';
        wait for 50 ns;
        reset <= '0';

        -- End simulation after observing output for a while
        wait for 500 ns;
        wait;
    end process;

end Behavioral;
