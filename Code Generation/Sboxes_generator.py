from itertools import product
from collections import namedtuple


mapping_guid = namedtuple("mapping_guid", ["keys", "name"])

def generator(wire_in_name, wire_out_name, mat, name, size):
    space_counter = 0
    space = "    "

    string = ""

    string += f"{space * space_counter}module {name}(" \
        f"input [0:{size-1}] {wire_in_name}," \
        f"output reg [0:3] {wire_out_name}" \
        f");\n"
    space_counter += 1

    string += f"{space * space_counter}always @(*) begin\n"
    space_counter += 1

    string += f"{space * space_counter}case({{{wire_in_name}[0], {wire_in_name}[{size-1}]}})\n"

    for two_bits in product([0, 1], [0, 1]):
        space_counter += 1

        string += space * space_counter
        two_bits_string = "".join([str(y) for y in two_bits])
        string += f"2'b{two_bits_string}:\n"

        space_counter += 1
        four_bits_index = ",".join([f"{wire_in_name}[{y}]" for y in range(1, size - 1)])
        string += f"{space*space_counter}case({{{four_bits_index}}}) \n"

        space_counter += 1
        array = product(*([0, 1] for _ in range(4)))

        for four_bits in array:
            four_bits_string = "".join([str(y) for y in four_bits])
            string += f'{space * space_counter}{size-2}\'b{four_bits_string}: '

            string += f"dataOut = {mat[int(two_bits_string,base=2)][int(four_bits_string,base=2)]};\n"

        space_counter -= 1
        string += f"{space * space_counter}endcase\n"
        space_counter -= 1
        space_counter -= 1
    string += f"{space * space_counter}endcase\n"

    space_counter -= 1

    string += f"{space * space_counter}end\n"

    space_counter -= 1

    string += f"{space * space_counter}endmodule"

    return string

def file_reader(path):
    file = open(path, 'r')
    data = []
    for _ in range(8):

        name = file.readline()[0:2]
        keys = []
        for _ in range(4):
            keys.append([int(x) for x in file.readline().split()])

        data.append(mapping_guid(keys, name))
    return data


datas = file_reader("SBoxes_data")

if __name__ == "__main__":
    for data in datas:
        print(generator("dataIn", "dataOut", data.keys, data.name, 6))