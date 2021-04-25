# DroidCam & DroidCamX (C) 2010-2021
# https://github.com/dev47apps
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# Use at your own risk. See README file for more details.

JPEG_DIR ?= /opt/libjpeg-turbo
JPEG_INCLUDE ?= $(JPEG_DIR)/include
JPEG_LIB ?= $(JPEG_DIR)/lib`getconf LONG_BIT`

CXX   = g++
CXXFLAGS = -std=c++11 -Wall -fPIC -no-pie
GTK   = `pkg-config --libs --cflags gtk+-3.0` `pkg-config --libs x11`
#GTK  += `pkg-config --cflags --libs appindicator3-0.1`
LIBAV = `pkg-config --libs --cflags libswscale libavutil`
LIBS  =  -lspeex -lasound -lpthread -lm
JPEG  = -I$(JPEG_INCLUDE) $(JPEG_LIB)/libturbojpeg.a
SRC   = src/connection.c src/settings.c src/decoder*.c src/av.c src/usb.c
USBMUXD = -lusbmuxd

all: droidcam-cli droidcam

ifneq "$(RELEASE)" ""
LIBAV = /usr/lib/x86_64-linux-gnu/libswscale.a /usr/lib/x86_64-linux-gnu/libavutil.a
SRC  += src/libusbmuxd.a src/libxml2.a src/libplist-2.0.a
package: clean all
	zip "droidcam_$(RELEASE).zip" \
		LICENSE README* icon2.png  \
		droidcam* install* uninstall* \
		v4l2loopback/*

else
LIBS += $(USBMUXD)
endif

gresource: .gresource.xml icon2.png
	glib-compile-resources .gresource.xml --generate-source --target=src/resources.c

droidcam-cli: LDLIBS += $(JPEG) $(LIBAV) $(LIBS)
droidcam-cli: src/droidcam-cli.c $(SRC)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

droidcam: LDLIBS += $(GTK) $(JPEG) $(LIBAV) $(LIBS)
droidcam: src/droidcam.c src/resources.c $(SRC)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	rm -f droidcam
	rm -f droidcam-cli
	make -C v4l2loopback clean
