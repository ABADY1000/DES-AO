# Read maps file
with open("maps.txt") as file:
    maps_perms = dict()
    maps_in_size = dict()
    current_key = None
    for line in file:
        if line[0] == '*':
            current_key, in_size = line[1:].split()
            maps_perms[current_key] = list()
            maps_in_size[current_key] = int(in_size)
        else:
            for number in line.split():
                # Subtract one because index in verilog starts at 0
                maps_perms[current_key].append(int(number)-1)
in_variable = "dataIn"
out_variable = "dataOut"
# Generate verilog code
with open("maps.v",'w') as file:
    for map_name in maps_perms.keys():
        file.write("module {}(input [0:{:d}] {}, output [0:{:d}] {});\n".format(
            map_name,
            maps_in_size[map_name]-1,
            in_variable,len(maps_perms[map_name])-1,
            out_variable))
        for i,number in enumerate(maps_perms[map_name]):
            file.write("    assign {}[{:2}] = {}[{:2}];\n".format(
                out_variable,i,in_variable,number))
        file.write("endmodule\n")