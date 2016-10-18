.model tiny ;atmina modelis
.code       ;programma
.startup    ;ieejas punkts
	Org 100h
	Mov Ax, 5
	Mov Bx, -2
	IMul Bx
.exit 0     ;izejas punkts
end