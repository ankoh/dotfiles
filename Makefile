.DEFAULT_GOAL 		:= all
#---------------------------------------------------------------------------
# Environment
SYS					:= $(shell uname)
#---------------------------------------------------------------------------
# Platform Makefiles
ifeq ($(SYS),Darwin)
include Makefile.Darwin
else
include Makefile.Linux
endif
#---------------------------------------------------------------------------
