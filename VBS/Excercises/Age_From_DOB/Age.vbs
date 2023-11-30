dim e, c, e2

e = (cdate(inputbox ("Enter DOB")))


'bring years up to date and counter years
c = -1	
do until e > date

c = c + 1
e = cdate((dateadd("yyyy",1,e)))
loop

'years
'msgbox e
msgbox (c & " years")

'months

m = datediff("m",e,now())
m = m + 12

'if todays dayis higher then - 1 to months 


d = datepart("d",e)

dnow = datepart("d", now())

'msgbox ("d= " & d)
'msgbox ("dnow = " & dnow)

if d > dnow then M = M-1 : days = 31 -(d - dnow) :_
else days = dnow - d ': msgbox "test"

msgbox (m & " Month/s")

msgbox (days & " days")





 














