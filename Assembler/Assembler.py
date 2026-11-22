import sys

# Function that assembles
def main():
    # Get the first command line argument (the file name to assemble)
    asmFileName = sys.argv[1]
    # Exit if the argument is missing
    if len(asmFileName) == 0:
        print("Assembly file argument missing")
        exit(1)
    # Exit if a file with the name does not exist
    try:
        # If it exists, read its contents
        with open(asmFileName) as file:
            assembly = file.read().split('\n')
    except FileNotFoundError:
        print("Assembly file not found")
        exit(1)

    # Get the second command line argument (the output file name)
    outFileName = sys.argv[2]
    # Exit if the argument is missing
    if len(outFileName) == 0:
        print("Output file argument missing")
        exit(1)

    bin = assemble(assembly)

    # TODO Make the output be in binary or hex

    # Open the output file and write the bin to it
    with open(outFileName, 'w') as file:
        file.writelines(bin)


# Dictionary containing the pseudo instructions and their expansion as regular instrutions
# TODO Currently empty because pseudo instructions aren't supported
pseudoInstrDict = dict()

# Takes the list of lines and returns a list of machine code in binary
def assemble(asm):
    # Comments and white space cleaning pass
    cleaned = cleaningPass(asm)
    # Pseudo instructions pass
    expanded = pseudoPass(cleaned, pseudoInstrDict)
    # Labels pass
    labelDict = dict()
    labeled = labelPass(expanded, labelDict)
    # Assembly pass
    assembly = assemblyPass(labeled, labelDict)
    # Return the binary
    return assembly


# Removes comments (Denoted by #, //, or ;) as well as extra white space
# Basically removes all the fluff and leaves a list of straight assembly (and labels)
def cleaningPass(assembly):
    # Create the list to add the cleaned lines too
    out = []

    # Loop through each line checking if it has a comment separator
    for line in assembly:
        # If the line does not contain a comment, move on to the next one
        if '#' not in line and '//' not in line and ';' not in line:
            out.append(line)
            continue
        # Replace every separator with ; and then split on that and append it to the output
        line = line.replace('#', ';').replace('//')
        out.append(line.split(';')[0].strip())

    # Return the cleaned lines
    return out

# Parses psuedo instruction into their regular instruction expansions
# TODO Currently does nothing because pseudo instruction aren't supported
def pseudoPass(assembly, pseudoDict):
    return assembly

# Parses out labels from the assembly, filling the dictionary with the line numbers as it goes
def labelPass(assembly, labelDict):
    # Create the list to add the lines without labels to
    out = []

    # Loop through each line checking for a label
    # Also keep a count of the line number
    lineNum = 0
    for line in assembly:
        # Increment the line number
        lineNum += 1
        # If the line doesn't contain a label (no :), add it to the output and move on
        if ':' not in line:
            out.append(line)
            continue
        # Split on the colon
        split = line.split(':')
        # If the size of the split is greater than 2, throw an error
        if len(split) > 2:
            print(f"Too many label separators (:) on assembly line {lineNum}")
            exit(1)
        # If the dict already contains the label, throw an error
        if split[0] in labelDict.keys:
            print(f"Duplicate label name: {split[0]} on assembly line {lineNum}")
            exit(1)
        # Otherwise
        # Add the label and its corrisponding line to the dictionary
        labelDict[split[0]] = lineNum
        # If the second part of the split is empty, the label is on its own line
        # To deal with this, decrement the line number before the next loop
        lineNum -= 1

    # Return the list with the labels removed
    # The labels and their line numbers will be added to the dictionary that was passed in
    return out

