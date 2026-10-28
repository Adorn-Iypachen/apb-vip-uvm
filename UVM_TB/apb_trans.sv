class apb_trans extends uvm_sequence_item;
  
  `uvm_object_utils(apb_trans)
  
  rand logic Penable;
  rand logic Psel;
  rand logic Pwrite;
  rand bit [31:0]Paddr;
  rand logic [31:0]Pwdata;
  logic [31:0] Prdata;
  
//  constraint address{Paddr<16;}
  constraint data{Pwdata inside{[1:100]};}s
  
  function new(string name="apb_trans");
    super.new(name);
  endfunction
  
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    
    printer.print_field("Penable",this.Penable,1,UVM_DEC);
    printer.print_field("Psel",this.Psel,1,UVM_DEC);
    printer.print_field("Pwrite",this.Pwrite,1,UVM_DEC);
    printer.print_field("Paddr",this.Paddr,32,UVM_DEC);
    printer.print_field("Pwdata",this.Pwdata,32,UVM_DEC);
    
    printer.print_field("Prdata",this.Prdata,32,UVM_DEC);
  endfunction
endclass
