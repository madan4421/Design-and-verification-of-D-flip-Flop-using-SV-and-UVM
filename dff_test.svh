class dff_test extends uvm_test;
  
    `uvm_component_utils(dff_test)
    
    dff_environment environment_h;
    dff_sequence sequence_h;
    dff_rst_sequence rst_sequence_h;
    dff_rand_rst_sequence rand_rst_sequence_h;
  
    virtual dff_interface vif;
  
    function new(string name = "dff_test",uvm_component parent);
      super.new(name,parent);
    endfunction
  
    function void build_phase(uvm_phase phase);
      environment_h = dff_environment::type_id::create("environment_h",this);
      if(!(uvm_config_db#(virtual dff_interface)::get(this,"","vif",vif)))begin
         `uvm_info("test","unable to get vif from tb",UVM_NONE);
      end
      uvm_config_db#(virtual dff_interface)::set(this,"environment_h.agent_h.driver_h","vif",vif);
      uvm_config_db#(virtual dff_interface)::set(this,"environment_h.agent_h.monitor_h","vif",vif);
    endfunction: build_phase
  
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      sequence_h = dff_sequence::type_id::create("dff_sequence",this);
      rst_sequence_h = dff_rst_sequence::type_id::create("dff_rst_sequence",this);
      rand_rst_sequence_h = dff_rand_rst_sequence::type_id::create("dff_rand_rst_sequence",this);
  
      phase.raise_objection(this);
      rst_sequence_h.start(environment_h.agent_h.sequencer_h);
      sequence_h.start(environment_h.agent_h.sequencer_h);
      rand_rst_sequence_h.start(environment_h.agent_h.sequencer_h);
      phase.drop_objection(this);
    endtask
    
  endclass: dff_test
