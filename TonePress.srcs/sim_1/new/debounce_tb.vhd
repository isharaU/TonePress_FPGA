----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024
-- Design Name: 
-- Module Name: debounce_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Test bench for the debounce module
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

-- Testbench entity
entity debounce_tb is
end debounce_tb;

architecture Behavioral of debounce_tb is
    -- Testbench signals
    signal clk               : std_logic := '0';
    signal reset             : std_logic := '0';
    signal button            : std_logic := '0';
    signal debounced_button  : std_logic;
    signal debounce_time     : unsigned(19 downto 0) := to_unsigned(1000000, 20);  -- 10 ms debounce time
    
    -- Clock period definition
    constant clk_period : time := 10 ns;  -- 100 MHz clock

    -- Unit Under Test (UUT)
    component debounce
        Port (
            clk              : in std_logic;
            reset            : in std_logic;
            button           : in std_logic;
            debounce_time    : in unsigned(19 downto 0);
            debounced_button : out std_logic
        );
    end component;

begin
    -- Instantiate the debounce module
    uut: debounce
        Port map (
            clk => clk,
            reset => reset,
            button => button,
            debounce_time => debounce_time,
            debounced_button => debounced_button
        );

    -- Clock generation process
    clk_process: process
    begin
        while True loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Test stimulus process
    stim_proc: process
    begin
        -- Initialize reset
        reset <= '1';
        wait for 20 ns;  -- Apply reset
        reset <= '0';

        -- Test case 1: Single stable press after debounce time
        wait for 50 ns;  -- Initial waiting period
        button <= '1';  -- Press the button
        wait for 20 ms;  -- Wait for stable period longer than debounce time (simulate stable press)
        button <= '0';  -- Release the button
        wait for 13 ms;

        -- Test case 2: Button bouncing before debounce time
        button <= '1';  -- Press the button
        wait for 1 ms;  -- Simulate a bounce
        button <= '0';
        wait for 1 ms;
        button <= '1';
        wait for 1 ms;
        button <= '0';  -- Release the button
        wait for 20 ms;

        -- Test case 3: Long press
        button <= '1';  -- Press the button
        wait for 30 ms;  -- Hold the button for a long time
        button <= '0';  -- Release the button
        wait for 20 ms;

        -- End simulation
        wait;
    end process;

end Behavioral;
