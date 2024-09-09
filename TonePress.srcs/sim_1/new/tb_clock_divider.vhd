----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2024 02:17:27 PM
-- Design Name: 
-- Module Name: tb_clock_divider - Behavioral
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

entity tb_clock_divider is
end tb_clock_divider;

architecture Behavioral of tb_clock_divider is

    -- Signals for the DUT inputs and outputs
    signal clk_tb      : std_logic := '0';
    signal reset_tb    : std_logic := '0';
    signal tone_freq_tb: unsigned(31 downto 0) := (others => '0');
    signal clk_out_tb  : std_logic;

    -- Clock period (10 ns for 100 MHz clock)
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.clock_divider
        port map (
            clk       => clk_tb,
            reset     => reset_tb,
            tone_freq => tone_freq_tb,
            clk_out   => clk_out_tb
        );

    -- Clock generation process (100 MHz)
    clk_process : process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD / 2;
        clk_tb <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Test bench stimulus
    stim_proc: process
    begin
        -- Scenario 1: Apply reset
        reset_tb <= '1';
        wait for 50 ns;
        reset_tb <= '0';  
        wait for 50 ns;

        -- Scenario 2: Set a tone frequency and observe the divided clock
        tone_freq_tb <= to_unsigned(50, 32);  -- Example frequency division value
        wait for 200 ns;

        -- Scenario 3: Change the frequency
        tone_freq_tb <= to_unsigned(100, 32);
        wait for 200 ns;

        -- Scenario 4: Change the frequency again
        tone_freq_tb <= to_unsigned(200, 32);
        wait for 200 ns;

        -- Scenario 5: Apply reset again
        reset_tb <= '1';
        wait for 50 ns;
        reset_tb <= '0';
        wait for 50 ns;

        -- End the simulation
        wait;
    end process;

    -- Monitor process to observe clk_out_tb
    monitor_proc: process
    begin
        -- Continuously monitor the clock output and print when it changes
        wait on clk_out_tb;
        report "clk_out_tb changed to: " & std_logic'image(clk_out_tb);
    end process;

end Behavioral;

