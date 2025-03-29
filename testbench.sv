`include "uvm_macros.svh"
import uvm_pkg::*;

`include "dff_interface.sv"
`include"dff_sequence_item.svh"
`include"dff_rst_sequence.svh"
`include"dff_sequence.svh"
`include"dff_rand_rst_sequence.svh"
`include"dff_sequencer.svh"
`include"dff_monitor.svh"
`include"dff_driver.svh"
`include"dff_agent.svh"
`include"dff_scoreboard.svh"
`include"dff_environment.svh"
`include"dff_test.svh"


module dff_tb_top();
  
  dff_interface vif();
  
  dff dut(.clk(vif.clk),.rst(vif.rst),.din(vif.din),.dout(vif.dout));

  initial begin
    vif.clk = 1;
    vif.din = 0;
    vif.rst = 1;
  end
  
  always #2 vif.clk = ~vif.clk; 
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,dff_tb_top);
  end

  initial begin
    uvm_config_db#(virtual dff_interface)::set(null,"uvm_test_top","vif",vif);
  end

  initial begin
    run_test("dff_test");
  end

  
endmodule