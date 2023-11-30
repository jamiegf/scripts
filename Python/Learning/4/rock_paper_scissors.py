rock = '''
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)
'''

paper = '''
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)
'''

scissors = '''
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)
'''

#Write your code below this line 👇
import random
hand_signals = [rock, paper, scissors]
signals = [ "rock", "paper", "scissors"]

int_player_choice = (int(input("What do you choose? Type 1 for Rock, 2 for Paper or 3 for Scissors\n"))-1)
if int_player_choice < 0 or int_player_choice > 2:
    print ("wrong value entered, you lose!") 
else: 
    #int_player_choice = (int(player_choice)-1)
    #print (int_player_choice)
    #print (signals[int_player_choice])
    print (f"Your choice is: {signals[int_player_choice]}")
    print (hand_signals[int_player_choice])

    #computer
    int_computer_choice = random.randint(0,2)
    print (f"Computer choice is: {signals[int_computer_choice]} ")
    print (hand_signals[int_computer_choice])

    #results
    if signals[int_player_choice] == signals[int_computer_choice]:
        print("Draw Game")
    if signals[int_player_choice] == "rock" and  signals[int_computer_choice] == "paper":
        print ("You lose!")
    if signals[int_player_choice] == "rock" and  signals[int_computer_choice] == "scissors":
        print ("You win!!!")
    if signals[int_player_choice] == "paper" and  signals[int_computer_choice] == "scissors":
        print ("You lose!")
    if signals[int_player_choice] == "paper" and  signals[int_computer_choice] == "rock":
        print ("You win!!!")
    if signals[int_player_choice] == "scissors" and  signals[int_computer_choice] == "rock":
        print ("You lose!")
    if signals[int_player_choice] == "scissors" and  signals[int_computer_choice] == "paper":
        print ("You win!!!")


