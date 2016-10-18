CC=ucfront-gcc arm-linux-gcc
LD=ucfront-gcc arm-linux-gcc

CFLAGS=-msoft-float -D__PIC__ -fpic -msingle-pic-base -Dlinux -D__linux__ -Dunix -D__uClinux__

LDFLAGS=-Wl,--fatal-warnings -Wl,-elf2flt -msoft-float -L/home/edo/opt/arm/uClinux-dist-lpc_2478_stk/uClibc/lib

SOURCES=helloworld.c

OBJECTS=$(SOURCES:.c=.o)

TARGET=helloworld

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
