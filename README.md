# Asynchronous-FIFO-Design-using-Verilog-HDL

## Overview
This project implements an **Asynchronous FIFO (First-In-First-Out) Buffer** using Verilog HDL. The design supports separate read and write clocks, making it suitable for asynchronous data transfer applications.

## Features
- **Fully Asynchronous Operation**: Separate Read and Write clocks.
- **Configurable Depth & Data Width**: Currently set to 4 locations, each 8-bit wide.
- **Flags for Empty and Full Conditions**: Indicates when FIFO is full or empty.
- **Synchronous Reset (`Clr_bar`)**: Clears the FIFO contents.

## Design Parameters
- `fifo_depth = 4`: Defines the number of storage locations.
- `data_width = 8`: Specifies the bit width of each FIFO entry.

## Ports Description
| Port | Direction | Description |
|------|----------|-------------|
| `Clr_bar` | Input | Active-low clear/reset signal |
| `Write_clk` | Input | Clock signal for writing data |
| `Read_clk` | Input | Clock signal for reading data |
| `data_in` | Input (8-bit) | Input data to be written into FIFO |
| `data_out` | Output (8-bit) | Data output from FIFO |
| `Empty` | Output | Flag indicating FIFO is empty |
| `Full` | Output | Flag indicating FIFO is full |

## Functional Description
### Reset Logic
- When `Clr_bar` is LOW (`0`), the FIFO is cleared, and all registers are set to `0`.
- The `Read_ptr` and `Write_ptr` are reset to zero.

### Write Operation
- Data is written on the **falling edge** of `Write_clk` if an empty location is available.
- The `Write_ptr` is incremented after writing if space is available.

### Read Operation
- Data is read on the **falling edge** of `Read_clk`.
- The `Read_ptr` is incremented after reading if valid data exists.

### Empty & Full Flag Logic
- **Empty Flag**: Set when `Write_ptr` and `Read_ptr` are both at zero.
- **Full Flag**: Set when the FIFO reaches its maximum depth.

## Usage
1. Instantiate the module in your top-level design.
2. Provide appropriate `Write_clk` and `Read_clk` signals.
3. Monitor `Full` and `Empty` flags before performing write and read operations.

## Example Instantiation
```verilog
Async_FIFO_Design uut (
    .Clr_bar(reset),
    .Write_clk(wclk),
    .Read_clk(rclk),
    .data_in(data_in),
    .Empty(empty_flag),
    .Full(full_flag),
    .data_out(data_out)
);
```

## Issues & Improvements
- The FIFO currently does not implement **Gray code pointers**, which can help avoid metastability issues in cross-clock domains.
- Enhancements such as **parameterized depth/width** can make the design more scalable.
- Boundary conditions for `Full` and `Empty` flags need more robust handling.

## License
This project is open-source and available under the MIT License.

---
### Author
**Your Name**

For any issues or suggestions, feel free to open an issue on GitHub!
