import random
print ("Heads or Tails")

coin_flip = random.randint(1,2)
if coin_flip == 1:
    coinup = "heads"
elif coin_flip == 2:
    coinup = "tails"

print (coinup)