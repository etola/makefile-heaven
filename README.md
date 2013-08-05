makefile-heaven
===============

a rapid makefile configuration utility


this set of files lets the user to quickly setup a makefile based project. 
the goal is to have a quick way to start a project but still have a h
uman-readable makefile in the end.

for this purpose we separate a standard makefile in to 3 separate files:


makefile                  : a very simple file which contains project and author information +
                            some true/false flags to set project options.
static-variables.makefile : generates variables that will be used in the rules.
flags.makefile            : expands true/false flags entered in the simple 'makefile' and generates actual flags that
                            will be passed to the compiler.
rules.makefile            : contains all the rules that you may want to do in a project.


features
========
- supports only single targets.
- able to generate executables, static and shared libraries
- debug and release versions are compiled into different directories so that
  switching between them does not result in full recompile.
- installation + uninstallation
- uses pkg-config to include libraries to your project (requires .pc files)


installation
============

- get the files and put them to some directory
- add 'export MAKEFILE_HEAVEN=/path/to/where/the/files/are/'
- copy the 'makefile' distributed with the archive to your project

- fill the fields 'packagename', 'author', 'installdir', 'srcdir', 'includedir'
  fields for your project

- set flags
    'optimize=true' for release mode
    'parallelize=true' for enabling openmp support
    'sse=true' for enabling SSE instructions

- add 'define_flags := -DWITH_SOMETHING' to pass a generic flag. Note: Some
  flags are automatically generated depending on the state of makefile
  variables. For example, optimize=true will add -DNDEBUG flag and
  optimize=false will add -DDEBUG flag. see the flags.makefile to see what other
  flags are enabled/disabled.

- you can run 'make flags' to see the compiler options that will be used when
  compiling your project any time.

- an example 'makefile' is given at the end of this README

rules
=====

currently supported rules:

```
(nothing)   : makes the executable :
library     : generates the library
slib        : generates shared library
install-slib: installs shared library
tags        : generates etags files
dox         : generates the doxygen documentation if Doxyfile exists
clear       : cleans up *~ #* and dependencies
clean       : cleans up .o lib and exe files
cleanaux    : cleans auxilary files: *.o *.d
cleandep    : cleans up the dependency files
cleandox    : cleans up the documentation
cleandist   : cleans everything except source+headers
install     : installs the executable
install-lib : installs the library
install-dev : installs the library along with documentation files
uninstall   : uninstalls the library
pkgfile     : generates the pkg-config file
flags       : shows the flags that will be used
gflat       : shows gprof profiler flat view result
gcall       : shows gprof profiler call graph view result
rules       : shows this text
state       : show the configuration state of the package
export      : export the makefile
revert      : moves makefile.in to makefile
```

more details
============

for more details, just have a look inside the flags/static-variables/rules.makefile 
files. they are pretty straightforward if you have some basic makefile experience...


examples
========

http://github.com/etola/kortex library uses this utility. The 'makefile' for the project is
given below. To point out some details in the  configuration below

- library name is set as kortex. the generated static lib file will be named
  libkortexd.a for debug mode and libkortex.a for release mode. Appending a 'd'
  at the end makes it easy to recursively link to debug-symbol enabled libraries
  so that you can step-into the library files during a debug session. 

- optimize?=false is used. so the library will be compiled with -g -DDEBUG
  options and will be named libkortexd.a. Also, the debug versions of the
  'external_libraries' will be linked to the code if they are specified in the
  flags.makefile list. see lines between 22-33 where I declare which libraries
  should be linked in debug mode... you can extend this list with your own
  libraries similarly...

- 'srcdir' and 'includedir' specify the location of the source and header files
  of the library. here, all the files given in 'sources' variable reside under
  src/ directory.

- external_libraries: 'libjpeg' and 'libpng' are specified as external libraries
  that this library depends on. the respective CFLAG, CXXFLAG and LDFLAG options
  for these libraries are generated using the 'pkg-config' utility. If you've
  not heard about it just have a look at some of the files under your
  /usr/lib/pkgconfig/ directory. Those are the pc files that this utility uses
  to generate compiler options.

example makefile (comments removed) for the kortex library:

```
packagename := kortex
description := base components of the kortex vision library developed by Aurvis R&D
major_version := 0
minor_version := 1
tiny_version  := 0
author := Engin Tola
licence := see LICENSE
sources := \
log_manager.cc \
check.cc \
[[redacted]]
installdir := /home/tola/usr/local/kortex/
external_sources :=
external_libraries := libjpeg libpng
libdir := lib
srcdir := src
includedir:= include
define_flags :=
custom_ld_flags :=
custom_cflags := -std=c++0x
optimize ?= false
parallelize ?= true
boost-thread ?= false
f77 ?= false
sse ?= true
multi-threading ?= false
profile ?= false
specialize := true
platform := native
compiler := g++
include $(MAKEFILE_HEAVEN)/static-variables.makefile
include $(MAKEFILE_HEAVEN)/flags.makefile
include $(MAKEFILE_HEAVEN)/rules.makefile
```
