#student_heights = input("Input a list of student heights ").split()  # input this: 156 178 165 171 187
student_scores = ["156", "178", "165", "171", "187"]
for n in range(0, len(student_scores)):
    student_scores[n] = int (student_scores[n])
max_score = 0

for student_score in student_scores:
    print (student_score)
    if max_score <= student_score:
        max_score = student_score 
    
print (f"Max Score = {max_score}")