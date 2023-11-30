dim num, l, g, result, a , b , c , d, apos, bpos, cpos, dpos, first, second, third, fourth
do until g = true
g = false
num = inputbox ("Enter 4 numeric digits")

l = len(num)

if l <> 4 then Msgbox ("just 4 digits please") 
if l = 4 then g = true
if isnumeric(num) = false then msgbox ("just numbers - no letter please") : g = false
loop



a = mid(num,1,1)
b = mid(num,2,1)
c = mid(num,3,1)
d = mid(num,4,1)




apos = 4
bpos = 4
cpos = 4
dpos = 4

if a => b then apos = apos - 1
if a => c then apos = apos -1
if a => d then apos = apos -1

if b => a then bpos = bpos - 1
if b => c then bpos = bpos -1
if b => d then bpos = bpos -1

if c => b then cpos = cpos - 1
if c => a then cpos = cpos -1
if c => d then cpos = cpos -1

if d => b then dpos = dpos - 1
if d => c then dpos = dpos -1
if d => a then dpos = dpos -1

if apos = 1 then first = a
if bpos = 1 then first = b
if cpos = 1 then first = c
if dpos = 1 then first = d

if apos = 2 then second = a
if bpos = 2 then second = b
if cpos = 2 then second = c
if dpos = 2 then second = d

if apos = 3 then third = a
if bpos = 3 then third = b
if cpos = 3 then third = c
if dpos = 3 then third = d

if apos = 4 then fourth = a
if bpos = 4 then fourth = b
if cpos = 4 then fourth = c
if dpos = 4 then fourth = d

msgbox ("Ascending order is  - " &  first & second & third & fourth)






