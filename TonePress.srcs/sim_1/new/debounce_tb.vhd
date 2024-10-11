----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2024 12:15:25 AM
-- Design Name: 
-- Module Name: debounce_tb - Test Bench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for debounce module
-- 
-- Dependencies: debounce.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce_tb is
-- Test bench has no ports
end debounce_tb;

architecture Behavioral of debounce_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component debounce
        Port (
            clk : in std_logic;
            reset : in std_logic;
            button : in std_logic;
            debounced_button : out std_logic
        );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal button : std_logic := '0';

    -- Outputs
    signal debounced_button : std_logic;

    -- Clock period definition (10 ns = 100 MHz)
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: debounce
        Port map (
            clk => clk,
            reset => reset,
            button => button,
            debounced_button => debounced_button
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the debounce circuit
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Simulate a button press with bounce
        button <= '0'; wait for 5 ms;
        button <= '1'; wait for 5 ms;
        button <= '0'; wait for 5 ms;
        button <= '1'; wait for 5 ms;
        button <= '0'; wait for 5 ms;
        
        -- Stable button press
        button <= '1'; wait for 12 ms;  -- Wait for debounce time 
        
        -- Simulate button release with bounce
        button <= '0'; wait for 5 ms;
        button <= '1'; wait for 5 ms;
        button <= '0'; wait for 5 ms;
        button <= '1'; wait for 5 ms;
        button <= '0'; wait for 12 ms;  -- Wait for debounce time

        -- End simulation
        wait;
    end process;

end Behavioral;
