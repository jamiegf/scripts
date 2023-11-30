import random
#names = input ("What are the first names of the people?")
names_string = "jamie, kate, katie, billy"

#separate the names into the list
names = names_string.split(", ")


###########################################################

number_of_names = len(names)
print (number_of_names)
print (f"Names in the hat are: {names}")
#select a random user
random_name = random.randint(0,number_of_names - 1)
print (names[random_name])

# ###################### theres also a function to do everything above (from the #############)
# random_name = random.choice(names)
# print (random_name)
