print ("Welcome to the love calculator <3")
name1 = input("What is your name?\n")
name2 = input("What is their name?\n")

lower_name1 = name1.lower()
lower_name2 = name2.lower()

first_digit = 0
second_digit = 0

first_digit += lower_name1.count("t") 
first_digit += lower_name1.count("r")
first_digit += lower_name1.count("u")
first_digit += lower_name1.count("e")
first_digit += lower_name2.count("t") 
first_digit += lower_name2.count("r")
first_digit += lower_name2.count("u")
first_digit += lower_name2.count("e")

second_digit += lower_name1.count("l")
second_digit += lower_name1.count("o")
second_digit += lower_name1.count("v")
second_digit += lower_name1.count("e")
second_digit += lower_name2.count("l")
second_digit += lower_name2.count("o")
second_digit += lower_name2.count("v")
second_digit += lower_name2.count("e")

str_first = str(first_digit)
str_second = str(second_digit)

percentage = (str_first + str_second)
int_percentage = int(percentage)

if int_percentage >= 40 and int_percentage <= 50:
    print (f"Your score is {percentage}, you are alright together")
elif int_percentage <= 10 or int_percentage >=90:
    print (f"Your score is {percentage}, you go together like coke and mentos!")
else:
    print (f"Your score is {percentage}")

