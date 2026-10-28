
import uvm_pkg::*;
`include "uvm_macros.svh"


`include "apb_trans.sv"
`include "apb_config.sv"
`include "apb_drv.sv"
`include "apb_m_mon.sv"
`include "apb_seqr.sv"
`include "m_agent.sv"

`include "apb_s_mon.sv"
`include "s_agent.sv"
`include "apb_sb.sv"
`include "apb_env.sv"
`include "apb_seq.sv"

`include "prop_mod.sv"
`include "apb_test.sv"
 
//`include "apb_pkg.sv"

 
module top();
//import apb_pkg::*;
  bit Pclk;
  
  initial begin
    Pclk=1'b0;
    forever #10 Pclk=~Pclk;
  end
  
apb_if in(Pclk);
  
  apb_slave DUV(in.Pclk,in.Presetn,in.Paddr,in.Pwrite,in.Pwdata,in.Penable,in.Psel,in.Prdata,in.Pready);
  
  bind apb_slave prop_mod p1(top.in);
  
initial begin
  uvm_config_db #(virtual apb_if)::set(null,"*","vif",in);
  
 run_test("single_test");
 // run_test("multiple_test");
 // run_test("continuous_test");
  //run_test("back2back_test");
end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,top);
  end
endmodule
  
  