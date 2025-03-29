class dff_driver extends uvm_driver#(dff_sequence_item);
  
    `uvm_component_utils(dff_driver)
    
    virtual dff_interface vif;
    
    dff_sequence_item txn;
    
    function new(string name = "dff_driver", uvm_component parent);
      super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual dff_interface)::get(this,"","vif",vif)) begin
        `uvm_info("DRIVER", "Unable to get virtual interface",UVM_MEDIUM);
      end
    endfunction: build_phase  
    
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      txn = dff_sequence_item::type_id::create("txn");
      forever @(posedge vif.clk)begin
        seq_item_port.get_next_item(txn);
        drive(txn);						
        seq_item_port.item_done();		
      end
    endtask
    
    task drive(dff_sequence_item txn);
      vif.din = txn.din;
      vif.rst = txn.rst;
    endtask
    
  endclass: dff_driver