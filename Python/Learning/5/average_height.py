student_heights = input("Input a list of student heights ").split()  # input this: 156 178 165 171 187
#student_heights = ["156", "178", "165", "171", "187"]
student_height_sum = 0
counter = 0
for student_height in student_heights:
    print (student_height)
    student_height_sum += int(student_height)
    counter += 1
average = round((student_height_sum / counter),1)
print (f"Average height = {average}")
    

