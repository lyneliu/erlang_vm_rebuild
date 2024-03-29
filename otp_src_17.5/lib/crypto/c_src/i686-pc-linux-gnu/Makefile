#
# %CopyrightBegin%
#
# Copyright Ericsson AB 1999-2012. All Rights Reserved.
#
# The contents of this file are subject to the Erlang Public License,
# Version 1.1, (the "License"); you may not use this file except in
# compliance with the License. You should have received a copy of the
# Erlang Public License along with this software. If not, it can be
# retrieved online at http://www.erlang.org/.
#
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
# the License for the specific language governing rights and limitations
# under the License.
#
# %CopyrightEnd%
#
include $(ERL_TOP)/make/target.mk
include $(ERL_TOP)/make/$(TARGET)/otp.mk
include $(ERL_TOP)/make/$(TARGET)/otp_ded.mk

# ----------------------------------------------------
# Application version
# ----------------------------------------------------
include ../vsn.mk
VSN=$(CRYPTO_VSN)

# ----------------------------------------------------
# The following variables differ between systems.
# Set by configure.
# ----------------------------------------------------
CC = $(DED_CC)
LD = $(DED_LD)
SHELL = /bin/sh
LIBS = $(DED_LIBS)
LDFLAGS += $(DED_LDFLAGS)
CFLAGS = $(DED_CFLAGS)

# From erts/configure
SSL_LIBDIR = /usr/lib
SSL_INCLUDE = -I/usr/include
SSL_CRYPTO_LIBNAME = crypto
SSL_SSL_LIBNAME = ssl


INCLUDES = $(SSL_INCLUDE) $(DED_INCLUDES)

ifeq ($(TYPE),debug)
TYPEMARKER = .debug
TYPE_FLAGS = $(subst -O3,,$(subst -O2,,$(CFLAGS))) -DDEBUG
else
ifeq ($(TYPE),valgrind)
TYPEMARKER = .valgrind
TYPE_FLAGS = $(subst -O3,,$(subst -O2,,$(CFLAGS))) -DVALGRIND
else
TYPEMARKER =
TYPE_FLAGS = $(CFLAGS)
endif
endif

# ----------------------------------------------------
# Release directory specification
# ----------------------------------------------------
RELSYSDIR = $(RELEASE_PATH)/lib/crypto-$(VSN)

# ----------------------------------------------------
# Misc Macros
# ----------------------------------------------------
CRYPTO_OBJS = $(OBJDIR)/crypto$(TYPEMARKER).o
CALLBACK_OBJS = $(OBJDIR)/crypto_callback$(TYPEMARKER).o
NIF_MAKEFILE = $(PRIVDIR)/Makefile
CRYPTO_STATIC_OBJS = $(OBJDIR)/crypto_static$(TYPEMARKER).o\
	$(OBJDIR)/crypto_callback_static$(TYPEMARKER).o

NIF_ARCHIVE = $(LIBDIR)/crypto$(TYPEMARKER).a

ifeq ($(findstring win32,$(TARGET)), win32)
NIF_LIB = $(LIBDIR)/crypto$(TYPEMARKER).dll
CALLBACK_LIB = $(LIBDIR)/crypto_callback$(TYPEMARKER).dll
else
NIF_LIB = $(LIBDIR)/crypto$(TYPEMARKER).so
CALLBACK_LIB = $(LIBDIR)/crypto_callback$(TYPEMARKER).so
endif

ifeq ($(HOST_OS),)
HOST_OS := $(shell $(ERL_TOP)/erts/autoconf/config.guess)
endif
DYNAMIC_CRYPTO_LIB=yes

ifeq ($(DYNAMIC_CRYPTO_LIB),yes)
SSL_DED_LD_RUNTIME_LIBRARY_PATH = -Wl,-R/usr/lib -Wl,-R/usr/local/lib -Wl,-R/usr/sfw/lib -Wl,-R/opt/local/lib -Wl,-R/usr/pkg/lib -Wl,-R/usr/local/openssl/lib -Wl,-R/usr/lib/openssl/lib -Wl,-R/usr/openssl/lib -Wl,-R/usr/local/ssl/lib -Wl,-R/usr/lib/ssl/lib -Wl,-R/usr/ssl/lib -Wl,-R//lib
CRYPTO_LINK_LIB=$(SSL_DED_LD_RUNTIME_LIBRARY_PATH) -L$(SSL_LIBDIR) -l$(SSL_CRYPTO_LIBNAME)
EXTRA_FLAGS = -DHAVE_DYNAMIC_CRYPTO_LIB
else
SSL_DED_LD_RUNTIME_LIBRARY_PATH=
CRYPTO_LINK_LIB=$(SSL_LIBDIR)/lib$(SSL_CRYPTO_LIBNAME).a 
EXTRA_FLAGS =
CRYPTO_OBJS := $(CRYPTO_OBJS) $(CALLBACK_OBJS)
CALLBACK_OBJS =
CALLBACK_LIB =
endif

ifeq ($(USING_VC),yes)
AR_OUT=-out:
AR_FLAGS=
else
AR_OUT=
ifeq ($(V),0)
AR_FLAGS=rc
else
AR_FLAGS=rcv
endif
endif

