ROOTDIR = $(CURDIR)/..
GCC_INST = $(ROOTDIR)/toolchain/gcc-toolchain-mips64-win64
N64_INST =$(ROOTDIR)/toolchain/libdragon
BINDIR = $(ROOTDIR)/bin
OBJDIR = $(ROOTDIR)/obj
CC=$(GCC_INST)/bin/mips64-elf-gcc.exe
AS=$(GCC_INST)/bin/mips64-elf-as.exe
LD=$(GCC_INST)/bin/mips64-elf-ld.exe
OBJCOPY = $(GCC_INST)/bin/mips64-elf-objcopy.exe
N64TOOL = $(N64_INST)/tools/n64tool.exe
CHKSUM64PATH = $(N64_INST)/tools/chksum64.exe
HEADERPATH = $(N64_INST)/lib/header
#ABI = -mabi=64 -msym32
ABI = -mabi=o64
CFLAGS = --std=gnu99 -march=vr4300 -mtune=vr4300 -O2 -G0 -Wall -Werror -I$(GCC_INST)/include -I$(GCC_INST)/mips64-elf/include -I$(N64_INST)/include -I$(ROOTDIR)/src -O2 -G0
CFLAGS += -ffunction-sections -fdata-sections  $(ABI) -ggdb3
ASFLAGS =  -march=vr4300 -mtune=vr4300 -g $(ABI)

STUBOBJS = gdbstub.o gdbstubl.o cache.o

BASENAME = sample
ROM = $(BASENAME).z64
BIN = $(BASENAME).bin
ELF = $(BASENAME).elf
OBJS = sample.o $(STUBOBJS)
LIBS = -L$(N64_INST)/lib -L$(GCC_INST)/mips64-elf/lib -ldragon -lc -lm -ldragonsys
LINK_FLAGS = -G0 $(LIBS) -Tn64ld.x

.PHONY: all clean

all: $(ROM)

#clean:
#	-rm $(ROM) $(BIN) $(ELF) $(OBJS)

$(ROM): $(BIN)
	$(N64TOOL) -l 1028K -t "test program" -h $(HEADERPATH) -o $@ $<
	$(CHKSUM64PATH) $@

$(BIN): $(ELF)
	$(OBJCOPY) $< $@ -O binary

$(ELF): $(OBJS)
	$(LD) -o $@ $(OBJS) $(LINK_FLAGS)

#%.o : %.c
#	$(CC) -Tn64ld.x -G0 -Wl,-Map,$@.map -o $@ $^ $(LIBS)

gdbstubl.o: gdbstubl.S 3264.h gdbstub.h
gdbstub.o: gdbstub.c 3264.h regs.h cache.h gdbstub.h
cache.o: cache.c cache.h
