################################################################################
################# - MAKEFILE STATIC VARIABLES - ################################
################################################################################

sources_list = $(addprefix $(srcdir)/, $(sources))

objects       := $(filter %.o,$(subst   .c,.o,$(sources_list)))
objects       += $(filter %.o,$(subst  .cc,.o,$(sources_list)))
objects       += $(filter %.o,$(subst .cpp,.o,$(sources_list)))
dependencies  := $(subst .o,.d,$(objects))

libtarget     := $(libdir)/lib$(packagename).a
exetarget     := $(packagename)
pkgconfigfile := $(packagename).pc

automakefile := make.auto
commentfile  := makefile.comment

tag_file:=TAGS
tag_generator:='$(MAKEFILE_HEAVEN)/tags.sh'
tag_depends:=${external_libraries}
tag_src := $(includedir)/*.h $(includedir)/$(packagename)/*.h		\
$(includedir)/*.tcc $(includedir)/$(packagename)/*.tcc $(srcdir)/*.cpp	\
$(srcdir)/*.cc $(srcdir)/*.c

compiler := g++
CXX := ${compiler}

curpath=`pwd -P`
