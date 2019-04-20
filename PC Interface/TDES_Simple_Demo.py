# This simple demo illustrates the working of the implemented TDES module on FPGA
# We use the documented example from NIST

# Variables
port = "COM5"
baudrate = 9600
# All literals below are in hexadecimal
keys = ["0123456789ABCDEF","23456789ABCDEF01","456789ABCDEF0123"]
text= "54686520717566636B2062726F776E20666F78206A756D70"
datalength = "000018"

from serial import Serial
ser = Serial(port, baudrate)

def split_string(s,n):
    return [s[i:i + n] for i in range(0, len(s), n)]

# Send command
input("Send encrypt command 'E'\n")
ser.write("E".encode())
# Send data length
input("Send data length '{}'\n".format(datalength))
ser.write(bytes.fromhex(datalength))
# Send keys
for i,key in enumerate(keys):
    input("Send key{} '{}'".format(i+1,key))
    ser.write(bytes.fromhex(key))
# Send text
for i,block in enumerate(split_string(text,16)):
    input("Send text block{} '{}'".format(i+1,block))
    ser.write(bytes.fromhex(block))

# Read cipher text
input("Read resulting cipher text")
cipher_text = ser.read(24).hex()
print("Cipher text: {}".format(cipher_text))

# Send command
input("Send decrypt command 'D'\n")
ser.write("D".encode())
# Send data length
input("Send data length '{}'\n".format(datalength))
ser.write(bytes.fromhex(datalength))
# Send keys
for i,key in enumerate(keys):
    input("Send key{} '{}'".format(i+1,key))
    ser.write(bytes.fromhex(key))
# Send cipher text
for i,block in enumerate(split_string(cipher_text,16)):
    input("Send cipher text block{} '{}'".format(i+1,block))
    ser.write(bytes.fromhex(block))

input("Read resulting decrypted text")
decrypted_text = ser.read(24).hex()
print("Decrypted text: {}".format(decrypted_text))

# Stupid celebration
import time
time.sleep(1)
with open("celebratory_text.txt") as file:
    for line in file:
        time.sleep(0.2)
        print(line)