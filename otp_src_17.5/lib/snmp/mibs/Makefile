#-*-makefile-*-   ; force emacs to enter makefile-mode

# %CopyrightBegin%
# 
# Copyright Ericsson AB 1996-2012. All Rights Reserved.
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

include $(ERL_TOP)/make/target.mk
include $(ERL_TOP)/make/$(TARGET)/otp.mk

# ----------------------------------------------------
# Application version
# ----------------------------------------------------
include ../vsn.mk
VSN = $(SNMP_VSN)

# ----------------------------------------------------
# Configured variables
# ----------------------------------------------------
PERL = perl

# ----------------------------------------------------
# Release directory specification
# ----------------------------------------------------
RELSYSDIR = $(RELEASE_PATH)/lib/snmp-$(VSN)

# ----------------------------------------------------
# Common macros
# ----------------------------------------------------

# NOTE: 
#    The OTP-REG mib actually belongs to another
#    application (otp_mibs), and is exported by this
#    app. But since that app is built later, we have 
#    to built it here in order to be able to build 
#    OTP-SNMPEA-MIB (that needs otpModules and
#    otpApplications).
MIBS_A = \
	RFC1213-MIB \
	STANDARD-MIB \
	SNMPv2-TM \
	SNMPv2-MIB \
	SNMP-FRAMEWORK-MIB \
	SNMP-MPD-MIB \
	SNMP-TARGET-MIB \
	SNMP-NOTIFICATION-MIB \
	SNMP-COMMUNITY-MIB \
	SNMP-USER-BASED-SM-MIB \
	SNMP-VIEW-BASED-ACM-MIB \
	SNMP-USM-AES-MIB \
	INET-ADDRESS-MIB \
	TRANSPORT-ADDRESS-MIB

MIBS_B = OTP-SNMPEA-MIB

BUILD_MIBS = \
	$(MIBS_A) \
	OTP-REG \
	$(MIBS_B)

MIBS = $(MIBS_A) $(MIBS_B)

STD_v1_MIB_FILES = \
	RFC1155-SMI.mib \
	RFC-1212.mib \
	RFC-1215.mib

STD_v2_MIB_FILES = \
	SNMPv2-SMI.mib \
	SNMPv2-TC.mib \
	SNMPv2-CONF.mib 

FUNCS_FILES = \
	STANDARD-MIB.funcs \
	SNMPv2-MIB.funcs \
	SNMP-NOTIFICATION-MIB.funcs \
	SNMP-TARGET-MIB.funcs

V1_MIB_FILES = v1/OTP-SNMPEA-MIB.mib.v1

MIB_FILES   = $(MIBS:%=%.mib)
BIN_TARGETS = $(MIBS:%=$(SNMP_BIN_TARGET_DIR)/%.bin)
HRL_TARGETS = $(MIBS:%=$(SNMP_HRL_TARGET_DIR)/%.hrl)

HRL_FILES = $(SNMP_HRL_TARGET_DIR)/SNMPv2-TC.hrl \
            $(HRL_TARGETS)

TARGET_FILES = \
	$(ERL_TOP)/lib/snmp/bin/snmp-v2tov1 \
	$(BUILD_MIBS:%=$(SNMP_BIN_TARGET_DIR)/%.bin) \
	$(HRL_TARGETS)  \
	$(V1_MIB_FILES)


# ----------------------------------------------------
# FLAGS
# ----------------------------------------------------

SNMP_FLAGS += -pa ../ebin +version

ifneq ($(MIBS_VERBOSITY),) 
SNMP_FLAGS += +'{verbosity, $(MIBS_VERBOSITY)}'
endif

ifeq ($(MIBS_REFERENCE),true) 
SNMP_FLAGS += +reference
endif

ifeq ($(MIBS_OPTIONS),true) 
SNMP_FLAGS += +options
endif

ifeq ($(MIBS_MC),true) 
SNMP_FLAGS += +module_compliance
endif

ifeq ($(MIBS_AC),true) 
SNMP_FLAGS += +agent_capabilities
endif


# ----------------------------------------------------
# Targets
# ----------------------------------------------------

OTP_MIBDIR = $(shell if test -d ../../otp_mibs; then echo otp_mibs; \
		      else echo sasl; fi)

debug opt: $(TARGET_FILES)

$(ERL_TOP)/lib/snmp/bin/snmp-v2tov1: $(ERL_TOP)/lib/snmp/bin/snmp-v2tov1.src
	$(gen_verbose)$(PERL) -p -e 's?%PERL%?$(PERL)? ' < $< > $@
	$(V_at)chmod 755 $@

