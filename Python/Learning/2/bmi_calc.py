print ("BMI Calculator")
weight = float(input ("Please enter your weight in KGs\n"))
height = float (input ("Please enter your height in CMs\n"))

# round ( sum, 1 )   = where ,1 is decimal places
bmi =  round(weight  /  (height * 0.01) ** 2,1)
str_bmi = str(bmi)
print ("Your BMI is : " + str_bmi )