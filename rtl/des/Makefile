TOP       = des
SYNTH_DIR = syn
BUILD_DIR = build
SRC_DIR   = src
TB_DIR    = tb

SRC_FILES = $(wildcard ${SRC_DIR}/*.sv)

SRC_SV = $(notdir ${SRC_FILES})

SRC_SYNTH = $(SRC_SV:.sv=_syn.sv)

TTY_DEV=$(shell tty)

LAST_SYN_OUT=$(shell ls -1 ${SYNTH_DIR}/syn_out/ | tail -n1)
LAST_SYN_OUT_DIR=${SYNTH_DIR}/syn_out/${LAST_SYN_OUT}


all: synth

.PHONY = tb test

synth:
	SRC_DIR=${SRC_DIR} SYNTH_DIR=${SYNTH_DIR} TOP_MODULE=${TOP} ${SYNTH_DIR}/run_syn.sh

viewer:
	xdg-open ${LAST_SYN_OUT_DIR}/generated/design.svg

tb: test
	

test: ${TB_DIR}/sim
	$< 

${TB_DIR}/sim: ${TB_DIR}/${TOP}_tb.sv ${LAST_SYN_OUT_DIR}/generated/${TOP}_netlist.v
	iverilog -g2012 -o ${TB_DIR}/sim -s ${TOP}_tb $^


clean: 
	rm -rf ${BUILD_DIR}/* slpp_all tb/sim ${SYNTH_DIR}/syn_out 
