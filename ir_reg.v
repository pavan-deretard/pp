module ir_reg(inst,clk,o_inst);
input wire clk;
input wire[31:0] inst;
output reg[31:0] o_inst;
always @(inst) begin
	if(clk) begin
		#1;
		o_inst<=inst;
	end
	else begin
	o_inst=o_inst;
	end
end
endmodule



module tb_ir();
reg clk;
reg[31:0] inst;
wire[31:0] o_inst;

ir_reg i1(inst,clk,o_inst);

always #5 clk=~clk;

initial begin
clk=0;
inst=32'hxxxxxxxx;
#7
inst=32'h01020304;

end
endmodule


