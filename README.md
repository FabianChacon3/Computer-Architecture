# RISC-V RV32I Microarchitecture (Verilog)

![RISC-V Logo](images/logos/risc-v3-1.jpg)

**Project Goal:**
- Implement a functional RV32I RISC-V CPU in Verilog, validate it with simulation, and then synthesize and implement it on an FPGA (Vivado). Start with a single-cycle (monocycle) implementation; once stable, evolve the design into a pipelined version and extend instruction coverage beyond I-type instructions.

**What this repository covers:**
- RTL blocks in Verilog (register file, ALU, control unit, instruction and data memories, shifter, etc.).
- A byte-segmented instruction memory flow: the program is split into four `.mem` files (one byte per file) and loaded into 4 byte-wide memories to form 32-bit little-endian instruction words.
- Simulation testbenches to validate each block and full CPU behavior (`tb_instruction_memory.v`, `tb_RV32_run.v`).
- A helper script to split assembled 32-bit hex words into 4 little-endian byte `.mem` files.
- Notes and recommended steps for synthesis and implementation with Vivado, including BRAM initialization strategies.

**Repository Layout (important folders/files):**
- `constrs_1/` : board constraint files (XDC) for target FPGA boards
- `sim_1/` : simulation-only files and testbenches
  - `sim_1/new/` : expected location for `program_ram0.mem` .. `program_ram3.mem` and TBs
- `sources_1/` : Verilog RTL modules
  - `imports/Modules/` : core Verilog modules (e.g. `My_memory.v`, `Instruction_memory.v`, `regfile.v`, `RV32_loader.v`, `ALU_decoder.v`, ...)
- `utils_1/` : build/implementation helper files
- `tools/split_program.py` : Python helper to split 32-bit hex words into 4 `.mem` files (little-endian per byte)
- `images/logo/risc-v3-1.jpg` : project logo used in this README

**Quick Start — Requirements**
- Vivado (2020.x / 2021.x / 2022.x / 2024.x or later) for synthesis, implementation and `xsim` behavioral simulation.
- Python 3 for `tools/split_program.py`.
- A RISC-V toolchain or assembler able to produce 32-bit instruction hex words (e.g. `riscv64-unknown-elf-as` + `objcopy` or your preferred toolchain).

**Prepare instruction memory (.mem files)**
1. Assemble or build your program to produce a text file where each line contains a 32-bit hex word (e.g. `0x00c585b3`) or plain hex nibble pairs — see the assembler output your tool produces.
2. Use the provided splitter to generate four byte-wide `.mem` files (little-endian order):

PowerShell example:

```powershell
# from project root
python tools\split_program.py --input program_words.txt --outdir sim_1\new --prefix program_ram
# produces sim_1\new\program_ram0.mem .. program_ram3.mem