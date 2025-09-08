/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// ======================================================
// TinyTapeout Top Module with Hamming (7,4) Encoder-Decoder
// ======================================================
module tt_um_sowmya_hamming_top ( 
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal signals
    wire [6:0] encoded_out;     // encoder output
    wire [3:0] corrected_out;   // decoder corrected output
    wire [3:0] error_out;       // decoder raw output
    wire [6:0] encoded_in;      // input to decoder

    // Instantiate Encoder
    encoder u_encoder (
        .encoded_out(encoded_out),
        .data_in(ui_in[3:0])    // take 4 LSBs from ui_in
    );

    // Pass encoder output directly to decoder
    assign encoded_in = encoded_out;

    // Instantiate Decoder
    decoder u_decoder (
        .corrected_out(corrected_out),
        .error_out(error_out),
        .encoded_in(encoded_in)
    );

    // Map outputs: corrected data + error data
    assign uo_out[3:0] = corrected_out; // corrected data
    assign uo_out[7:4] = error_out;     // raw (uncorrected) data

    // No use of uio_* in this design
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule

