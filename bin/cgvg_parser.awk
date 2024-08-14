BEGIN {
	FS = ":"
	OFS = ":"
	m[0] = "a"
	m[1] = "b"
	m[2] = "c"
	m[3] = "d"
	m[4] = "e"
	m[5] = "f"
	m[6] = "g"
	m[7] = "h"
	m[8] = "i"
	m[9] = "j"
}

{
	text = $0
	nr = encode(NR)
	redbg(sprintf("%3s", nr))  # index number
	gray($1)                   # file name field
	space()
	green($2)                  # line number
	space()
	$1 = ""
	$2 = ""
	$3 = ""
	gsub(/:::/, "", $0)
	print trim($text)          # matched line text
}


function br()
{
	printf "\n"
}

function encode(str)
{
	code = ""
	for (i = 1; i <= length(str); i++) {
		char = substr(str, i, 1)
		code = code m[char]
	}
	return code
}

function gray(str)
{
	printf "%s", "\033[1;30m" str "\033[0m"
}

function green(str)
{
	printf "%s", "\033[1;32m" str "\033[0m "
}

function redbg(str)
{
	printf "%s", "\033[1;41m" str "\033[0m "
}

function space()
{
	printf "%s", " "
}

function trim(s)
{
	gsub(/^[ \t\r\n-]+|[ \t\r\n-]+$/, "", s)
	return s
}

function yellow(str)
{
	printf "%s", "\033[1;33m" str "\033[0m"
}