ifndef RANLIB
RANLIB=true
endif

ALL_CFLAGS = $(TYPE_FLAGS) $(EXTRA_FLAGS) $(INCLUDES)
ALL_STATIC_CFLAGS = $(DED_STATIC_CFLAGS) $(INCLUDES)

# ----------------------------------------------------
# Targets
# ----------------------------------------------------

_create_dirs := $(shell mkdir -p $(OBJDIR) $(LIBDIR))

ifneq ($(findstring ose,$(TARGET)),ose)
debug opt valgrind: $(NIF_LIB) $(CALLBACK_LIB)
else
# Do not build dynamic files on OSE
debug opt valgrind:
endif

static_lib: $(NIF_ARCHIVE)

$(OBJDIR)/%$(TYPEMARKER).o: %.c
	$(V_at)$(INSTALL_DIR) $(OBJDIR)
	$(V_CC) -c -o $@ $(ALL_CFLAGS) $<

$(LIBDIR)/crypto$(TYPEMARKER).so: $(CRYPTO_OBJS)
	$(V_at)$(INSTALL_DIR) $(LIBDIR)
	$(V_LD) $(LDFLAGS) -o $@ $^ $(LDLIBS) $(CRYPTO_LINK_LIB)

$(OBJDIR)/%_static$(TYPEMARKER).o: %.c
	$(V_at)$(INSTALL_DIR) $(OBJDIR)
	$(V_CC) -c -o $@ $(ALL_STATIC_CFLAGS) $<

$(LIBDIR)/crypto$(TYPEMARKER).a: $(CRYPTO_STATIC_OBJS)
	$(V_AR) $(AR_FLAGS) $(AR_OUT)$@ $(CRYPTO_STATIC_OBJS)
	$(V_RANLIB) $@

$(LIBDIR)/crypto$(TYPEMARKER).dll: $(CRYPTO_OBJS)
	$(V_at)$(INSTALL_DIR) $(LIBDIR)
	$(V_LD) $(LDFLAGS) -o $@  $(SSL_DED_LD_RUNTIME_LIBRARY_PATH) -L$(SSL_LIBDIR) $(CRYPTO_OBJS) -l$(SSL_CRYPTO_LIBNAME) -l$(SSL_SSL_LIBNAME)

ifeq ($(DYNAMIC_CRYPTO_LIB),yes)
$(LIBDIR)/crypto_callback$(TYPEMARKER).so: $(CALLBACK_OBJS)
	$(INSTALL_DIR) $(LIBDIR)
	$(LD) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(LIBDIR)/crypto_callback$(TYPEMARKER).dll: $(CALLBACK_OBJS)
	$(INSTALL_DIR) $(LIBDIR)
	$(LD) $(LDFLAGS) -o $@ $(CALLBACK_OBJS)
endif


clean:
ifeq ($(findstring win32,$(TARGET)), win32)
	rm -f $(LIBDIR)/crypto.dll
	rm -f $(LIBDIR)/crypto.debug.dll
	rm -f $(LIBDIR)/crypto_callback.dll
	rm -f $(LIBDIR)/crypto_callback.debug.dll
else
	rm -f $(LIBDIR)/crypto.so
	rm -f $(LIBDIR)/crypto.debug.so
	rm -f $(LIBDIR)/crypto.valgrind.so
	rm -f $(LIBDIR)/crypto_callback.so
	rm -f $(LIBDIR)/crypto_callback.debug.so
	rm -f $(LIBDIR)/crypto_callback.valgrind.so
endif
	rm -f $(OBJDIR)/crypto.o
	rm -f $(OBJDIR)/crypto_static.o
	rm -f $(OBJDIR)/crypto.debug.o
	rm -f $(OBJDIR)/crypto_static.debug.o
	rm -f $(OBJDIR)/crypto.valgrind.o
	rm -f $(OBJDIR)/crypto_static.valgrind.o
	rm -f $(OBJDIR)/crypto_callback.o
	rm -f $(OBJDIR)/crypto_callback.debug.o
	rm -f $(OBJDIR)/crypto_callback.valgrind.o
	rm -f core *~

docs:

# ----------------------------------------------------
# Release Target
# ---------------------------------------------------- 
include $(ERL_TOP)/make/otp_release_targets.mk

release_spec: opt
	$(INSTALL_DIR) "$(RELSYSDIR)/priv/obj"
	$(INSTALL_DIR) "$(RELSYSDIR)/priv/lib"
	$(INSTALL_DATA) $(NIF_MAKEFILE) "$(RELSYSDIR)/priv/obj"
ifneq ($(findstring ose,$(TARGET)),ose)
	$(INSTALL_PROGRAM) $(CRYPTO_OBJS) "$(RELSYSDIR)/priv/obj"
	$(INSTALL_PROGRAM) $(NIF_LIB) "$(RELSYSDIR)/priv/lib"
ifeq ($(DYNAMIC_CRYPTO_LIB),yes)
	$(INSTALL_PROGRAM) $(CALLBACK_OBJS) "$(RELSYSDIR)/priv/obj"
	$(INSTALL_PROGRAM) $(CALLBACK_LIB) "$(RELSYSDIR)/priv/lib"
endif
endif

release_docs_spec:

