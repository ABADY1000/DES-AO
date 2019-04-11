name = "PipelinedRounds"
round = "Round"
register = "Register"

with open("{}.v".format(name),"w") as file:
    # Generate needed wires
    for i in range(1,17):
        file.write("    wire [0:31] leftIn{0}, rightIn{0},leftOut{0}, rightOut{0};\n".format(i))
    file.write("    wire [0:63] roundsOut;\n")
    # Generate round and pipeline register pairs
    for i in range(1,17):
        if i!= 0 and i != 17:
            file.write("    {} RND{}(\n".format(round,i));
            file.write("        .leftIn(leftIn{}),\n".format(i))
            file.write("        .rightIn(rightIn{}),\n".format(i))
            file.write("        .key(ck{}),\n".format(i))
            file.write("        .leftOut(leftOut{}),\n".format(i))
            file.write("        .rightOut(rightOut{})\n".format(i))
            file.write("    );\n")
        file.write("    {} REG{}(\n".format(register,i))
        file.write("        .clk(clk),\n")
        file.write("        .reset(reset),\n")
        if i==16:
            file.write("        .dataIn({{leftOut{0},rightOut{0}}}),\n".format(i))
        else:
            # Switch
            file.write("        .dataIn({{rightOut{0},leftOut{0}}}),\n".format(i))
        if i==16:
            file.write("        .dataOut(roundsOut)\n")
        else:
            file.write("        .dataOut({{leftIn{0},rightIn{0}}})\n".format(i + 1))
        file.write("    );\n")