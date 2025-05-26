# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./keyExpansion.sv"
vlog "./subWord.sv"
vlog "./rcon.sv"
vlog "./Sbox.sv"
vlog "./registerFile.sv"
vlog "./aesUnit.sv"
vlog "./subBytes.sv"
vlog "./mixColumns_sub.sv"
vlog "./shiftRows.sv"
vlog "./sboxSb.sv"
vlog "./invShiftRows.sv"
vlog "./aesEnc.sv"
vlog "./aesDec.sv"
vlog "./sboxInvSb.sv"
vlog "./crypto_accelerator.sv"
vlog "./EXEC.sv"
vlog "./instrDec.sv"
vlog "./instructmem.sv"
vlog "./RF.sv"
vlog "./IF.sv"
vlog "./controlLogic.sv"
vlog "./ALU.sv"
vlog "./MALU.sv"
vlog "./programCounter.sv"
vlog "./shaUnit.sv"
vlog "./sigma.sv"
vlog "./rho.sv"
vlog "./Maj.sv"
vlog "./shr.sv"
vlog "./wordMem.sv"
vlog "./wordConst.sv"
vlog "./rotr.sv"
vlog "./initHash.sv"
vlog "./Ch.sv"
vlog "./setHashes.sv"
vlog "./finalHash.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work crypto_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do crypto_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
