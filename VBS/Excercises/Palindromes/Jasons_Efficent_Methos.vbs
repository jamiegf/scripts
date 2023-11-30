dim x,y,w,isPal
w = inputbox ("Input a word")

x=1
y=len(w)
isPal = true
do while isPal = true and x < y
                if mid(w,x,1) <> mid(w,y,1) then                      
            ispal= false
        end if
x=x+1
y=y-1
loop
if ispal=true then msgbox "Its a palindrome" : _ 
else msgbox "No not a pailindrome No"
