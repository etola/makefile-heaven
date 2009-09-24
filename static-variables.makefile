################################################################################
################# - MAKEFILE STATIC VARIABLES - ################################
################################################################################

ifeq ($(major_version),)
 major_version := 0
endif
ifeq ($(minor_version),)
 minor_version := 1
endif
ifeq ($(tiny_version),)
 tiny_version := 0
endif

ifeq ($(version),)
 version := $(major_version)"."$(minor_version)"."$(tiny_version)
endif

ifeq ($(optimize),false)
  packagename := $(packagename)d
  outdir := debug/
else
  outdir := release/
endif

srcdir := ${srcdir}/

# sources_list = $(sources)
sources_list = $(addprefix $(srcdir), $(sources))

objectfiles       := $(filter %.o,$(subst   .c,.o,$(sources)))
objectfiles       += $(filter %.o,$(subst  .cc,.o,$(sources)))
objectfiles       += $(filter %.o,$(subst .cpp,.o,$(sources)))

# objects = $(objectfiles)
objects = $(addprefix $(outdir), $(objectfiles))

dependencies  := $(subst .o,.d,$(objects))

depdir := $(dir ${dependencies})

# dependencies := $(srcdir)$(dependencies)
# dependencies := $(subst $(srcdir), $(outdir), $(dependencies))

libdir := ${outdir}${libdir}
libname       := lib$(packagename)
libtarget     := $(libdir)/$(libname).a
libsoname     := $(libname).so.$(major_version)
librealname   := $(libdir)/$(libname).so.$(version)
exetarget     := $(packagename)
pkgconfigfile := $(packagename).pc

automakefile := make.auto
commentfile  := makefile.comment

tag_file:=TAGS
tag_generator:='$(MAKEFILE_HEAVEN)/tags.sh'
tag_depends:=${external_libraries}
tag_src := ${includedir}/*.h ${includedir}/${packagename}/*.h		\
${includedir}/*.tcc ${includedir}/${packagename}/*.tcc ${srcdir}*.cpp	\
${srcdir}*.cc $(srcdir)*.c

# compiler := g++
compiler := colorgcc
CXX := ${compiler}

curpath=`pwd -P`

REQUIRED_DIRS = ${outdir} ${libdir} ${depdir}