# Turns the instructions into their machine code counterparts
# Takes in the label dict to replace labels with immediates as it goes
def assemblyPass(assembly, labelDict):
    # Create to output list
    out = []

    # Loop through each line and assemble it
    lineNum = 0
    for line in assembly:
        # Track the line num for using labels
        lineNum += 1

        # Replace the commas with whitespace and split on whitespace
        line = line.replace(',', ' ').split()
        # Grab the instruction from the split
        instr = line[0]

        # Do cases depending on the instruction type and call the corresponding helper function
        ##########
        # R Type
        if instr in typeToInstrs['R']:
            # If the length of the split is not 4, the wrong number of args were passed for an R type
            if len(line) != 4:
                print(f"Wrong number of arguments ({len(line)-1}) given for {instr} instruction. Expected 3")
                exit(1)
            out.append(assembleRType(instr, line[1], line[2], line[3]))
        # I Type
        elif instr in typeToInstrs['I']:
            # If the length of the split is not 4, the wrong number of args were passed for an I type
            if len(line) != 4:
                print(f"Wrong number of arguments ({len(line)-1}) given for {instr} instruction. Expected 3")
                exit(1)
            out.append(assembleIType(instr, line[1], line[2], line[3]))
        # L (load) Type
        elif instr in typeToInstrs['L']:
            # If the length of the split is 4, it is in the form: lw rd, rs1, imm
            if len(line) == 4:
                out.append(assembleLType(instr, line[1], line[2], line[3]))
            # If the length of the split is 3, it is in the form lw rd, imm(rs1)
            elif len(line) == 3:
                baseOffset = parseBaseOffset(line[2])
                out.apped(assembleLType(instr, line[1], baseOffset[0], baseOffset[1]))
            # Otherwise, the wrong number of arguments were given, so throw an error
            else:
                print(f"Wrong number of arguments ({len(line)-1}) given for {instr} instruction. Expected 2 or 3")
                exit(1)
        # S Type
        elif instr in typeToInstrs['S']:
            # If the length of the split is 4, it is in the form: sw rd, rs1, imm
            if len(line) == 4:
                out.append(assembleSType(instr, line[1], line[2], line[3]))
            # If the length of the split is 3, it is in the form sw rd, imm(rs1)
            elif len(line) == 3:
                baseOffset = parseBaseOffset(line[2])
                out.apped(assembleSType(instr, line[1], baseOffset[0], baseOffset[1]))
            # Otherwise, the wrong number of arguments were given, so throw an error
            else:
                print(f"Wrong number of arguments ({len(line)-1}) given for {instr} instruction. Expected 2 or 3")
                exit(1)
        # SB Type
        elif instr in typeToInstrs['SB']:
            # If the length of the split is not 4, the wrong number of args were passed for a SB Type
            if len(line) != 4:
                print(f"Wrong number of arguments ({len(line)-1}) given for {instr} instruction. Expected 3")
                exit(1)
            out.append(assembleSBType(instr, line[1], line[2], line[3], labelDict, lineNum))
        # U Type
        elif instr in typeToInstrs['U']:
            # If the length of the split is not 3, the wrong number of args were passed for a U Type
            if len(line) != 3:
                print(f"Wrong number of arguments ({len(line)-1}) given for {instr} instruction. Expected 2")
                exit(1)
            out.append(assembleIType(instr, line[1], line[2]))
        # UJ Type
        elif instr in typeToInstrs['UJ']:
            # If the length of the split is not 3, the wrong number of args were passed for a UJ Type
            if len(line) != 3:
                print(f"Wrong number of arguments ({len(line)-1}) given for {instr} instruction. Expected 2")
                exit(1)
            out.append(assembleIType(instr, line[1], line[2]))
        else:
            # Instr is not a real instrustion
            print(f"Unknown instruction {instr}")
            exit(1)

    # Return the list of the assembled lines
    return out

###########
# Helper functions to assemble specific types
###########
def assembleRType(instr, rd, rs1, rs2):
    # Get the f2 and fr data for the instruction
    functData = instrToFunct[instr]
    # Get all the binary pieces
    f2Bin  = functData[0]
    frBin  = functData[1]
    padBin = "0"
    rs2Bin = getRegBin(rs2)
    rs1Bin = getRegBin(rs1)
    rdBin  = getRegBin(rd)
    opcode = typeToOpcode['R']
    # Return them as once string
    return f"{f2Bin}{frBin}{padBin}{rs2Bin}{rs1Bin}{rdBin}{opcode}"

def assembleIType(instr, rd, rs1, imm):
    # Get the f2 data for the instruction
    functData = instrToFunct[instr]
    # Get all the binary pieces
    f2Bin  = functData[0]
    immBin = getImmBin(imm, 5)
    rs1Bin = getRegBin(rs1)
    rdBin  = getRegBin(rd)
    opcode = typeToOpcode['I']
    # Return them as once string
    return f"{f2Bin}{immBin}{rs1Bin}{rdBin}{opcode}"

def assembleLType(instr, rd, rs1, imm):
    # Get all the binary pieces
    immBin = getImmBin(imm, 7)
    rs1Bin = getRegBin(rs1)
    rdBin  = getRegBin(rd)
    opcode = typeToOpcode[f'L-{instr}']
    return f"{immBin}{rs1Bin}{rdBin}{opcode}"

def assembleSType(instr, rs1, rs2, imm):
    # Get all the binary pieces
    immBin = getImmBin(imm, 7)
    rs2Bin = getRegBin(rs2)
    rs1Bin = getRegBin(rs1)
    opcode = typeToOpcode['S']
    return f"{immBin[:4]}{rs2Bin}{rs1Bin}{immBin[4:]}{opcode}"

