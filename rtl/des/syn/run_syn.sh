if [ $# -eq 1 ]; then
  export SYNTH_OUT_DIR=$1
elif [ $# -eq 0 ]; then
  export SYNTH_OUT_DIR_PREFIX="${SYNTH_DIR}/syn_out/${TOP_MODULE}"
  SYNTH_OUT_DIR=$(date +"${SYNTH_OUT_DIR_PREFIX}_%d_%m_%Y_%H_%M_%S")
  export SYNTH_OUT_DIR
else
  echo "Usage $0 [synth_out_dir]"
  exit 1
fi

mkdir -p $SYNTH_OUT_DIR/generated

for file in ${SRC_DIR}/*.sv; do
    module=$(basename -s .sv "$file")
	sv2v \
		--define=SYNTHESIS --define=YOSYS \
		"$file" > "$SYNTH_OUT_DIR"/generated/"${module}".v
done

yosys -c ${SYNTH_DIR}/tcl/yosys_run_synth.tcl

netlistsvg "$SYNTH_OUT_DIR"/generated/design.json -o "$SYNTH_OUT_DIR"/generated/design.svg 
rm "$SYNTH_OUT_DIR"/generated/design.json 

