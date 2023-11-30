n = int(input("Check this number\n"))
def prime_checker(number):
    isprime = True
    counter = number -1
    while counter > 2:
        if number % counter == 0:
            isprime = False
        counter -= 1
    if isprime:
        print(f"{number} is a prime number")
    else:
        print(f"{number} is not a prime number")

prime_checker(number=n)
