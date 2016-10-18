.model tiny ;atmina modelis
.code       ;programma
.startup    ;ieejas punkts
	ORG 100h
	Jmp short start
	Hello DB "Hello, world!", '$'
start:
	Lea Dx, Hello
	Mov Ah, 9H
	Int 21h
	Mov Ah, 1
	Int 21h
.exit 0     ;izejas punkts
end