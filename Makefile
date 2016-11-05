.DEFAULT_GOAL := all
#---------------------------------------------------------------------------
# Environment
SYS := $(shell uname)
#---------------------------------------------------------------------------
# Platform Makefiles
ifeq ($(SYS),Darwin)
include Makefile.darwin
else
include Makefile.linux
endif
#---------------------------------------------------------------------------
