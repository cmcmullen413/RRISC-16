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

    # Open the output file and write the bin to it
    with open(outFileName, 'w') as file:
        file.writelines(hex)

# Takes the list of lines and returns a list of machine code in binary
def assemble(asm):
    # Comments and white space cleaning pass

    # Pseudo instructions pass

    # Labels pass

    # Assembly pass
    
    return

# Call the main function to run the whole program
# Has to be at the end because python is interpretted
main()