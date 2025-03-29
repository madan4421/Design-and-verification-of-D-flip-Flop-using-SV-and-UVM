class dff_sequence extends uvm_sequence#(dff_sequence_item);
  
    `uvm_object_utils(dff_sequence)
    
    dff_sequence_item txn;
  
    function new(string name = "dff_sequence");
      super.new(name);
    endfunction
    
    task body();
      repeat (50) begin 
        txn = dff_sequence_item::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize());
        txn.rst = 0;
        finish_item(txn);
       end
    endtask
   
  endclass: dff_sequence