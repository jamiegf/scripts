dim w, c, x
w = inputbox ("Input a word")
c = len(w)

do until c = 0  


x = mid(w,c,1)
y =   y & x

c = c-1
loop

if y = w then msgbox "Its a palindrome" : _ 
else msgbox "No not a pailindrome No"
