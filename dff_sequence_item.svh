class dff_sequence_item extends uvm_sequence_item;
  
    `uvm_object_utils(dff_sequence_item)
    
    rand logic din;
    rand logic rst;
    logic dout;
    
    function new(string name = "dff_sequence_item");
      super.new(name);
    endfunction
    
  endclass: dff_sequence_item