from art import logo
alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
print (logo)
exit = False
while exit == False:
    direction = input("Type 'encode' to encrypt, type 'decode' to decrypt:\n")
    text = input("Type your message:\n").lower()
    shift = int(input("Type the shift number:\n"))



    def encrypt (shift_direction, plain_text, shift_amount):
        encrypted_text = ""
        for letter in plain_text:
            if letter not in alphabet:
                encrypted_text += letter
            else:
                position = alphabet.index(letter)
                if shift_direction == "encode":
                    shifted_position = position + shift_amount
                    if shifted_position > 25:
                        shifted_position = shifted_position % 26
                    encrypted_text += alphabet[shifted_position]
                elif shift_direction == "decode":
                    shifted_position = position - shift_amount
                    if shifted_position < 0:
                        shifted_position = shifted_position % 26
                    encrypted_text += alphabet[shifted_position]
        print (f"The {shift_direction}d text is: {encrypted_text}") 

    encrypt(shift_direction=direction, plain_text=text, shift_amount=shift)  

    repeat = input("Would you like to go again, type: yes or no").lower()
    if repeat == "no":
        exit = True
       