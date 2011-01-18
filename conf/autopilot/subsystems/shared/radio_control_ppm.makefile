#
# Makefile for shared radio_control ppm susbsytem
#

NORADIO = False

ifeq ($(BOARD),classix)
  ifeq ($(TARGET),ap)
    NORADIO = True
  endif
endif

ifeq ($(NORADIO), False)
  $(TARGET).CFLAGS	+= -DRADIO_CONTROL
  ifdef RADIO_CONTROL_LED
    ap.CFLAGS += -DRADIO_CONTROL_LED=$(RADIO_CONTROL_LED)
  endif
  $(TARGET).CFLAGS 	+= -DRADIO_CONTROL_TYPE_H=\"subsystems/radio_control/ppm.h\"
  $(TARGET).CFLAGS 	+= -DRADIO_CONTROL_TYPE_PPM
  $(TARGET).srcs	+= $(SRC_SUBSYSTEMS)/radio_control.c
  $(TARGET).srcs	+= $(SRC_SUBSYSTEMS)/radio_control/ppm.c
  ifneq ($(ARCH),jsbsim)
    $(TARGET).srcs 	+= $(SRC_ARCH)/subsystems/radio_control/ppm_arch.c
  endif
  ifeq ($(ARCH),stm32)
    ap.CFLAGS += -DUSE_TIM2_IRQ
  endif
endif