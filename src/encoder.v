module encoder(
    output [6:0] encoded_out,
    input  [3:0] data_in
);
    assign encoded_out[6:4] = data_in[3:1]; 
    assign encoded_out[2]   = data_in[0];   

    assign encoded_out[0] = encoded_out[6] ^ encoded_out[4] ^ encoded_out[2]; 
    assign encoded_out[1] = encoded_out[6] ^ encoded_out[5] ^ encoded_out[2]; 
    assign encoded_out[3] = encoded_out[6] ^ encoded_out[5] ^ encoded_out[4]; 
endmodule
