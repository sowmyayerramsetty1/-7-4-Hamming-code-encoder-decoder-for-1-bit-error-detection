<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

Introduction

The Hamming (7,4) code is a linear error-correcting code that encodes 4 bits of data into 7 bits by adding 3 parity bits. This enables detection and correction of single-bit errors during data transmission or storage.

Encoder Function

The encoder accepts 4-bit input data.

It generates 3 parity bits using XOR operations based on data bits.

These parity bits are placed at specific positions: 1, 2, and 4 (counting from LSB = bit 1).

The final 7-bit encoded word consists of both data and parity bits.

For input bits D3, D2, D1, D0, parity bits are computed as:

P1 = D3 ^ D1 ^ D0

P2 = D3 ^ D2 ^ D0

P3 = D3 ^ D2 ^ D1

Thus, the encoded word structure is:  [P3 D3 D2 P2 D1 P1 D0]

Decoder Function

The decoder receives a 7-bit word.

It recomputes parity checks and forms a 3-bit syndrome that indicates whether an error exists, and if so, the position of the error.

If the syndrome = 000, there is no error.

If the syndrome ≠ 000, it points to the bit location with the error.

The decoder flips that bit to correct the error.

It then outputs both:

Error_out → original data before correction.

Corrected_out → error-corrected 4-bit data.

## How to test
Example Truth Table
| Case | Input Data (`data_in`) | Encoded Word (`encoded_out`) | Received (`encoded_in`)     | Error Out (`error_out`) | Corrected Out (`corrected_out`) | Remark                     |
| ---- | ---------------------- | ---------------------------- | --------------------------- | ----------------------- | ------------------------------- | -------------------------- |
| 1    | `1011`                 | `1011010`                    | `1011010`                   | `1011`                  | `1011`                          | No error                   |
| 2    | `1011`                 | `1011010`                    | `1011011` *(bit-0 flipped)* | `1010`                  | `1011`                          | Single-bit error corrected |
| 3    | `1011`                 | `1011010`                    | `1011110` *(bit-2 flipped)* | `1111`                  | `1011`                          | Single-bit error corrected |


## External hardware

none
