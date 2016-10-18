CC=fpc
MAINSOURCE=lab4
SOURCES=cGlobalHeader.pas uIO.pas cNNFunctions.pas $(MAINSOURCE).pas
OBJECTS=$(SOURCES:.pas=.o)
PPU=$(SOURCES:.pas=.ppu)
EXECUTABLE=$(MAINSOURCE)

all: 
	$(CC) $(SOURCES)
zip:
	zip $(EXECUTABLE).zip $(SOURCES) $(EXECUTABLE) Makefile
unzip:
	unzip $(EXECUTABLE).zip
clean:
	\rm $(OBJECTS) $(PPU) $(EXECUTABLE)
