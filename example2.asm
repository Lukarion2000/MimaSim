// This is a comment
LDV 0xFF1
LDC 0x2
STV 0x3
0x0 0x1
RRN 2
DJN 1
0000 7
0010 8
LDV 42
0001 23			// Load value from defined storage (last line)
NOT
DJN 5 
# this is also a comment
STV 0x00
0xFF1 0x0FFFFFFF	// Define storage by just providing an address and the value
HLT
