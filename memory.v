`timescale 1ns/1ns
module memory(clk,w_en,read,write,w_data,read_o);
input wire clk,w_en;
input wire[9:0] read,write;
input wire[7:0] w_data;
output reg[7:0] read_o;
reg[7:0] mem[1023:0];
always @* begin
	if(clk) begin
		#2
		read_o<=mem[read];
		if(w_en) begin
			mem[write]<=w_data;
		end
	end
	else begin
		read_o<=read_o;
	end
end
endmodule


module memory_tb();
reg clk,w_en;
reg[9:0] read,write;
reg[7:0] w_data;
wire[7:0] read_o;

memory m1(clk,w_en,read,write,w_data,read_o);
always #5 clk=~clk;
initial begin
clk=1;
w_en=1;
write=56;
read=87;
w_data=$random;
#10
write=57;
read=56;
w_data=$random;
#10
w_en=0;
write=60;
read=56;
w_data=$random;
#10
w_en=1;
write=57;
read=60;
w_data=$random;
end
endmodule
