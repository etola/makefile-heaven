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

# used when exporting standalone makefile
packagename_o  := $(packagename)
sources_list_o := ${sources}
libdir_o       := ${libdir}
srcdir_o       := ${srcdir}

#
path_after_home = $(shell echo ${PWD} | cut -d'/' -f4-)
ifneq ($(main_build_dir),)
  build_dir := ${main_build_dir}${path_after_home}
else
  build_dir := ./
endif


ifeq ($(optimize),false)
  packagename := $(packagename)d
  outdir := ${build_dir}/debug/
  l_outdir := debug
else
  outdir := ${build_dir}/release/
  l_outdir := release
endif

ifneq (${build_dir},./)
RM_STATE    := $(shell rm ${l_outdir} )
_LINK_STATE := $(shell ln -sf ${outdir} ${l_outdir})
endif


srcdir := ${srcdir}/

sources_list = $(addprefix $(srcdir), $(sources))

objectfiles       := $(filter %.o,$(subst   .c,.o,$(sources)))
objectfiles       += $(filter %.o,$(subst  .cc,.o,$(sources)))
objectfiles       += $(filter %.o,$(subst .cpp,.o,$(sources)))

objects = $(addprefix $(outdir), $(objectfiles))

dependencies  := $(subst .o,.d,$(objects))

depdir := $(dir ${dependencies})


bindir        := ${outdir}'/bin/'
libdir        := ${outdir}${libdir}
libname       := lib$(packagename)
libtarget     := $(libdir)/$(libname).a
libsoname     := $(libname).so.$(major_version)
librealname   := $(libdir)/$(libname).so.$(version)
exetarget     := ${bindir}$(packagename)
pkgconfigfile := $(packagename).pc

automakefile := make.auto
commentfile  := makefile.comment

tag_file:=TAGS
tag_generator:='$(MAKEFILE_HEAVEN)/tags.sh'
tag_depends:=${external_libraries}
tag_src := ${includedir}/*.h ${includedir}/${packagename}/*.h		\
${includedir}/*.tcc ${includedir}/${packagename}/*.tcc ${srcdir}*.cpp	\
${srcdir}*.cc $(srcdir)*.c

ifeq ($(compiler),)
 compiler := g++
endif
CXX := ${compiler}

curpath=`pwd -P`

REQUIRED_DIRS = ${outdir} ${libdir} ${depdir} ${bindir}

