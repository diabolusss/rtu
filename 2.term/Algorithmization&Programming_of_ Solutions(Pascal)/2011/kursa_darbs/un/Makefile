CC=fpc
MAINSOURCE=base
SOURCES=myunit.pas $(MAINSOURCE).pas
OBJECTS=$(SOURCES:.pas=.o)
PPU=$(SOURCES:.pas=.ppu)
EXECUTABLE=$(MAINSOURCE)

all: 
	$(CC) $(SOURCES)
		./$(EXECUTABLE)
zip:
	zip $(EXECUTABLE).zip $(SOURCES) $(EXECUTABLE) Makefile
unzip:
	unzip $(EXECUTABLE).zip
clean:
	\rm $(OBJECTS) $(PPU) $(EXECUTABLE)
