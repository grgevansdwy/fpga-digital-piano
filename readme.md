# 🎹 FPGA Digital Piano System

This project implements a digital piano system on an FPGA using SystemVerilog. Designed for EE/CSE 371 at the University of Washington, it integrates audio output, VGA display, waveform synthesis, and a memory-based piano game. It was tested using the LabsLand DE1-SoC virtual environment.

## 🧩 Features

- **Real-time digital piano**
  - Switches SW[6:0] mapped to musical notes (C to B)
  - Audio playback via audio codec
  - Visual feedback via VGA output
- **Chord Support**
  - Polyphonic playback (multiple simultaneous notes)
  - Scaled waveform summation to prevent distortion
- **Memory-Based Piano Game**
  - Melody matching game using a finite state machine
  - Game logic with win/loss state tracking via HEX0
- **Testbench support**
  - Simulated user inputs for game validation
  - FSM tested for correct transitions and edge cases

## 🗂️ File Structure
1. piano_drawer.sv # Visual rendering of piano keys on VGA
2. chord_player.sv # Audio synthesis of multiple notes
3. piano_game.sv # FSM logic for melody memory game
4. rom_note_*.mif # ROM waveform data for each musical note
5. audio_driver.sv # Interface to audio codec
6. video_driver.sv # VGA timing and signal generation
7. testbench.sv # Piano Game testbench
8. README.md

### 🧪 Simulation

1. Open the project in ModelSim or your preferred SystemVerilog simulator.
2. Compile all modules along with `testbench.sv`.
3. Run simulation and verify:
   - Note highlighting logic
   - FSM game state transitions
   - Audio mixing (observed through waveform analysis or test logs)

### 🚀 FPGA Deployment (LabsLand DE1-SoC)

1. Upload all `.sv` files and `.mif` files to the Quartus project.
2. Compile the project and program the board through LabsLand.
3. Use switches SW[6:0] to play notes.
4. Observe:
   - VGA display for piano key visualizations
   - Audio output from the codec
   - HEX0 for piano game feedback

## 🧾 Results Summary

✅ Piano keys visually responded to switch input  
✅ Chord playback worked without distortion using scaled ROM outputs  
✅ Melody matching game correctly handled win/loss logic  
✅ Testbench confirmed FSM stability under edge cases  

🛠 Built with SystemVerilog • 🎧 Tested on LabsLand DE1-SoC





