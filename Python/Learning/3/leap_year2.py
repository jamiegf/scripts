print ("Leap years")
year = int(input("Enter your year to check\n"))

if year % 4 == 0:
    print ("Might be a leap year")
    if year % 100 != 0:
        print (f"{year} is a leap year")
    else:
        if year % 400 == 0:
            print (f"{year} is a leap year")
        else:
            print (f"{year} is not a leap year")
else:
    print (f"{year} is not a leap year")