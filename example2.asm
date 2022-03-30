// This is a comment
:START 				// Labels start with a ':' and are limited to 31 chars
LDV 0xFF1
LDC 0x2
STV 0x3
0x0 0x1
0000 7
0010 8
LDV 42
0001 23			// Load value from defined storage (last line)
NOT 
# this is also a comment
STV 0x00
JMP START       	// Jump to label, the compiler will set the address
0xFF1 0x0FFFFFFF	// Define storage by just providing an address and the value
