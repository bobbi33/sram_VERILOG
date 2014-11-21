`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:06 11/21/2014 
// Design Name: 
// Module Name:    seven_seg_decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seven_seg_decoder(
		input [3:0] data_in,
		output [7:0] data_out
    );
	 
	 assign data_out = (data_in == 4'b0000) ? 8'b00000011 : 
							 (data_in == 4'b0001) ? 8'b10011111 :
							 (data_in == 4'b0010) ? 8'b00100101 :
							 (data_in == 4'b0011) ? 8'b00001101 :
							 (data_in == 4'b0100) ? 8'b10011001 :
							 (data_in == 4'b0101) ? 8'b01001001 :
							 (data_in == 4'b0110) ? 8'b01000001 :
							 (data_in == 4'b0111) ? 8'b00011111 :
							 (data_in == 4'b1000) ? 8'b00000001 :
							 (data_in == 4'b1001) ? 8'b00011001 :
							 (data_in == 4'b1010) ? 8'b00010001 :
							 (data_in == 4'b1011) ? 8'b11000001 :
							 (data_in == 4'b1100) ? 8'b01100011 :
							 (data_in == 4'b1101) ? 8'b10000101 :
							 (data_in == 4'b1110) ? 8'b01100001 :
							  8'b01110001;


endmodule
