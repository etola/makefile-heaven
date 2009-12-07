################################################################################
########################### - MAKEFILE FLAGS - #################################
################################################################################

ARFLAGS = ruv
CTAGFLAGS := -e -R --languages=c++,c

CXXFLAGS += ${define_flags} -I$(includedir) ${custom_cflags}
LDFLAGS += ${custom_ld_flags}

ifeq ($(optimize),false)
  external_libraries := $(subst kutility,kutilityd,$(external_libraries))
  external_libraries := $(subst kortex,kortexd,$(external_libraries))
  external_libraries := $(subst karpet,karpetd,$(external_libraries))
  external_libraries := $(subst daisy,daisyd,$(external_libraries))
  external_libraries := $(subst evidence,evidenced,$(external_libraries))
endif

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
    CXXFLAGS += -msse -msse2 -DWITH_SSE
    CPPFLAGS += -msse -msse2 -DWITH_SSE
endif

CXXFLAGS += -fno-strict-aliasing -Wall -fPIC

ifeq ($(multi-threading),true)
    CXXFLAGS += -lpthread
endif

ifeq ($(profile),true)
  CXXFLAGS+= -pg
endif

dbg_flags = -g -DDEBUG
opt_flags = -O3 -DHAVE_INLINE -DNDEBUG
spc_flags = -march=$(platform) -mfpmath=sse

ifeq ($(optimize),true)
  CXXFLAGS += $(opt_flags)
  ifeq ($(specialize),true)
     CXXFLAGS += $(spc_flags)
  endif
else
  CXXFLAGS += ${dbg_flags}
  parallelize = false
  profile = true
endif

ifeq ($(parallelize),true)
   CXXFLAGS += -fopenmp
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

