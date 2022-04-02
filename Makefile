CC = gcc
CFLAGS = -c -Wall -Wextra -O3 -Iinclude
LD = $(CC)

# Insert Flags for a New Extension here:

	# Rotate Extension
ifeq ($(EXT_ROTATE),1)
	CFLAGS += -DEXT_ROTATE
endif

	# Displacement Jump Extension
ifeq ($(EXT_DJUMP),1)
	CFLAGS += -DEXT_DJUMP
endif

# End of Extension Flags

UNAME_S := $(shell uname -s)

TARGET = MimaSim
SOURCE_FILES = $(wildcard src/*.c)
OBJECTS = $(patsubst %.c, %.o, $(SOURCE_FILES))

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: clean
clean:
	rm -rf $(TARGET) $(OBJECTS)

debug: CFLAGS += -DDEBUG -g -fsanitize=address -fsanitize=undefined
debug: LDFLAGS += -fsanitize=address -fsanitize=undefined
debug: $(TARGET)

.PHONY: web
web: CC = emcc
web: CFLAGS = -O3 -s ASYNCIFY -DWEBASM -s WASM=1 -Iinclude -s ALLOW_MEMORY_GROWTH=1 -s EXPORTED_FUNCTIONS='["_mima_init", "_mima_compile_s", "_mima_delete", "_mima_run_micro_instruction_step", "_mima_run_instruction_step"]' -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap", "allocate", "intArrayFromString"]'
web: 
	$(CC) $(filter-out src/main.c, $(wildcard src/*.c)) $(CFLAGS) -o web/MimaSim.js