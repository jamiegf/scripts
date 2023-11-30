print ("Welcome to Python Pizza deliveries")
bill = 0
size = input("What size Pizza would you like? S, M, L")
add_pepperoni = input ("Do you want pepperoni? Y or N")
extra_cheese = input ("Do you want extra cheese? Y or N")
print (bill)
if size == "S" or size == "s":
    bill += 15
    if add_pepperoni == "Y" or add_pepperoni == "y":
        bill += 2

if size == "M" or size =="m":
    bill += 20
    if add_pepperoni == "Y" or add_pepperoni == "y":
        bill += 3
        
if size == "L" or size == "l":
    bill += 25
    if add_pepperoni == "Y" or add_pepperoni == "y":
        bill += 3

print (bill)

if extra_cheese == "Y"  or extra_cheese == "y":
    bill += 1
print (extra_cheese)
print (f"Thank you for you order. Your bill is {bill}")

   