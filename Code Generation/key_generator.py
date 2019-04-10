module_name ="KeyGeneration"
shift_table = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]
keyround_name = "KeyRound"
parity_drop_name = "ParityBitDropTable"

with open("{}.v".format(module_name),"w") as file:
    # Generate header and IO ports
    file.write("module {}(\n    input [63:0] key,\n".format(module_name))
    for i in range(1,17):
        file.write("    output [47:0] k{}{}\n".format(i,',' if i != 16 else ''))
    file.write("    );\n")
    # Generate needed wires
    for i in range(1,17):
        file.write("    wire [25:0] left{}, right{};\n".format(i,i))
    # Do initial parity drop permutation
    file.write("    {} PBDT(key,{{left1,right1}});\n".format(parity_drop_name))
    # Generate keys for all rounds using the key round module
    for i in range(1,17):
        file.write("    {} #({}) KR{}(\n".format(
            keyround_name,shift_table[i-1],i))
        file.write("        .leftIn(left{}),\n".format(i))
        file.write("        .rightIn(right{}),\n".format(i))
        if i != 16:
            file.write("        .leftOut(left{}),\n".format(i+1))
            file.write("        .rightOut(right{}),\n".format(i+1))
        else:
            file.write("        .leftOut(26'dz),\n")
            file.write("        .rightOut(26'dz),\n")
        file.write("        .key(k{})\n".format(i))
        file.write("    );\n")
    file.write("endmodule\n")