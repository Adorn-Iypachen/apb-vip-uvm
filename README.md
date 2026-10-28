# APB Slave Verification using UVM

A UVM-based verification environment for an AMBA APB slave design, written in SystemVerilog.

## Description
This project verifies an APB slave DUT using a UVM testbench with master and slave agents, monitors, a scoreboard, and protocol assertions.

## Repository Structure
```
├── APB_Slave_DUT/
│   └── design.sv        # APB slave design
└── UVM_TB/
    ├── testbench.sv     # Top module
    ├── apb_pkg.sv       # Package
    ├── apb_config.sv    # Configuration class
    ├── apb_trans.sv     # Transaction (sequence item)
    ├── apb_seq.sv       # Sequence
    ├── apb_seqr.sv      # Sequencer
    ├── apb_drv.sv       # Driver
    ├── m_agent.sv       # Master agent
    ├── s_agent.sv       # Slave agent
    ├── apb_m_mon.sv     # Master monitor
    ├── apb_s_mon.sv     # Slave monitor
    ├── apb_sb.sv        # Scoreboard
    ├── apb_env.sv       # Environment
    ├── apb_test.sv      # Test
    └── prop_mod.sv      # Assertions / properties
```