def assembleSBType(instr, rs1, rs2, labelOrImm, labelDict, lineNum):
    # Get the f2 data for the instruction
    functData = instrToFunct[instr]
    # Parse the labelOrImm to an integer
    imm = parseLabelOrImm(labelOrImm, labelDict, lineNum)
    # Get all the binary pieces
    f2Bin  = functData[0]
    immBin = getImmBin(imm, 5)
    rs2Bin = getRegBin(rs2)
    rs1Bin = getRegBin(rs1)
    opcode = typeToOpcode['SB']
    return f"{f2Bin}{immBin[:2]}{rs2Bin}{rs1Bin}{immBin[2:]}{opcode}"

def assembleUType(instr, rd, imm):
    # Get all the binary pieces
    immBin = getImmBin(imm, 11)
    rdBin  = getRegBin(rd)
    # Throw an error if the first bit of the rd is a 0
    # lui only supports loading into the upper 4 registers by design
    if rdBin[0] != '1':
        print(f"Unsupported register ({rd}) for {instr} instruction. {instr} only loads to x4-x7")
        exit(1)
    opcode = typeToOpcode['U']
    return f"{imm}{rd[1:]}{opcode}"

def assembleUJType(instr, rd, label):
    # Parse the labelOrImm to an integer
    imm = parseLabelOrImm(labelOrImm, labelDict, lineNum)
    # Get all the binary pieces
    immBin = getImmBin(imm, 10)
    rdBin  = getRegBin(rd)
    opcode = typeToOpcode['SB']
    return f"{immBin}{rdBin}{opcode}"

# Parses base offset notation
# Takes "imm(reg)"" and returns ("reg", "imm")
def parseBaseOffset(arg):
    # Check if there is a '(' and ')'
    # If there isn't, throw an error for bad base offset argument
    # Also check that there is nothing after close paren
    if '(' not in arg or ')' not in arg or len(arg.split[')'][1]) != 0:
        print(f"Bad base-offset notation ({arg}) in argument. Expected the form imm(reg)")
        exit(1)

    # Split on the open paren
    split = arg.split('(')
    # The immediate is the first part
    imm = split[0]
    # The reg is the second part, with the close paren removed
    reg = split[1][:-1]
    return (imm, reg)

# Gets the binary form of a register
# Error handles for bad register input
def getRegBin(reg):
    # If the reg isn't in the keys for the reg dictionary, throw an error
    if reg not in regToBin.keys:
        print(f"Unrecognised register {reg}")
        exit(1)
    return regToBin[reg]

# Gets the binary form of an immediate
# Uses the built in string to integer casting so it can parse hex (0x), binary (0b), etc
# Error handles for immediates that won't fit within the passed in bit size (signed)
def getImmBin(imm, bits):
    # TODO
    return ""

# labelOrImm could have been passed it as either a label for an immediate
    #   since both beq x1, x2, -8 and beq x1, x2, LOOP are supported
    # First try to parse it as an immediate, then as a label

# When using a branch or jump instruction, both of the following formats are accepted
#   instr rs1, rs2, imm     and        instr rs1, rs2, label
# The helper function parses that third argument into an integer to be used as the immediate
def parseLabelOrImm(labelOrImm, labelDict, lineNum):
    # TODO
    return 0

# A dictionary from Type to instructions that are that type
typeToInstrs = {
    'R': ['add', 'sub', 'xor', 'or', 'and', 'sll', 'srl', 'sra'],
    'I': ['addi', 'slli', 'srli', 'srai'],
    'L': ['lw', 'jalr'],
    'S': ['sw'],
    'SB': ['beq', 'bne', 'blt', 'bge'],
    'U': ['lui'],
    'UJ': ['jal']
}

# A dictionary from Type to opcode
typeToOpcode = {
    'R': '000',
    'I': '001',
    'L-lw': '010',
    'S': '011',
    'U': '100',
    'SB': '101',
    'UJ': '110',
    'L-jalr': '111'
}

# A dictionary from instruction to f2 and fr data
# TODO Fill this out with data
instrToFunct = {
    # R Types
    'add'  : ("",""),
    'sub'  : ("",""),
    'xor'  : ("",""),
    'or'   : ("",""),
    'and'  : ("",""),
    'sll'  : ("",""),
    'srl'  : ("",""),
    'sra'  : ("",""),
    # I Types
    'addi' : (""),
    'slli' : (""),
    'srli' : (""),
    'srai' : (""),
    # SB Types
    'beq' : (""),
    'bne' : (""),
    'blt' : (""),
    'bge' : ("")
}

# A dictionary between register names and the binary string corrisponding to it
regToBin = {
    'x0': '000',
    'zero': '000',

    'x1': '001',
    'ra': '001',

    'x2': '010',
    'sp': '010',

    'x3': '011',
    'a0': '011',
    't0': '011',

    'x4': '100',
    'a1': '100',
    't1': '100',

    'x5': '101',
    'a2': '101',
    't2': '101',

    'x6': '110',
    's0': '110',

    'x7': '111',
    's1': '111',
}

# Call the main function to run the whole program
# Has to be at the end because python is interpretted
main()