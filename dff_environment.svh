class dff_environment extends uvm_env;

    `uvm_component_utils(dff_environment)
    
    virtual dff_interface vif;
  
    dff_agent agent_h;
    dff_scoreboard scoreboard_h;
    
    function new(string name = "dff_environment", uvm_component parent);
      super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent_h = dff_agent::type_id::create("agent_h",this);
      scoreboard_h = dff_scoreboard::type_id::create("scoreboard",this);    
    endfunction: build_phase
    
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agent_h.monitor_h.mon_ap.connect(scoreboard_h.sb_port);	
    endfunction: connect_phase
   
  endclass: dff_environment