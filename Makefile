##############
# parameters #
##############
# do you want to show the commands executed ?
DO_MKDBG?=0


#############
# variables #
#############
SYSTEM_ARCH:=$(shell arch)
#ARCH:=elf32
ARCH:=elf64
SOURCES=$(shell find src -name "*.asm")
OBJECTS=$(addprefix out/, $(addsuffix .o,$(basename $(SOURCES))))
BINARIES=$(addprefix out/, $(addsuffix .elf,$(basename $(SOURCES))))
ALL:=$(BINARIES)


########
# code #
########
# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

# rules
$(BINARIES): out/%.elf: out/%.o
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)ld -o $@ $<

$(OBJECTS): out/%.o: %.asm
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)nasm -f $(ARCH) -o $@ $<

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)-rm -f $(ALL) hello.o

.PHONY: debug
debug:
	$(info SOURCES is $(SOURCES))
	$(info OBJECTS is $(OBJECTS))
	$(info BINARIES is $(BINARIES))
	$(info SYSTEM_ARCH is $(SYSTEM_ARCH))
	$(info ARCH is $(ARCH))
	$(info ALL is $(ALL))
