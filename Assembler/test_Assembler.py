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

# Assembles and checks a assembly file vs an expected binary file
def assertFile(asmFile, binFile):
    # Read the files and extract list of their lines
    try:
        with open(asmFile) as file:
            asmList = file.readlines()
    except FileNotFoundError:
        print(f"File {asmFile} does not exist")
        exit(1)
    try:
        with open(binFile) as file:
            binList = file.readlines()
    except FileNotFoundError:
        print(f"File {binFile} does not exists")
        exit(1)

    # Now call the many line assert on those lists
    assertManyLines(asmList, binList)

####################
# Tests
####################

