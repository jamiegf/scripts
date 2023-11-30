import random
from hangman_art import stages, logo
from hangman_words import word_list
import os



#word_list = ["ardvark", "baboon", "camel"]
lives = 6
end_game = False
chosen_word = random.choice(word_list)

#print (f"debug mode, word is : {chosen_word}")
#    display.append("_")
word_length = len(chosen_word)
print (word_length)
display = []
#print(type(display))

for chars in range(word_length):
    display += "_"

correct_letters = 0
print (logo)
while end_game == False:
    
    guess = input("Guess a letter: ").lower()
    os.system('cls')
    counter = 0
    loselife = True
    for char in chosen_word:
        if char == guess:
            display[counter] = char
            loselife = False
        
        counter += 1

    if loselife == True:
            lives -= 1
            print (f"{guess} is not in the word, one life lost")

    print (logo)
    print (display)  
    print (f"lives = {lives}") 
    print (stages [lives])

    if "_" not in display:
        end_game = True
        print ("You win!")
    elif lives <= 0:
        end_game = True
        print (f"You lose!, the word was {chosen_word}")

    
  
 
    

