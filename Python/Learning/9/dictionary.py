# data:value
programming_dictionary = {
    "Bug": "An error in a program that prevents the program from running as expected.",
    "Function": "A piece of code that you can easily call over and over again.",
    "Loop": "The action of doing something over and over again"
}

print (programming_dictionary["Bug"])

#adding a field
programming_dictionary["Hello"] = "example text here"

print (programming_dictionary)

#clear an existing dictionary or create an empty dictionary
#programming_dictionary = {}

#edit an existing entry
#programming_dictionary["Bug"] = "new value, write it here"
for i in programming_dictionary:
    print(i)

#print (programming_dictionary)