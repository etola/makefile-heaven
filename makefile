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
licence := GPL v2.0 or higher distributed by FSF
#
# add you cpp cc files here
#
sources :=
#
# output info
#
installdir := /home/tola/usr
external_sources :=
external_libraries := karpet
libdir := .
srcdir := .
includedir:= .
#
# custom flags
#
define_flags :=
custom_ld_flags :=
#
# optimization & parallelization ?
#
optimize := true
parallelize := true
f77 := false
sse := false
multi-threading := false
profile := false
#........................................
specialize := false
platform := native
#........................................
include $(MAKEFILE_HEAVEN)/static-variables.makefile
include $(MAKEFILE_HEAVEN)/flags.makefile
include $(MAKEFILE_HEAVEN)/rules.makefile
