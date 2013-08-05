#
# package & author info
#
packagename := 
description := 
major_version := 0
minor_version := 1
tiny_version  := 0
# version := major_version . minor_version # depracated
author := Engin Tola
licence := see LICENSE file
#
# add you cpp cc files here
#
sources := 
#
# output info
#
installdir := /home/tola/usr
external_sources :=
external_libraries := kortex
libdir := .
srcdir := .
includedir:= .
#
# custom flags
#
define_flags :=
custom_ld_flags :=
custom_cflags :=
#
# optimization & parallelization ?
#
optimize ?= false
parallelize ?= false
boost-thread ?= false
f77 ?= false
sse ?= true
multi-threading ?= false
profile ?= false
#........................................
specialize := true
platform := native
#........................................
compiler := g++
#........................................
include $(MAKEFILE_HEAVEN)/static-variables.makefile
include $(MAKEFILE_HEAVEN)/flags.makefile
include $(MAKEFILE_HEAVEN)/rules.makefile
