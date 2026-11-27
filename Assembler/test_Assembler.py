import pytest
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

# R-Type Tests

# I-Type Tests

# S-Type Tests

# SB-Type Tests

# U-Type Tests

# UJ-Type Tests

# Multi-Line Tests
