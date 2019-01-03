.PNONY:all
LUACPATH ?= luaclib

include ./silly/Platform.mk

CCFLAG += -I./silly/deps/lua/

all: $(LUACPATH) $(LUACPATH)/iconv.so

linux: all

$(LUACPATH):
	mkdir $(LUACPATH)

$(LUACPATH)/iconv.so:luaiconv.c
	$(CC) $(CCFLAG) -o $@ $^ $(SHARED)

