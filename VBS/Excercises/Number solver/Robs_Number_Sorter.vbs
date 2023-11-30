dim xarr(4),x,y,swap
xarr(0) = cint(inputbox ("Input 3rd number"))
xarr(1) = cint(inputbox ("Input 3rd number"))
xarr(2) = cint(inputbox ("Input 3rd number"))
xarr(3) = cint(inputbox ("Input 3rd number"))

x=0
swap=false
do 
                swap = false
                for x=0 to ubound(xarr)-2
                                if xarr(x) >= xarr(x+1) then
                                                tmp = xarr(x)
                                xarr(x) = xarr(x+1)
                        xarr(x+1) = tmp  
                                swap=true
                                end if    
                next
loop until swap = false   

for x=0 to ubound(xarr)-1
                msgbox(xarr(x))
next
