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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sound_generator_top_tb IS
END sound_generator_top_tb;

ARCHITECTURE behavior OF sound_generator_top_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT sound_generator_top
    PORT(
        clk     : IN std_logic;
        reset   : IN std_logic;
        btnL    : IN std_logic;
        btnR    : IN std_logic;
        btnU    : IN std_logic;
        btnD    : IN std_logic;
        speaker : OUT std_logic
    );
    END COMPONENT;
    
    -- Testbench signals
    SIGNAL clk     : std_logic := '0';
    SIGNAL reset   : std_logic := '0';
    SIGNAL btnL    : std_logic := '0';
    SIGNAL btnR    : std_logic := '0';
    SIGNAL btnU    : std_logic := '0';
    SIGNAL btnD    : std_logic := '0';
    SIGNAL speaker : std_logic;
    
    -- Clock period definition
    CONSTANT PERIOD : time := 10 ns;  -- 100 MHz clock
    
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: sound_generator_top PORT MAP (
        clk     => clk,
        reset   => reset,
        btnL    => btnL,
        btnR    => btnR,
        btnU    => btnU,
        btnD    => btnD,
        speaker => speaker
    );

    -- Clock generation process
    clk_process :process
    begin
        clk <= '0';
        wait for PERIOD / 2;
        clk <= '1';
        wait for PERIOD / 2;
    end process;

    -- Stimulus process
    stimulus : process
    begin	
        -- Initial reset
        reset <= '1';   -- Assert reset
        wait for 100 ns;
        reset <= '0';   -- Deassert reset
        wait for 50 ns;
        
        -- Test button Left (btnL)
        report "Testing btnL (Left button)" severity note;
        btnL <= '1';
        wait for 100 ns;
        btnL <= '0';
        wait for 100 ns;
        
        -- Test button Right (btnR)
        report "Testing btnR (Right button)" severity note;
        btnR <= '1';
        wait for 100 ns;
        btnR <= '0';
        wait for 100 ns;
        
        -- Test button Up (btnU)
        report "Testing btnU (Up button)" severity note;
        btnU <= '1';
        wait for 100 ns;
        btnU <= '0';
        wait for 100 ns;
        
        -- Test button Down (btnD)
        report "Testing btnD (Down button)" severity note;
        btnD <= '1';
        wait for 100 ns;
        btnD <= '0';
        wait for 100 ns;

        -- Test multiple buttons simultaneously
        report "Testing btnL and btnR simultaneously" severity note;
        btnL <= '1';
        btnR <= '1';
        wait for 100 ns;
        btnL <= '0';
        btnR <= '0';
        wait for 200 ns;

        -- Test for potential button bouncing scenario
        report "Testing btnU with bounce" severity note;
        btnU <= '1';
        wait for 10 ns;
        btnU <= '0';
        wait for 10 ns;
        btnU <= '1';
        wait for 50 ns;
        btnU <= '0';
        wait for 100 ns;

    end process;

END;