$(SNMP_BIN_TARGET_DIR)/OTP-REG.bin:	$(ERL_TOP)/lib/$(OTP_MIBDIR)/mibs/OTP-REG.mib
	$(snmp_verbose)$(ERLC) -pa $(SNMP_TOOLKIT)/ebin -I $(SNMP_TOOLKIT)/priv/mibs $(SNMP_FLAGS) -o $(SNMP_BIN_TARGET_DIR) $<

# To support parallel make, we'll need explicit dependencies
# to ensure that an imported MIB has been compiled when it's needed.

$(SNMP_BIN_TARGET_DIR)/STANDARD-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/RFC1213-MIB.bin

$(SNMP_BIN_TARGET_DIR)/SNMP-TARGET-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/SNMP-FRAMEWORK-MIB.bin

$(SNMP_BIN_TARGET_DIR)/SNMP-NOTIFICATION-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/SNMP-FRAMEWORK-MIB.bin \
	$(SNMP_BIN_TARGET_DIR)/SNMP-TARGET-MIB.bin

$(SNMP_BIN_TARGET_DIR)/SNMP-COMMUNITY-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/SNMP-FRAMEWORK-MIB.bin \
	$(SNMP_BIN_TARGET_DIR)/SNMP-TARGET-MIB.bin

$(SNMP_BIN_TARGET_DIR)/SNMP-USER-BASED-SM-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/SNMP-FRAMEWORK-MIB.bin

$(SNMP_BIN_TARGET_DIR)/SNMP-VIEW-BASED-ACM-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/SNMP-FRAMEWORK-MIB.bin

$(SNMP_BIN_TARGET_DIR)/SNMP-USM-AES-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/SNMP-FRAMEWORK-MIB.bin

$(SNMP_BIN_TARGET_DIR)/OTP-SNMPEA-MIB.bin: \
	$(SNMP_BIN_TARGET_DIR)/OTP-REG.bin

clean:
	rm -f $(TARGET_FILES)

docs:

conf:
	cd ..; $(MAKE) conf

info:
	@echo "MIBS_REFERENCE  = $(MIBS_REFERENCE)"
	@echo ""
	@echo "MIBS_OPTIONS    = $(MIBS_OPTIONS)"
	@echo ""
	@echo "MIBS_MC         = $(MIBS_MC)"
	@echo ""
	@echo "MIBS_AC         = $(MIBS_AC)"
	@echo ""
	@echo "SNMP_FLAGS      = $(SNMP_FLAGS)"
	@echo ""
	@echo "MIBS            = $(MIBS)"
	@echo ""
	@echo "BUILD_MIBS      = $(BUILD_MIBS)"
	@echo ""
	@echo "MIB_FILES       = $(MIB_FILES)"
	@echo ""
	@echo "BIN_TARGETS     = $(BIN_TARGETS)"
	@echo ""
	@echo "HRL_TARGETS     = $(HRL_TARGETS)"
	@echo ""
	@echo "TARGET_FILES = $(TARGET_FILES)"
	@echo ""
	@echo "OTP_MIBDIR   = $(OTP_MIBDIR)"
	@echo ""
	@echo "SNMP_VSN    = $(SNMP_VSN)"
	@echo "VSN         = $(VSN)"
	@echo "RELSYSDIR   = "$(RELSYSDIR)""

v1/%.mib.v1: %.mib $(ERL_TOP)/lib/snmp/bin/snmp-v2tov1
	$(gen_verbose)$(ERL_TOP)/lib/snmp/bin/snmp-v2tov1 -o $@ $<


# ----------------------------------------------------
# Release Target
# ---------------------------------------------------- 
include $(ERL_TOP)/make/otp_release_targets.mk

release_spec: opt
	$(INSTALL_DIR) "$(RELSYSDIR)/mibs"
	$(INSTALL_DIR) "$(RELSYSDIR)/mibs/v1"
	$(INSTALL_DATA) $(MIB_FILES) "$(RELSYSDIR)/mibs"
	$(INSTALL_DATA) $(STD_v2_MIB_FILES) "$(RELSYSDIR)/mibs"
	$(INSTALL_DATA) $(FUNCS_FILES) "$(RELSYSDIR)/mibs"
	$(INSTALL_DATA) $(STD_v1_MIB_FILES) "$(RELSYSDIR)/mibs/v1"
	$(INSTALL_DATA) $(V1_MIB_FILES) "$(RELSYSDIR)/mibs/v1"
	$(INSTALL_DIR) "$(RELSYSDIR)/include"
	$(INSTALL_DATA) $(HRL_FILES) "$(RELSYSDIR)/include"
	$(INSTALL_DIR) "$(RELSYSDIR)/priv/mibs"
	$(INSTALL_DATA) $(BIN_TARGETS) "$(RELSYSDIR)/priv/mibs"

release_docs_spec:

