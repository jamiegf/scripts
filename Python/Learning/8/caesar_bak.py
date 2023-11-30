alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

direction = input("Type 'encode' to encrypt, type 'decode' to decrypt:\n")
text = input("Type your message:\n").lower()
shift = int(input("Type the shift number:\n"))

#TODO-1: Create a function called 'encrypt' that takes the 'text' and 'shift' as inputs.
def encrypt (plain_text, shift_amount):
    encrypted_text = ""
    for letter in plain_text:
        position = alphabet.index(letter)
        shifted_position = position + shift_amount
        print (shifted_position)
        #print (alphabet[0])
        if shifted_position > 25:
            shifted_position -= 26
        encrypted_text += alphabet[shifted_position]
    print (encrypted_text) 

encrypt(plain_text=text, shift_amount=shift)  