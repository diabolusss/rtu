.model tiny ;atmina modelis
.code       ;programma
.startup    ;ieejas punkts
	Org 100h
	Mov Ax, 17
	Mov Bx, -3
	Cwd
	Idiv Bx
.exit 0     ;izejas punkts
end