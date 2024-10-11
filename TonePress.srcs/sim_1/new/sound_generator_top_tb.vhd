----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024
-- Design Name: sound_generator_top_tb
-- Module Name: sound_generator_top_tb
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for the top module of the sound generator
-- 
-- Dependencies: sound_generator_top
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This testbench stimulates the button inputs and verifies 
-- the PWM output.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sound_generator_top_tb is
end sound_generator_top_tb;

architecture Behavioral of sound_generator_top_tb is
    -- Component declaration
    component sound_generator_top is
        Port (
            clk       : in std_logic;
            reset     : in std_logic;
            btnL      : in std_logic;
            btnR      : in std_logic;
            btnU      : in std_logic;
            btnD      : in std_logic;
            speaker   : out std_logic
        );
    end component;
    
    -- Signals for connecting to the DUT
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal btnL     : std_logic := '0';
    signal btnR     : std_logic := '0';
    signal btnU     : std_logic := '0';
    signal btnD     : std_logic := '0';
    signal speaker  : std_logic;
    
    -- Clock period definition
    constant clk_period : time := 10 ns;  -- 100 MHz clock
    
begin
    -- Instantiate the Device Under Test (DUT)
    DUT: sound_generator_top port map (
        clk     => clk,
        reset   => reset,
        btnL    => btnL,
        btnR    => btnR,
        btnU    => btnU,
        btnD    => btnD,
        speaker => speaker
    );
    
    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize inputs
        reset <= '1';
        btnL <= '0';
        btnR <= '0';
        btnU <= '0';
        btnD <= '0';
        wait for 100 ns;
        
        -- Release reset
        reset <= '0';
        wait for 100 ns;
        
        -- Test button presses
        -- Left button
        btnL <= '1';
        wait for 1 ms;
        btnL <= '0';
        wait for 10 ms;
        
        -- Right button
        btnR <= '1';
        wait for 1 ms;
        btnR <= '0';
        wait for 10 ms;
        
        -- Up button
        btnU <= '1';
        wait for 1 ms;
        btnU <= '0';
        wait for 10 ms;
        
        -- Down button
        btnD <= '1';
        wait for 1 ms;
        btnD <= '0';
        wait for 10 ms;
        
        -- Test multiple button presses
        btnL <= '1';
        btnU <= '1';
        wait for 1 ms;
        btnL <= '0';
        btnU <= '0';
        wait for 10 ms;
        
        -- End simulation
        wait;
    end process;

end Behavioral;
