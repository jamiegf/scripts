dim numbers(4)
dim ctr,lowtmp,tmp,ptr,x

dim pos

x=0 
                While x<=3 
                                numbers(x)=inputbox ("Input " & x+1 & " number")                                       
                                if Isnumeric(numbers(x))=True and Len(numbers(x))>0 Then
                                                x=x+1
                                End If
                Wend

ctr=0
lowtmp=numbers(ctr)   
pos=ctr
                                while ctr<=3
                                                ptr=ctr+1 
                                                While ptr<=3
                                                                tmp=numbers(ptr)
                                                                if CSNG(lowtmp)>=CSNG(tmp) Then
                                                                                lowtmp=tmp                                                                     
                                                                                pos=ptr
                                                                End If                                                    
                                                                ptr=ptr+1
                                                wend
                                                tmp=numbers(pos)        
                                                numbers(pos)=numbers(ctr)
                                                numbers(ctr)=tmp
                                                ctr=ctr+1
                                                lowtmp=numbers(ctr)
                                                pos=ctr
                                Wend

dim btr
btr=0
while btr<=3 
                msgbox numbers(btr)
                btr=btr+1
wend
