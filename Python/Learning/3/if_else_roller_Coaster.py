print ("Welcome to the rollercoaster")
height = int(input("What is your height in cm?\n"))
bill = 0
if height >= 120:
    print("You can ride the rollercoaster")
    age = int(input("What is your age?"))
    if age <= 12:
        bill = 5
        print ("Please pay £5")
    elif age <=17:
        bill = 7
        print ("Please pay £7")
    elif age >=45 and age <=55:
        print ("Mid life crisis freebie")
    else:
        bill = 10
        print ("Please pay £10")
    photo = input("Do you want a photo for £3?, click Y or N:\n")
    if photo == "Y":
        bill += 3
    print (f"Please pay £{bill}")
else:
    print("Sorry, you have to grow taller before you can ride")

#  use == for if statements (same as -eq)
#!=  is not equal to . 