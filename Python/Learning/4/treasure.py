row1 = ["😀", "😀", "😀"]
row2 = ["😀", "😀", "😀"]
row3 = ["😀", "😀", "😀"]
map = [row1, row2, row3]

#print (f"{row1}\n{row2}\n{row3}")
import random
digit1 = random.randint(0,2)
digit2 = random.randint(0,2)

if digit1 == 0:
    row1[digit2] = "X"
if digit1 == 1:
    row2[digit2] = "X"
if digit1 == 2:
    row3[digit2] = "X"


print (f"{row1}\n{row2}\n{row3}")