print ("BMI Calculator")
weight = float(input ("Please enter your weight in kg\n"))
height = float (input ("Please enter your height in cm\n"))

# round ( sum, 1 )   = where ,1 is decimal places
bmi =  round(weight  /  (height * 0.01) ** 2,1)
#print (bmi)
print (f"Your BMI is : {bmi}")
if bmi < 18.5:
    print("You are underweight!! eat something quick!!!!")
elif bmi < 25:
    print("You are doing good! youre healthy :)") 
elif bmi < 30:
    print ("You're slightly overweight")
elif bmi < 35:
    print ("Youre obese you fat chunker")
else:
    print ("You are clinically obese. Theres no hope for you left")
