student_scores = {
    "Harry":81,
    "Ron": 78,
    "Hermone":99,
    "Draco": 74,
    "Neville": 62,
}

student_grades = {}

for student in student_scores:
    print ("")
    print (student)
    #print (student_scores[student])
    if student_scores[student] > 90:
        #print (f"Grade = Outstanding")
        student_grades[student] = "Grade = Outstanding"
    elif student_scores[student] > 80:
        #print (f"Grade = Exceeds expectation")
        student_grades[student] = "Grade = Exceeds expectation"
    elif student_scores[student] > 70:
        #print (f"Grade = Acceptable")
        student_grades[student] = "Grade = Acceptable"
    else:
        #print (f"Grade = Fail")
        student_grades[student] = "Grade = Fail"
print (student_grades)







