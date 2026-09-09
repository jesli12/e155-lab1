-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/jesli/Documents/GitHub/e155-lab1/fpga/iCE40_lab1/source/impl_1/counter_2_4Hz.sv" 
"C:/Users/jesli/Documents/GitHub/e155-lab1/fpga/iCE40_lab1/source/impl_1/lab1_jl.sv" 
"C:/Users/jesli/Documents/GitHub/e155-lab1/fpga/iCE40_lab1/source/impl_1/switch_to_display.sv" 
"C:/Users/jesli/Documents/GitHub/e155-lab1/fpga/iCE40_lab1/source/impl_1/lab1_counter_2_4Hz_tb.sv" 
"C:/Users/jesli/Documents/GitHub/e155-lab1/fpga/iCE40_lab1/source/impl_1/lab1_jl_tb.sv" 
"C:/Users/jesli/Documents/GitHub/e155-lab1/fpga/iCE40_lab1/source/impl_1/lab1_switch_to_display_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top lab1_jl_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run 100 ns"
