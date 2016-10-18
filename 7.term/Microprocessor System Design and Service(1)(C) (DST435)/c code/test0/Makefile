CC=arm-linux-gnueabi-gcc
LD=/media/DATA/downloads/buildroot-2013.02_rc3/output/host/usr/bin/ldconfig

CFLAGS=-msoft-float -D__PIC__ -fpic -msingle-pic-base -Dlinux -D__linux__ -Dunix -D__uClinux__

LDFLAGS=-Wl, -elf2flt


SOURCES=hello.c

OBJECTS=$(SOURCES:.c=.o)

TARGET=hello

.PHONY=all
all: $(TARGET)

%.o : %.c
	$(CC) $(CFLAGS) -c $< 

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS) -lc

.PHONY=clean
clean:
	\rm -f *.o
	\rm -f *~
