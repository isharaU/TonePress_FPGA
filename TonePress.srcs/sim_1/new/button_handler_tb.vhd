----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024 04:09:48 PM
-- Design Name: 
-- Module Name: button_handler_tb - Behavioral
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
entity button_handler_tb is
end button_handler_tb;

architecture Behavioral of button_handler_tb is
    -- Signals to connect to the button_handler entity
    signal btnL      : std_logic := '0';
    signal btnR      : std_logic := '0';
    signal btnU      : std_logic := '0';
    signal btnD      : std_logic := '0';
    signal tone_freq : unsigned(31 downto 0);

    -- Instantiate the button_handler unit under test (UUT)
    component button_handler is
        Port (
            btnL      : in std_logic;
            btnR      : in std_logic;
            btnU      : in std_logic;
            btnD      : in std_logic;
            tone_freq : out unsigned(31 downto 0)
        );
    end component;

begin
    -- Instantiate the button_handler
    uut: button_handler
        Port map (
            btnL => btnL,
            btnR => btnR,
            btnU => btnU,
            btnD => btnD,
            tone_freq => tone_freq
        );

    -- Test process to simulate button presses
    process
    begin
        -- Test case: No button pressed, default frequency (A4, 440 Hz)
        btnL <= '0';
        btnR <= '0';
        btnU <= '0';
        btnD <= '0';
        wait for 10 ns;  -- Wait to observe default state

        -- Test case: Left button (A4, 440 Hz)
        btnL <= '1';
        wait for 10 ns;
        btnL <= '0';  -- Reset the button

        -- Test case: Right button (B4, 493.88 Hz)
        btnR <= '1';
        wait for 10 ns;
        btnR <= '0';

        -- Test case: Up button (C5, 523.25 Hz)
        btnU <= '1';
        wait for 10 ns;
        btnU <= '0';

        -- Test case: Down button (D5, 587.33 Hz)
        btnD <= '1';
        wait for 10 ns;
        btnD <= '0';

        -- End simulation
        wait;
    end process;

end Behavioral;
