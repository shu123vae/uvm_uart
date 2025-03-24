
program automatic test;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "my_transaction.sv"

    initial begin
        run_test("my_test");
    end

endprogram


