----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2024 11:18:58 AM
-- Design Name: 
-- Module Name: tb_sound_generator_top - Behavioral
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

entity tb_sound_generator_top is
    -- Testbench does not have ports
end tb_sound_generator_top;

architecture Behavioral of tb_sound_generator_top is

    -- Component Declaration
    component sound_generator_top
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

    -- Testbench signals
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal btnL      : std_logic := '0';
    signal btnR      : std_logic := '0';
    signal btnU      : std_logic := '0';
    signal btnD      : std_logic := '0';
    signal speaker   : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: sound_generator_top
        Port map (
            clk       => clk,
            reset     => reset,
            btnL      => btnL,
            btnR      => btnR,
            btnU      => btnU,
            btnD      => btnD,
            speaker   => speaker
        );

    -- Clock generation process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process covering all scenarios
    stim_proc: process
    begin
        -- **Scenario 1: Initial Reset**
        -- Assert reset to initialize the system
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 100 ns;
        
        -- **Scenario 2: Press Button Left (btnL)**
        -- Expectation: Generate A4 (440 Hz)
        btnL <= '1'; btnR <= '0'; btnU <= '0'; btnD <= '0';
        wait for 100 ns;
        btnL <= '0';
        wait for 20 ns;
        
        -- **Scenario 3: Press Button Right (btnR)**
        -- Expectation: Generate B4 (493.88 Hz)
        btnL <= '0'; btnR <= '1'; btnU <= '0'; btnD <= '0';
        wait for 100 ns;
        btnR <= '0';
        wait for 20 ns;
        
        -- **Scenario 4: Press Button Up (btnU)**
        -- Expectation: Generate C5 (523.25 Hz)
        btnL <= '0'; btnR <= '0'; btnU <= '1'; btnD <= '0';
        wait for 100 ns;
        btnU <= '0';
        wait for 20 ns;
        
        -- **Scenario 5: Press Button Down (btnD)**
        -- Expectation: Generate D5 (587.33 Hz)
        btnL <= '0'; btnR <= '0'; btnU <= '0'; btnD <= '1';
        wait for 100 ns;
        btnD <= '0';
        wait for 20 ns;
        
        -- **Scenario 6: Press Multiple Buttons Simultaneously**
        -- Example: Press btnL and btnU together
        -- Depending on your design, this might prioritize one button or handle multiple tones
        btnL <= '1'; btnR <= '0'; btnU <= '1'; btnD <= '0';
        wait for 100 ns;
        btnL <= '0'; btnU <= '0';
        wait for 20 ns;
        
        -- **Scenario 7: Rapid Button Presses (Debouncing Check)**
        -- Simulate bouncing by rapidly toggling a button
        -- Only the stable press after debouncing should be recognized
        btnR <= '1';
        wait for 5 ns;
        btnR <= '0';
        wait for 5 ns;
        btnR <= '1';
        wait for 5 ns;
        btnR <= '0';
        wait for 15 ns;  
        btnR <= '1';
        wait for 100 ns;
        btnR <= '0';
        wait for 20 ns;
        
        -- **Scenario 8: No Button Pressed**
        -- Expectation: Default behavior (e.g., A4 tone or silence)
        btnL <= '0'; btnR <= '0'; btnU <= '0'; btnD <= '0';
        wait for 100 ns;
        
        -- **Scenario 9: Extended Operation**
        -- Keep buttons pressed for extended periods to observe stability
        btnU <= '1';
        wait for 500 ns;
        btnU <= '0';
        wait for 20 ns;
        
        -- **End of Simulation**
        wait;
    end process;

end Behavioral;

