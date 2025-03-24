
# ??????
vlog -sv src/add_if.sv
vlog -sv src/add_dut.sv
vlog -sv src/my_transaction.sv
vlog -sv src/my_sequence.sv
vlog -sv src/my_driver.sv
vlog -sv src/my_monitor.sv
vlog -sv src/my_agent.sv
vlog -sv src/my_scoreboard.sv
vlog -sv src/my_env.sv
vlog -sv src/my_test.sv
vlog -sv src/my_top.sv

# ????
vsim -voptargs=+acc my_top

# ????
add wave *
add wave /tb_top/dut/*

# ????
run -all

# ??
# quit -sim