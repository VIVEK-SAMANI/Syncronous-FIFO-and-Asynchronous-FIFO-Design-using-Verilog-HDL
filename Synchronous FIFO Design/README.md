# Synchronous-FIFO-Design-using-Verilog-HDL

## 📌 Overview

This project implements a **parameterized synchronous FIFO** in Verilog HDL.
It’s a simple yet effective memory buffer design where data is written and read in a **first-in, first-out** manner — the oldest data written is the first to be read.

The FIFO is **synchronous**, meaning both read and write operations are driven by the **same clock signal**. This makes it ideal for single-clock domain data buffering applications.

---

## ⚙ Features

* **Fully parameterized**:

  * `Depth` → Number of storage locations (default: `8`)
  * `Data_Width` → Bit-width of each data word (default: `8`)
* **Full & Empty flags** for flow control
* **Synchronous read & write**
* **Configurable for various sizes** without changing core logic

---

## 🏗 Architecture

The FIFO consists of:

* **Memory array** → Stores the data entries
* **Write Pointer (`w_ptr`)** → Tracks where to write the next data word
* **Read Pointer (`r_ptr`)** → Tracks where to read the next data word
* **Control Logic** → Detects `full` and `empty` conditions

**Operation Flow:**

1. **Write**: If `w_en` is high and FIFO is not full, incoming data (`data_in`) is stored at the current write pointer location, and the write pointer is incremented.
2. **Read**: If `r_en` is high and FIFO is not empty, data at the current read pointer is output to `data_out`, and the read pointer is incremented.
3. **Full Condition**: Occurs when incrementing `w_ptr` would make it equal to `r_ptr`.
4. **Empty Condition**: Occurs when `w_ptr` equals `r_ptr`.

---

## 🖥 Ports Description

| Signal     | Direction | Width            | Description                  |
| ---------- | --------- | ---------------- | ---------------------------- |
| `clk`      | Input     | 1 bit            | Clock signal                 |
| `rst_n`    | Input     | 1 bit            | Active-low reset             |
| `w_en`     | Input     | 1 bit            | Write enable                 |
| `r_en`     | Input     | 1 bit            | Read enable                  |
| `data_in`  | Input     | Data\_Width bits | Data to be written into FIFO |
| `data_out` | Output    | Data\_Width bits | Data read from FIFO          |
| `full`     | Output    | 1 bit            | Indicates FIFO is full       |
| `empty`    | Output    | 1 bit            | Indicates FIFO is empty      |

---

## 🔄 Reset Behavior

On **active-low reset**:

* Write pointer (`w_ptr`) = `0`
* Read pointer (`r_ptr`) = `0`
* Output data (`data_out`) = `0`

---

## 📜 Example Usage

```verilog
// Instantiate an 8-depth FIFO with 8-bit data width
synchronous_fifo #(.Depth(8), .Data_Width(8)) fifo_inst (
  .clk(clk),
  .rst_n(rst_n),
  .w_en(write_enable),
  .r_en(read_enable),
  .data_in(input_data),
  .data_out(output_data),
  .full(full_flag),
  .empty(empty_flag)
);
```

---

## 🧠 Applications

* Data buffering between producer-consumer modules
* Rate adaptation between two processes running at the same clock
* Temporary storage in digital communication systems
* Simple queue management in embedded systems

---

## 🛠 Tools Used

* **HDL**: Verilog
* **Simulation**: Xilinx Vivado 
* **Synthesis**: Xilinx Vivado
