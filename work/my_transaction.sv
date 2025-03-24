`include "uvm_macros.svh"
import uvm_pkg::*;

//transaction

class my_transaction extends uvm_sequence_item;

    rand bit [3:0] sa; //source address
    rand bit [3:0] da; //target address
    rand reg [7:0] payload[$]; //data

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(sa, UVM_ALL_ON)
        `uvm_field_int(sa, UVM_ALL_ON)
        `uvm_field_queue_int(payload, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint limit{
        sa inside {[0:15]};
        da inside {[0:15]};
        payload.size() inside {[2:4]};
    }

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass





// sequence

class my_sequence extends uvm_sequence # (my_transaction);

    `uvm_object_utils(my_sequence)
    //`uvm_object_utils_end
    
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat(10)begin
            `uvm_do(req)
        end

        #100;
        
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

endclass



// sequencer
typedef uvm_sequencer # (my_transaction) my_sequencer;





// driver

class my_driver extends uvm_driver #(my_transaction);

    `uvm_component_utils(my_driver)

    function new(string name = "my_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("DRV_RUN_PHASE", req.sprint(), UVM_MEDIUM) //print
            #100;
            seq_item_port.item_done();        
        end
    endtask

endclass




//monitor

class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    function new(string name ="", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            `uvm_info("MON_RUN_PHASE", "Monitor run!", UVM_MEDIUM)
            #100;
        end
    endtask
endclass  



//agent

class master_agent extends uvm_agent;

    `uvm_component_utils(master_agent)

    my_sequencer m_seqr;
    my_driver m_driv;
    my_monitor m_moni;
    bit if_active = 1;    

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(is_active == UVM_ACTIVE) begin
            m_seqr = my_sequencer::type_id::create("m_seqr", this);
            m_driv = my_driver::type_id::create("m_driv", this);
        end
        m_moni = my_monitor::type_id::create("m_moni", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if (if_active == UVM_ACTIVE)
            m_driv.seq_item_port.connect(m_seqr.seq_item_export);
    endfunction


endclass




//env

class my_env extends uvm_env;

    `uvm_component_utils(my_env)

    master_agent m_agent;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);
        m_agent = master_agent::type_id::create("m_agent", this);

    endfunction

endclass






//testcase

class my_test extends uvm_test;
    
    `uvm_component_utils(my_test)

    my_env m_env;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_env = my_env::type_id::create("m_env", this);

        uvm_config_db # (uvm_object_wrapper)::set(this, "*.m_seqr.run_phase", "default_sequence", my_sequence::get_type());

    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology(uvm_default_tree_printer); //print
    endfunction

endclass











