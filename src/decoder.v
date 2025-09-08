module decoder(
    output reg [3:0] corrected_out,
    output reg [3:0] error_out,
    input  [6:0] encoded_in
);
    wire [2:0] error_pos;

  
    assign error_pos[0] = encoded_in[0] ^ encoded_in[6] ^ encoded_in[4] ^ encoded_in[2];
    assign error_pos[1] = encoded_in[1] ^ encoded_in[6] ^ encoded_in[5] ^ encoded_in[2];
    assign error_pos[2] = encoded_in[3] ^ encoded_in[6] ^ encoded_in[5] ^ encoded_in[4];

    always @(*) begin

        error_out = {encoded_in[6:4], encoded_in[2]};
        corrected_out = error_out;

        case (error_pos)
            3'b011: corrected_out = {encoded_in[6:4], ~encoded_in[2]};
            3'b101: corrected_out = {encoded_in[6:5], ~encoded_in[4], encoded_in[2]};
            3'b110: corrected_out = {encoded_in[6], ~encoded_in[5], encoded_in[4], encoded_in[2]};
            3'b111: corrected_out = {~encoded_in[6], encoded_in[5:4], encoded_in[2]};
        endcase
    end
endmodule
