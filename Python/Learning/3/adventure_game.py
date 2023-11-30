print ('''
*******************************************************************************
          |                   |                  |                     |
 _________|________________.=""_;=.______________|_____________________|_______
|                   |  ,-"_,=""     `"=.|                  |
|___________________|__"=._o`"-._        `"=.______________|___________________
          |                `"=._o`"=._      _`"=._                     |
 _________|_____________________:=._o "=._."_.-="'"=.__________________|_______
|                   |    __.--" , ; `"=._o." ,-"""-._ ".   |
|___________________|_._"  ,. .` ` `` ,  `"-._"-._   ". '__|___________________
          |           |o`"=._` , "` `; .". ,  "-._"-._; ;              |
 _________|___________| ;`-.o`"=._; ." ` '`."\` . "-._ /_______________|_______
|                   | |o;    `"-.o`"=._``  '` " ,__.--o;   |
|___________________|_| ;     (#) `-.o `"=.`_.--"_o.-; ;___|___________________
____/______/______/___|o;._    "      `".o|o_.--"    ;o;____/______/______/____
/______/______/______/_"=._o--._        ; | ;        ; ;/______/______/______/_
____/______/______/______/__"=._o--._   ;o|o;     _._;o;____/______/______/____
/______/______/______/______/____"=._o._; | ;_.--"o.--"_/______/______/______/_
____/______/______/______/______/_____"=.o|o_.--""___/______/______/______/____
/______/______/______/______/______/______/______/______/______/______/______/
*******************************************************************************

''')
print ("Welcome to Treasure Island")
print ("Your mission is to find the treasure")
print ("")
print("")
decision1 = input("You're at a T junction, which way would you like to go?:type right or left\n").lower()
if decision1 == "right":
    print ("wrong way, you died!!!!, GAME OVER")
elif decision1 == "left":
    decision2 = input("You find a bay. Would you like to swim or wait for a boat? type wait or swim\n").lower()
    if decision2 == "swim":
        print ("You try to swim but are eaten by sharks. you died!!!, GAME OVER")
    elif decision2 == "wait":
        print ("Good choice, the boat turns up and you get to the island")
        decision3 = input("There are 3 doors infront of you. Pick either Red, Yellow or Blue\n").lower()
        if decision3 == "red":
            print("You go through the door and are attacked by killer bees. you died!!!, GAME OVER")
        elif decision3 == "blue":
            print("You go through the door but get attacked 4 grizzly bears. you died!!! GAME OVER")
        elif decision3 == "yellow":
            print('''
            You go through the door to find the treasure. Congratualtions!!!!!
          
                   ''')

