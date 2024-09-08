----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2024 12:19:16 AM
-- Design Name: 
-- Module Name: sound_generator_top_TB - Behavioral
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

    -- Clock process
    clk_process: process
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
        wait for 20 ns;
        reset <= '0';

        -- Test different button presses
        -- Press Button Left (btnL)
        btnL <= '1'; btnR <= '0'; btnU <= '0'; btnD <= '0';
        wait for 100 ms;
        btnL <= '0';

        -- Press Button Right (btnR)
        btnL <= '0'; btnR <= '1'; btnU <= '0'; btnD <= '0';
        wait for 100 ms;
        btnR <= '0';

        -- Press Button Up (btnU)
        btnL <= '0'; btnR <= '0'; btnU <= '1'; btnD <= '0';
        wait for 100 ms;
        btnU <= '0';

        -- Press Button Down (btnD)
        btnL <= '0'; btnR <= '0'; btnU <= '0'; btnD <= '1';
        wait for 100 ms;
        btnD <= '0';

        -- Test with no button pressed
        btnL <= '0'; btnR <= '0'; btnU <= '0'; btnD <= '0';
        wait for 100 ms;

        -- End simulation
        wait;
    end process;

end Behavioral;

