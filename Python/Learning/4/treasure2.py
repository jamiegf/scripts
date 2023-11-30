row1 = ["😀", "😀", "😀"]
row2 = ["😀", "😀", "😀"]
row3 = ["😀", "😀", "😀"]
map = [row1, row2, row3]

#print (f"{row1}\n{row2}\n{row3}")
# import random
# digit1 = random.randint(0,2)
# digit2 = random.randint(0,2)
coordinates = input("Enter a coordinate in 2 digits ")
str_digit1 = coordinates[0]
str_digit2 = coordinates[1]
horizontal = (int(str_digit1)-1)
vertical = (int(str_digit2)-1)
#print (f"1 = {digit1} and 2 = {digit2}")

if vertical == 0:
    row1[horizontal] = "X"
if vertical == 1:
    row2[horizontal] = "X"
if vertical == 2:
    row3[horizontal] = "X"


print (f"{row1}\n{row2}\n{row3}")