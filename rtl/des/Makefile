TOP       = des
SYNTH_DIR = synth
BUILD_DIR = build
SRC_DIR   = src
TB_DIR    = tb

SRC_FILES = $(wildcard ${SRC_DIR}/*.sv)

SRC_SV = $(notdir ${SRC_FILES})

SRC_SYNTH = $(SRC_SV:.sv=_syn.sv)

TB_SRC = $(addprefix ${TB_DIR}/, $(SRC_SYNTH))


all: synth




synth: ${SYNTH_DIR}/synth.ys
	yosys $< -o ${BUILD_DIR}/${TOP}.sv

${SYNTH_DIR}/synth.files.ys: ${SRC_FILES}
	@echo "plugin -i uhdm\nread_systemverilog $^" > $@


${SYNTH_DIR}/synth.ys:  ${SYNTH_DIR}/synth.files.ys ${SYNTH_DIR}/synth.part.ys
	@cat $^ > $@
	@rm $<

.PHONY = test
test: ${TB_DIR}/sim

${TB_DIR}/sim: ${TB_DIR}/${TOP}_tb.sv ${TB_SRC}
	iverilog -g2012 -o ${TB_DIR}/sim -s ${TOP}_tb $^
	rm ${TB_SRC}

${TB_DIR}/%_syn.sv: $(SRC_DIR)/%.sv 
	@yosys -Q -p "plugin -i uhdm; read_systemverilog $<" -o $@

clean: 
	rm -rf ${BUILD_DIR}/* slpp_all tb/sim synth/synth.ys
