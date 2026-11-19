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
            continue
        # Replace every separator with ; and then split on that and append it to the output
        line = line.replace('#', ';').replace('//')
        out.append(line.split(';')[0].clean())

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

    # Loop through each line checking fo

    # Return the list with the labels removed
    # The labels and their line numbers will be added to the dictionary that was passed in
    return

# Turns the instructions into their machine code counterparts
# Takes in the label dict to replace labels with immediates as it goes
def assemblyPass(assembly, labelDict):
    # TODO
    return


# Call the main function to run the whole program
# Has to be at the end because python is interpretted
main()