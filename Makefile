.PHONY: caravan
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
# Caravan image
CARAVAN_IMAGE_NAME=ankoh/caravan
CARAVAN_IMAGE_TAG=latest
caravan:
	git archive --format=tar HEAD | \
		docker build -t ${CARAVAN_IMAGE_NAME}:${CARAVAN_IMAGE_TAG} -f ./caravan/Dockerfile -
#---------------------------------------------------------------------------
