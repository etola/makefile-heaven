################################################################################
########################### - MAKEFILE FLAGS - #################################
################################################################################

ARFLAGS = ruv
CTAGFLAGS := -e -R --languages=c++,c

#
#
#
ifneq (,$(findstring libpng,$(external_libraries)))
  define_flags += -DWITH_LIBPNG
endif
ifneq (,$(findstring libjpeg,$(external_libraries)))
  define_flags += -DWITH_LIBJPEG
endif
ifneq (,$(findstring opencv,$(external_libraries)))
  define_flags += -DWITH_OPENCV
endif


ifeq ($(optimize),false)
  external_libraries := $(patsubst argus,argusd,$(external_libraries))
  external_libraries := $(patsubst cosmos,cosmosd,$(external_libraries))
  external_libraries := $(patsubst kutility,kutilityd,$(external_libraries))
  external_libraries := $(patsubst kortex,kortexd,$(external_libraries))
  external_libraries := $(patsubst kortex-ext-la,kortex-ext-lad,$(external_libraries))
  external_libraries := $(patsubst kortex-ext-3d-classes,kortex-ext-3d-classesd,$(external_libraries))
  external_libraries := $(patsubst kortex-ext-opencv,kortex-ext-opencvd,$(external_libraries))
  external_libraries := $(patsubst kortex-ext-calibration,kortex-ext-calibrationd,$(external_libraries))
  external_libraries := $(patsubst beholder,beholderd,$(external_libraries))
  external_libraries := $(patsubst karpet,karpetd,$(external_libraries))
  external_libraries := $(patsubst daisy,daisyd,$(external_libraries))
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

ifeq ($(boost-thread),true)
 LDFLAGS += -lboost_thread-mt
endif

ifeq ($(sse),true)
    define_flags += -DWITH_SSE
    CXXFLAGS += -msse -msse2 -msse4.2
    CPPFLAGS += -msse -msse2 -msse4.2
endif

CXXFLAGS += -fno-strict-aliasing -Wall -fPIC

ifeq ($(multi-threading),true)
    CXXFLAGS += -lpthread
endif

ifeq ($(profile),true)
  CXXFLAGS+= -pg
endif


ifeq ($(optimize),true)
  CXXFLAGS += -O3  -DNDEBUG -DHAVE_INLINE
  spc_flags = -march=$(platform) -mfpmath=sse
  ifeq ($(specialize),true)
     CXXFLAGS += $(spc_flags)
  endif
else
  CXXFLAGS += -g -DDEBUG
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

#
## -rdynamic: lets meaningful backtrace messagas.
#
CXXFLAGS += -ffast-math -rdynamic  ${define_flags} -I$(includedir) ${custom_cflags}
LDFLAGS += ${custom_ld_flags}

