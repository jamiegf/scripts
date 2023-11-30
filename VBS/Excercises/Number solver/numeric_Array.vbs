Dim num(3), tmp, i

num(0) = inputbox ("your first number please")
num(1) = inputbox ("your first number please")
num(2) = inputbox ("your first number please")
num(3) = inputbox ("your first number please")



i =  0

do until i = 3
if num(i) < num(i+1) then
tmp = num(i)
num(i) = num(i+1)
num(i+1)  = tmp
end if

i = i + 1
loop

j =  0

do until j = 3
if num(j) < num(j+1) then
tmp = num(j)
num(j) = num(j+1)
num(j+1)  = tmp
end if

j = j + 1
loop

k =  0

do until k = 3
if num(k) < num(k+1) then
tmp = num(i)
num(k) = num(k+1)
num(k+1)  = tmp
end if

k = k + 1
loop

l =  0

do until l = 3
if num(l) < num(l+1) then
tmp = num(l)
num(l) = num(l+1)
num(l+1)  = tmp
end if

l = l + 1
loop





msgbox ("Ascending order = " & num(0)& " " & num(1) & " " & num(2) &" "  & num(3))



