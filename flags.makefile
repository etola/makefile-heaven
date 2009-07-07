################################################################################
########################### - MAKEFILE FLAGS - #################################
################################################################################

ARFLAGS = ruv
CTAGFLAGS := -e -R --languages=c++,c

CXXFLAGS += ${define_flags} -I$(includedir) ${custom_cflags}
LDFLAGS += ${custom_ld_flags}

ifneq ($(external_sources),)
 CXXFLAGS += `pkg-config --cflags ${external_sources}`
endif

ifneq ($(external_libraries),)
 CXXFLAGS += `pkg-config --cflags ${external_libraries}`
 LDFLAGS  += `pkg-config --cflags-only-other --libs ${external_libraries}`
endif

ifeq ($(f77),true)
 LDFLAGS += -lg2c
endif

ifeq ($(sse),true)
    CXXFLAGS += -msse -msse2
    CPPFLAGS += -msse -msse2
endif

CXXFLAGS += -fno-strict-aliasing -Wall

ifeq ($(multi-threading),true)
    CXXFLAGS += -lpthread
endif

ifeq ($(profile),true)
  CXXFLAGS+= -pg
endif

dbg_flags = -g -DDEBUG
opt_flags = -O3 -DHAVE_INLINE -DGSL_RANGE_CHECK_OFF -DNDEBUG
spc_flags = '-march=$(platform)' -mfpmath=sse

ifeq ($(parallelize),true)
   CXXFLAGS += -fopenmp
endif
ifeq ($(optimize),true)
  CXXFLAGS += $(opt_flags)
  ifeq ($(specialize),true)
     CXXFLAGS += $(spc_flags)
  endif
else
  CXXFLAGS += ${dbg_flags}
  parallelize = false
endif

is_debug := $(wildcard .debug)

ifeq ($(strip $(is_debug)),)
  is_debug = true
else
  is_debug = false
endif

ifeq ($(optimize),true)
  state_file = .release
else
  state_file = .debug
endif

