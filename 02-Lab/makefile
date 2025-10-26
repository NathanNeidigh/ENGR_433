TOP = color_mixer
TEST = tb.v

SRC = $(TOP).v
PCF = $(TOP).pcf

JSON = bin/$(TOP).json
ASC = bin/$(TOP).asc
BIN = bin/bitstream.bin

DEVICE = up5k
PACKAGE = sg48
PNR_SEED =

INCLUDE = -I/home/neidna/ENGR_433/99-common

RAM = true

all: $(BIN)

flash: $(BIN)
	cp -f $(BIN) /run/media/$$USER/5221-0000/bitstream.bin || (sleep 2 && cp -f $(BIN) /run/media/$$USER/5221-0000/bitstream.bin)
	if [ "$(RAM)" = "true" ]; then \
		sudo ~/.local/bin/mpremote connect /dev/ttyACM0 run flash_RAM.py; \
	else \
		sudo ~/.local/bin/mpremote connect /dev/ttyACM0 run flash.py; \
	fi

test: $(TEST)
	iverilog $(INCLUDE) -DSIMULATION $(TEST) -o bin/test
	./bin/test

$(JSON): $(SRC)
	yosys -q -p 'read_verilog $(INCLUDE) $(SRC); synth_ice40 -top $(TOP) -json $(JSON)'

$(ASC): $(JSON) $(PCF)
	nextpnr-ice40 -q --$(DEVICE) \
		$(if $(PACKAGE), --package $(PACKAGE)) \
		--json $(JSON) \
		--pcf $(PCF) \
		--asc $(ASC) \
		$(if $(PNR_SEED), --seed $(PNR_SEED))

$(BIN): $(ASC)
	icepack $(ASC) $(BIN)

clean:
	-@rm -f bin/*
	-@rm -f /run/media/$$USER/5221-0000/bitstream.bin
	-@rm -f dump.vcd

jeff:
	echo $(RAM)
