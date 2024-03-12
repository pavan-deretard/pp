`timescale 1ns/1ns
module program_counter(clk,inc,rst,jmp,jmp_add,add);

input wire clk,inc,rst,jmp;
input wire[7:0] jmp_add;
output reg[7:0] add;

always @(posedge clk, posedge rst) begin
	if(rst) begin
		#1;
		add=8'h00;
	end
	else if(clk) begin
		if(jmp) begin
			#1;
			add=jmp_add;
		end
		
		else begin
			if(inc) begin
				#1
				add=add+8'h04;
			end
		
			else begin
				#1
				add=add;
			end
		end
		
	end
	else begin
		add=add;
	end
	
end
endmodule

module pc_tb();
reg clk,inc,rst,jmp;
reg[7:0] jmp_add;
wire[7:0]add;

program_counter pc(clk,inc,rst,jmp,jmp_add,add);
always #5 clk=~clk;

initial begin
clk<=0;
rst<=1;
inc<=1'bx;
jmp<=1'bx;
jmp_add=8'hxx;
#15
rst=0;
inc=1;
jmp=0;
#205
jmp=1;
jmp_add<=8'h05;
#5
jmp<=0;
inc<=0;
#10
inc=1;
end
endmodule