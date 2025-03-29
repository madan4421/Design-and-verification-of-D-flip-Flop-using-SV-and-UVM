class dff_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(dff_scoreboard)
  
    uvm_analysis_imp#(dff_sequence_item,dff_scoreboard)sb_port;
    
    function new(string name = "dff_scoreboard", uvm_component parent);
      super.new(name,parent);
    endfunction
  
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);    
      sb_port = new("sb_port",this);
    endfunction: build_phase
  
    function void write(dff_sequence_item txn);
          if(txn.rst == 1)begin
            if(txn.dout == 0)begin
              `uvm_info("SCOREBOARD",$sformatf("Test case passed, t = %0t ", $time),UVM_MEDIUM);
            end
            else begin
              `uvm_info("SCOREBOARD",$sformatf("Test case failed: din = %0b, dout = %0b, rst = %0b , t= %0d",txn.din,txn.dout,txn.rst,$time),UVM_MEDIUM);
            end
          end
  
          else begin
            if(txn.din == txn.dout) begin
              `uvm_info("SCOREBOARD",$sformatf("Test case passed at t=%0t",$time),UVM_MEDIUM);
            end
            else begin
              `uvm_info("SCOREBOARD",$sformatf("Test case failed t=%0t",$time),UVM_MEDIUM);
            end
          end
    endfunction: write 
    
  endclass: dff_scoreboard