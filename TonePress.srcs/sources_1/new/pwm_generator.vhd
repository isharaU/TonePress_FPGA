----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/08/2024 11:51:49 PM
-- Design Name: 
-- Module Name: pwm_generator - Behavioral
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

entity pwm_generator is
    Port (
        clk_in   : in std_logic;         -- Divided clock input from the clock divider
        reset    : in std_logic;         -- Reset signal
        pwm_out  : out std_logic         -- PWM output (to drive speaker)
    );
end pwm_generator;

architecture Behavioral of pwm_generator is
    signal duty_cycle_counter : unsigned(7 downto 0) := (others => '0');  -- Counter for PWM duty cycle
    signal pwm_signal : std_logic := '0';  -- Internal PWM signal
    constant MAX_DUTY_CYCLE : unsigned(7 downto 0) := "10000000";  -- 50% duty cycle
begin
    -- PWM process
    process (clk_in, reset)
    begin
        if reset = '1' then
            duty_cycle_counter <= (others => '0');  -- Reset counter
            pwm_signal <= '0';  -- Reset PWM signal
        elsif rising_edge(clk_in) then
            -- Increment duty cycle counter
            duty_cycle_counter <= duty_cycle_counter + 1;
            
            -- Generate the PWM signal
            if duty_cycle_counter < MAX_DUTY_CYCLE then
                pwm_signal <= '1';  -- High phase of PWM
            else
                pwm_signal <= '0';  -- Low phase of PWM
            end if;
        end if;
    end process;
    
    -- Output the PWM signal to the speaker
    pwm_out <= pwm_signal;

end Behavioral;
