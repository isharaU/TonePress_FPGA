# TonePress FPGA - Sound Generator

## Project Overview

This project implements a **sound generator** using an FPGA (Basys3) board. The system is controlled by button inputs on the FPGA, which trigger specific tones. The project is developed in **VHDL** and involves multiple components including debouncing for button presses, a frequency generator based on button inputs, a clock divider, and a PWM generator to produce sound on the speaker.

The **top module** (`sound_generator_top.vhd`) integrates all these components, driving a speaker with a PWM signal based on the user button inputs.

## Components

1. **Debounce Module**: Debounces the button inputs to ensure stable transitions.
2. **Button Handler Module**: Assigns a tone frequency to each button (Left, Right, Up, Down).
3. **Clock Divider Module**: Divides the main clock based on the tone frequency to generate a lower frequency clock for the PWM signal.
4. **PWM Generator Module**: Produces a PWM signal for the speaker based on the divided clock signal.
5. **Top Module**: Integrates all components and connects the debounced button inputs to the frequency generator, clock divider, and PWM generator.


## How to Run the Project

### Prerequisites

- **Vivado 2018.2** (or newer)
- A Basys3 FPGA board (for hardware testing)

### Steps to Simulate

1. Open **Vivado** and create a new project.
2. Add the VHDL source files (`debounce.vhd`, `button_handler.vhd`, `clock_divider.vhd`, `pwm_generator.vhd`, `sound_generator_top.vhd`) to the project.
3. Add the test benches located in the `testbenches/` folder.
4. Run the simulation for the top module:
   - `sound_generator_top_tb.vhd`
   - View the waveform output for the PWM signal and verify that the buttons generate the correct tone frequencies.

### Hardware Implementation

Once you verify the design via simulation, you can program the Basys3 board:
1. Generate the bitstream in Vivado.
2. Program the FPGA with the bitstream file.
3. Connect a speaker to the FPGA and press the buttons to generate different tones.

## Simulation Graphs

### Top Module Simulation Graph

Below is the waveform from the simulation of the **top module** (`sound_generator_top_tb`), showing the button presses and the corresponding PWM output to the speaker.

![Top Module Simulation Graph](https://github.com/isharaU/TonePress_FPGA/blob/add-readme/Graphs/sim.png)

### Top Module Entity Diagram

The following diagram illustrates the entity of the **top module**, showing how the components are interconnected:

![Top Module Entity Diagram](https://github.com/isharaU/TonePress_FPGA/blob/add-readme/Graphs/design.png)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any inquiries or issues, feel free to contact me via [E-mail](mailto:isharauditha5@gmail.com).

