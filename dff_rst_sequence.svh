class dff_rst_sequence extends uvm_sequence #(dff_sequence_item);
  
    `uvm_object_utils(dff_rst_sequence)
    
    dff_sequence_item txn;
    
    function new(string name = "dff_rst_sequence");
      super.new(name);
    endfunction
    
    task body();
      repeat(15)begin
      txn = dff_sequence_item::type_id::create("txn");
      start_item(txn);
      assert(txn.randomize());
      txn.rst = 1;
      finish_item(txn);
      end
    endtask
    
  endclass: dff_rst_sequence