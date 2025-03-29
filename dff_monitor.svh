class dff_monitor extends uvm_monitor;
  
    `uvm_component_utils(dff_monitor)
    
    virtual dff_interface vif;
    
    dff_sequence_item txn;
    
    uvm_analysis_port#(dff_sequence_item) mon_ap;
    
    function new(string name = "dff_monitor",uvm_component parent);
      super.new(name,parent);
    endfunction
      
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      txn = dff_sequence_item::type_id::create("txn",this);
      if(!(uvm_config_db#(virtual dff_interface)::get(this,"","vif",vif))) begin
        `uvm_info("MONITOR","unable to get virtual interface",UVM_MEDIUM);
      end
      mon_ap = new("mon_ap",this);
    endfunction: build_phase
  
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever @(posedge vif.clk) begin
        txn.din = vif.din;
        txn.rst = vif.rst;
        txn.dout = vif.dout;
        mon_ap.write(txn);
      end
    endtask
    
  endclass: dff_monitor 