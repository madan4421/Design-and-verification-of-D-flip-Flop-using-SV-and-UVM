module dff(
    input clk,
    input rst,
    input din,
    output reg dout);
    
    always @(posedge clk) begin
      if(rst) begin
        assign dout = 1'b0;
      end
      
      else begin
        assign dout = din;
      end
    end
  endmodule