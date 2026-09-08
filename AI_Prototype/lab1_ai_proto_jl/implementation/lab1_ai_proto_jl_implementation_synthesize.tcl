if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2026.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/jesli/Documents/GitHub/e155-lab1/AI_Prototype/lab1_ai_proto_jl"
if {![file exists {C:/Users/jesli/Documents/GitHub/e155-lab1/AI_Prototype/lab1_ai_proto_jl/implementation}]} {
  file mkdir {C:/Users/jesli/Documents/GitHub/e155-lab1/AI_Prototype/lab1_ai_proto_jl/implementation}
}
cd {C:/Users/jesli/Documents/GitHub/e155-lab1/AI_Prototype/lab1_ai_proto_jl/implementation}
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- lab1_ai_proto_jl_implementation_cpe.ldc
::radiant::runengine::run_engine_newmsg cpe -syn lse -f "lab1_ai_proto_jl_implementation.cprj" -a "iCE40UP"  -o lab1_ai_proto_jl_implementation_cpe.ldc
# synthesize top design
file delete -force -- lab1_ai_proto_jl_implementation.vm lab1_ai_proto_jl_implementation.ldc
::radiant::runengine::run_engine_newmsg synthesis -f "C:/Users/jesli/Documents/GitHub/e155-lab1/AI_Prototype/lab1_ai_proto_jl/implementation/lab1_ai_proto_jl_implementation_lattice.synproj" -logfile "lab1_ai_proto_jl_implementation_lattice.srp"
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o lab1_ai_proto_jl_implementation_syn.udb lab1_ai_proto_jl_implementation.vm] [list lab1_ai_proto_jl_implementation.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}
