interface apb_if(input bit Pclk);
  
  bit Presetn;
  logic Penable;
  logic Pwrite;
  logic Psel;
  logic [31:0] Pwdata;
  logic [31:0]Paddr;
  bit Pready;
  logic [31:0] Prdata;
  
  clocking drv_cb@(posedge Pclk);
    default input #1 output #1;
    
    input Pready;
    input Prdata;
    output Presetn;
    output Paddr;
    output Penable;
    output Psel;
    output Pwrite;
    output Pwdata;
  endclocking
  
  clocking imon_cb@(posedge Pclk);
    
    default input #1 output #1;
    input Pready;
    input Prdata;
    input Presetn;
    input Penable;
    input Paddr;
    input Psel;
    input Pwrite;
    input Pwdata;
  endclocking
  
  clocking omon_cb@(posedge Pclk);
    default input #1 output #1;
    input Pwrite;
    input Paddr;
    input Psel;
    input Penable;
    input Pwdata;
	input Pready;
    input Prdata;
  endclocking
  
  modport DR_MP(clocking drv_cb);
  modport IMON_MP(clocking imon_cb);
  modport OMON_MP(clocking omon_cb);
   
endinterface
    
//DUT
 // Code your design here
module apb_slave(Pclk,Presetn,Paddr,Pwrite,Pwdata,Penable,Psel,Prdata,Pready);
  input Pclk;
  input Presetn;
  input Penable;
  input Psel;
  input Pwrite;
  input [31:0]Paddr;
  input [31:0]Pwdata;
  
  output reg [31:0]Prdata;
  output reg Pready;
  
  parameter [1:0] IDLE=2'b00,
  				  SETUP=2'b01,
  				  ACCESS=2'b10;
  				 
  
  reg[1:0] ps,ns;
  reg[31:0] mem[31:0];
  integer i;
  
  always@(posedge Pclk) begin
    if(!Presetn)begin
      ps<=IDLE;
    end
    else begin
      ps<=ns;
    end
  end
  
  always@(*) begin
    ns = ps;
    case(ps)
      IDLE: begin
        if(Psel)
          begin
            ns=SETUP;
          end
        else
          begin
            ns=IDLE;
          end
      end
      
      SETUP: begin
        if(Penable)
          begin
            ns=ACCESS;
          end
      else
        begin
          ns=SETUP;
        end
      end
      
      
      ACCESS:begin
        if(Pready)
          begin
            if(!Psel)
            ns=IDLE;
            else ns = SETUP;
          end              
          else ns = ACCESS;
      end 

      default: ns = IDLE;
    endcase
  end
  
  always @(posedge Pclk) begin

    if(!Presetn) begin

        Pready <= 0;
        Prdata <= 0;

        for(i=0;i<32;i=i+1)
            mem[i] <= 0;

    end
    else begin
    case(ps)                      
                IDLE: begin
                    Pready <= 0;
                end
                SETUP: begin
                    Pready <= 0;          
                end
                ACCESS: begin
                  Pready <= 1;
               
                        if(Pwrite)
                          mem[Paddr] <= Pwdata;   
                        else
                            Prdata <= mem[Paddr];        
                    
                end
            endcase
        end
    end
endmodule   