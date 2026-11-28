from Assembler import assemble

####################
# Helper Functions
####################

# Assembles and checks a single line
def assertSingleLine(asm, bin):
    # Place the asm line and bin line into lists
    asmList = [asm]
    binList = [bin]
    # Now call the assertManyLines function to check those lists
    assertManyLines(asmList, binList)

# Assembles and checks a whole list of lines
def assertManyLines(asmList, binList):
    # Assembled it into a list of binary
    assembledBin = assemble(asmList)

    # Assert the length is what is expected
    assert len(assembledBin) == len(binList)
    # Assert each line is what is expected
    for x in range(len(binList)):
        assert binList[x] == assembledBin[x]

####################
# Tests
####################

# Error Catching Tests
####################

# R-Type Tests
####################
# One test for each operation, varying registers
#
# add x0, x1, x2 -> 00 0 0 010 001 000 000
def test_add():
    assertSingleLine("add x0, x1, x2", "0000010001000000")
# sll x3, x4, x5 -> 01 0 0 101 100 011 000
def test_sll():
    assertSingleLine("sll x3, x4, x5", "0100101100011000")
# srl x6, x7, x0 -> 10 0 0 000 111 110 000
def test_srl():
    assertSingleLine("srl x6, x7, x0", "1000000111110000")
# sra x1, x2, x3 -> 11 0 0 011 010 001 000
def test_sra():
    assertSingleLine("sra x1, x2, x3", "1100011010001000")
# sub x4, x5, x6 -> 00 1 0 110 101 100 000
def test_sub():
    assertSingleLine("sub x4, x5, x6", "0010110101100000")
# xor x7, x0, x1 -> 01 1 0 001 000 111 000
def test_xor():
    assertSingleLine("xor x7, x0, x1", "0110001000111000")
# or  x2, x3, x4 -> 10 1 0 100 011 010 000
def test_or():
    assertSingleLine("or x2, x3, x4",  "1010100011010000")
# and x5, x6, x7 -> 11 1 0 111 110 101 000
def test_and():
    assertSingleLine("and x5, x6, x7", "1110111110101000")

# I-Type Tests
####################

# S-Type Tests
####################

# SB-Type Tests
####################

# U-Type Tests
####################

# UJ-Type Tests
####################

# Multi-Line Tests
####################
