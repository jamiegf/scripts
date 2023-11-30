dim xarr(4),x,y,tmp
xarr(0) = cint(inputbox ("Input 1st number"))
xarr(1) = cint(inputbox ("Input 2nd number"))
xarr(2) = cint(inputbox ("Input 3rd number"))
xarr(3) = cint(inputbox ("Input 4th number"))


while xarr(0)>xarr(1) or xarr(1)>xarr(2) or xarr(2)>xarr(3) 
for x=0 to 2
                for y=x+1 to 3
        if xarr(x)>xarr(y) then
                    tmp = xarr(x)
                    xarr(x) = xarr(y)
                    xarr(y) = tmp
        end if
                next
    'msgbox xArr(0) & " " & xArr(1) & " " & xArr(2) & " " & xArr(3)
next
wend

x=0
do while x<4    
msgbox xarr(x)    
x=x+1
loop
