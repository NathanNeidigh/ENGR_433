TOP = blank

SRC = $(TOP).v
PCF = $(TOP).pcf

JSON = bin/$(TOP).json
ASC = bin/$(TOP).asc
BIN = bin/bitstream.bin

DEVICE = up5k
PACKAGE = sg48
PNR_SEED =

RAM = true

all: $(BIN)

flash: all
	cp -f $(BIN) /run/media/$$USER/5221-0000/bitstream.bin || (sleep 2 && cp -f $(BIN) /run/media/$$USER/5221-0000/bitstream.bin)
	if [ "$(RAM)" = "true" ]; then \
		sudo ~/.local/bin/mpremote connect /dev/ttyACM0 run flash_RAM.py; \
	else \
		sudo ~/.local/bin/mpremote connect /dev/ttyACM0 run flash.py; \
	fi

$(JSON): $(SRC)
	yosys -q -p 'read_verilog $<; synth_ice40 -top $(TOP) -json $@'

$(ASC): $(JSON) $(PCF)
	nextpnr-ice40 -q --$(DEVICE) \
		$(if $(PACKAGE), --package $(PACKAGE)) \
		--json $(JSON) \
		--asc $@ \
		--top blank

$(BIN): $(ASC)
	icepack $< $@

clean:
	-@rm -f bin/*
	-@rm -f /run/media/$$USER/5221-0000/bitstream.bin
