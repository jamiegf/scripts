amount = int(input("Enter amount"))
years = int(input("Enter years"))
percentage = float(input("Enter percentage"))
counter = 1
while counter <= years:
    interest = (amount * percentage) / 100
    amount += interest
    amount = round (amount,2)
    print (f"After {counter} years: {amount}")
    counter += 1


    