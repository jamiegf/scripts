print ("Welcome to the tip calculator")
print ("*****************************")
bill = input ("What was the total bill?\n")
tip = input ("What percentage tip would you like to add?\n")
people = input ("How many people want to split the bill?\n")
total_bill = (float(bill) * (int(tip) / 100) + float(bill))
#total_bill = round(float(bill) * (int(tip) / 100) + float(bill),2)
#print (total_bill)

#instead of:
#shared_bill = round(total_bill / int(people),2)
shared_bill = "{:.2f}".format(total_bill / int(people))
print (f"Each must pay £{shared_bill}")


