.PHONY: caravan
.DEFAULT_GOAL := all
#---------------------------------------------------------------------------
# Environment
SYS := $(shell uname)
#---------------------------------------------------------------------------
# Platform Makefiles
ifeq ($(SYS),Darwin)
include Makefile.macos
else
include Makefile.linux
endif
#---------------------------------------------------------------------------
