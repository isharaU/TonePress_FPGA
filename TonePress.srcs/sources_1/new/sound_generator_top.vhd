----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2024 12:07:48 AM
-- Design Name: 
-- Module Name: sound_generator_top - Behavioral
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

-- Top-level entity
entity sound_generator_top is
    Port (
        clk       : in std_logic;         -- 100 MHz clock input
        reset     : in std_logic;         -- Reset signal
        btnL      : in std_logic;         -- Button Left
        btnR      : in std_logic;         -- Button Right
        btnU      : in std_logic;         -- Button Up
        btnD      : in std_logic;         -- Button Down
        speaker   : out std_logic         -- PWM signal to drive speaker
    );
end sound_generator_top;

architecture Behavioral of sound_generator_top is

    -- Signals to connect components
    signal tone_freq         : unsigned(31 downto 0);  -- Frequency signal from button handler to clock divider
    signal debounced_btnL    : std_logic;
    signal debounced_btnR    : std_logic;
    signal debounced_btnU    : std_logic;
    signal debounced_btnD    : std_logic;
    signal clk_div_out       : std_logic;  -- Clock output from clock divider
    signal pwm_out_signal    : std_logic;  -- PWM output from PWM generator

    -- Component declarations
    component debounce
        Port (
            clk             : in std_logic;
            reset           : in std_logic;
            button          : in std_logic;
            debounced_button: out std_logic
        );
    end component;

    component button_handler
        Port (
            btnL      : in std_logic;
            btnR      : in std_logic;
            btnU      : in std_logic;
            btnD      : in std_logic;
            tone_freq : out unsigned(31 downto 0)
        );
    end component;

    component clock_divider
        Port (
            clk       : in std_logic;
            reset     : in std_logic;
            tone_freq : in unsigned(31 downto 0);
            clk_out   : out std_logic
        );
    end component;

    component pwm_generator
        Port (
            clk_in   : in std_logic;
            reset    : in std_logic;
            pwm_out  : out std_logic
        );
    end component;

begin

    -- Instantiate debounce logic for each button
    debounce_L: debounce port map(clk => clk, reset => reset, button => btnL, debounced_button => debounced_btnL);
    debounce_R: debounce port map(clk => clk, reset => reset, button => btnR, debounced_button => debounced_btnR);
    debounce_U: debounce port map(clk => clk, reset => reset, button => btnU, debounced_button => debounced_btnU);
    debounce_D: debounce port map(clk => clk, reset => reset, button => btnD, debounced_button => debounced_btnD);

    -- Instantiate the button handler to determine tone frequency based on button presses
    button_handler_inst: button_handler port map(
        btnL => debounced_btnL,
        btnR => debounced_btnR,
        btnU => debounced_btnU,
        btnD => debounced_btnD,
        tone_freq => tone_freq
    );

    -- Instantiate clock divider to generate a clock for the PWM signal
    clock_divider_inst: clock_divider port map(
        clk      => clk,
        reset    => reset,
        tone_freq => tone_freq,
        clk_out  => clk_div_out
    );

    -- Instantiate PWM generator
    pwm_generator_inst: pwm_generator port map(
        clk_in  => clk_div_out,
        reset   => reset,
        pwm_out => pwm_out_signal
    );

    -- Connect the PWM signal to the speaker output
    speaker <= pwm_out_signal;

end Behavioral;


