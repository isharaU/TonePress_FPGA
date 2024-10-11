----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2024 12:01:25 AM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Port (
        clk     : in std_logic;         -- 100 MHz clock input
        reset   : in std_logic;         -- Reset signal
        button  : in std_logic;         -- Raw button input (bouncing)
        debounce_time : in unsigned(19 downto 0);  -- Configurable debounce time
        debounced_button : out std_logic -- Debounced button output
    );
end debounce;

architecture Behavioral of debounce is
    signal counter         : unsigned(19 downto 0) := (others => '0');  -- Counter for debounce time
    signal button_stable   : std_logic := '0';  -- Button stable state
    signal button_last     : std_logic := '0';  -- Last state of the button
begin

    process (clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');  -- Reset counter
            button_stable <= '0';  -- Reset stable button state
            button_last <= '0';  -- Reset last button state
        elsif rising_edge(clk) then
            -- Check if button state changed
            if button = button_last then
                -- Button state hasn't changed, count up to debounce time
                if counter < debounce_time then
                    counter <= counter + 1;
                else
                    button_stable <= button_last;  -- Set stable state if button holds the same state for debounce_time
                end if;
            else
                -- Button state changed, reset the counter
                counter <= (others => '0');
            end if;
            
            button_last <= button;  -- Update last button state
        end if;
    end process;
    
    -- Output the stable button state
    debounced_button <= button_stable;
    
end Behavioral;


