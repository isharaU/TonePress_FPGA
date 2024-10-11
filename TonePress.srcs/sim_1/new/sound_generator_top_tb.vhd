----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024
-- Design Name: 
-- Module Name: sound_generator_top_tb - Test Bench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for sound_generator_top module
-- 
-- Dependencies: sound_generator_top.vhd, debounce.vhd, button_handler.vhd,
--               clock_divider.vhd, pwm_generator.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sound_generator_top_tb is
-- Testbench has no ports
end sound_generator_top_tb;

architecture Behavioral of sound_generator_top_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component sound_generator_top
        Port (
            clk     : in std_logic;
            reset   : in std_logic;
            btnL    : in std_logic;
            btnR    : in std_logic;
            btnU    : in std_logic;
            btnD    : in std_logic;
            speaker : out std_logic
        );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal btnL : std_logic := '0';
    signal btnR : std_logic := '0';
    signal btnU : std_logic := '0';
    signal btnD : std_logic := '0';

    -- Outputs
    signal speaker : std_logic;

    -- Clock period definition (10 ns = 100 MHz)
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: sound_generator_top
        Port map (
            clk => clk,
            reset => reset,
            btnL => btnL,
            btnR => btnR,
            btnU => btnU,
            btnD => btnD,
            speaker => speaker
        );

    -- Clock process definitions
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 15 ms;
        reset <= '0';
        wait for 5 ms;
        
        -- Simulate button presses
        
        -- Press left button (btnL)
        btnL <= '1';
        wait for 11 ms;
        btnL <= '0';
        wait for 5 ms;  -- Wait to see PWM output effect

        -- Apply reset
        reset <= '1';
        wait for 15 ms;
        reset <= '0';
        wait for 5 ms;
        
        -- Press right button (btnR)
        btnR <= '1';
        wait for 11 ms;
        btnR <= '0';
        wait for 5 ms;  -- Wait to see PWM output effect

        -- Apply reset
        reset <= '1';
        wait for 15 ms;
        reset <= '0';
        wait for 5 ms;
        
        -- Press up button (btnU)
        btnU <= '1';
        wait for 11 ms;
        btnU <= '0';
        wait for 5 ms;  -- Wait to see PWM output effect

        -- Apply reset
        reset <= '1';
        wait for 15 ms;
        reset <= '0';
        wait for 5 ms;
        
        -- Press down button (btnD)
        btnD <= '1';
        wait for 11 ms;
        btnD <= '0';
        wait for 5 ms;  -- Wait to see PWM output effect
        
        -- End simulation
        wait;
    end process;

end Behavioral;
