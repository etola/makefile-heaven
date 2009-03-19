#........................................
packagename :=
description :=
version := 0.1
author := Engin Tola
licence := GPL v2.0 or higher distributed by FSF
#........................................
sources :=
#........................................
installdir := /home/tola/usr
external_sources :=
external_libraries := kutility
libdir := .
srcdir := .
includedir:= .
define_flags :=
custom_ld_flags :=
#........................................
optimize := true
parallelize := false
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
