`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:04:54 11/21/2014 
// Design Name: 
// Module Name:    sram_top 
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
module sram_top(
			input clk,
			input rst,
			input [3:0] sw,
			input write_in,
			input read_in,
			inout [3:0] sram_data,
			output ce,
			output we,
			output oe,
			output sram_clk,
			output adv,
			output cre,
			output lb,
			output ub,
			output [3:0] address_out,
			output [7:0] seg,
			output [3:0] ctl,
			output [1:0] state,
			output w_l,
			output r_l
    );
		
		reg [3:0] data_in;
		reg [3:0] address_in;
		wire [3:0] data_out;
		wire clk_100;
		wire clk_10;
		wire [15:0] in_seg;
		wire write,read;
		
		assign in_seg = {address_in,data_in,address_out,data_out};
		assign w_l = write;
		assign r_l = read;
		
		dcm top1
		(// Clock in ports
			.CLK_IN1(clk),      // IN
			// Clock out ports
			.CLK_OUT1(clk_100),     // OUT
			.CLK_OUT2(clk_10),     // OUT
			// Status and control signals
			.RESET(rst)); 
			
		sram_control top2 ( 			
			.data_in(data_in),
			.address_in(address_in), 
			.write(write), 
			.read(read), 
			.sram_data(sram_data), 
			.clk(clk_10), 
			.rst(rst), 
			.data_out(data_out), 
			.address_out(address_out), 
			.ce(ce), 
			.we(we), 
			.oe(oe), 
			.sram_clk(sram_clk), 
			.adv(adv), 
			.cre(cre), 
			.lb(lb), 
			.ub(ub),
			.state(state)
			);
			
		seven_seg_top top3 (
			.clk(clk_100), 
			.rst(rst), 
			.data_in(in_seg), 
			.seg(seg), 
			.ctl(ctl)
			);
	
		debounce top4 (
			.clk(clk_10), 
			.rst(rst), 
			.btn_in(write_in), 
			.btn_out(write)
			);
			
		debounce top5 (
			.clk(clk_10), 
			.rst(rst), 
			.btn_in(read_in), 
			.btn_out(read)
			);

	
	always@(posedge clk_100)
	begin
		if(write == 1)
		begin
			data_in <= sw;
		end
		else if(read == 1)
		begin
			address_in <= sw;
		end
	end

endmodule
