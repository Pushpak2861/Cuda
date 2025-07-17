# Cuda
Cuda with C++

# CUDA Basics – GPU Programming Examples

This repository contains fundamental CUDA C++ programs demonstrating GPU acceleration for basic operations. Each file illustrates the use of CUDA kernels to offload computation from the CPU to the GPU.

## Files and Descriptions

| File            | Description                                                               |
|-----------------|---------------------------------------------------------------------------|
| `1Dconv.cu`     | Performs 1D convolution on an input array using constant memory for the mask. |
| `add.cu`        | Adds two vectors using CUDA parallel threads.                            |
| `mat.cu`        | Demonstrates matrix multiplication on the GPU using 2D thread blocks.     |
| `vectormat.cu`  | Multiplies a vector with a matrix using a CUDA kernel.                   |

---

## Requirements

- NVIDIA GPU with CUDA support
- CUDA Toolkit installed (e.g., via [NVIDIA CUDA Downloads](https://developer.nvidia.com/cuda-downloads))
- GCC or compatible compiler

---

## How to Compile and Run

Each `.cu` file can be compiled using `nvcc`:

```bash
nvcc -o output_executable filename.cu
./output_executable
