username=inputbox("Enter username:")
if username = "" then wscript.quit

ldapPath = FindUser(username)

if ldapPath = "Not Found" then
    wscript.echo "User not found!"
else
    set objUser = getobject(ldapPath)
    if isAccountLocked(objUser) then
        objuser.put "lockoutTime", 0
        objUser.setinfo
        wscript.echo "Account Unlocked"
    else
        wscript.echo "This account is not locked out"
    end if
end if



msgbox "Password last changed : " & objuser.PasswordLastChanged



Const SEC_IN_DAY = 86400
Const ADS_UF_DONT_EXPIRE_PASSWD = &h10000

dtmValue = objUser.PasswordLastChanged 
    'Wscript.Echo "The password was last changed on " & _
        'DateValue(dtmValue) & " at " & TimeValue(dtmValue) & VbCrLf & _
            '"The difference between when the password was last set" &  _
               ' "and today is " & int(now - dtmValue) & " days"
    intTimeInterval = int(now - dtmValue)
  
    Set objDomainNT = GetObject("WinNT://bytes.co.uk")
    intMaxPwdAge = objDomainNT.Get("MaxPasswordAge")
    If intMaxPwdAge < 0 Then
        WScript.Echo "The Maximum Password Age is set to 0 in the " & _
            "domain. Therefore, the password does not expire."
    Else
        intMaxPwdAge = (intMaxPwdAge/SEC_IN_DAY)
        'Wscript.Echo "The maximum password age is " & intMaxPwdAge & " days"
        If intTimeInterval >= intMaxPwdAge Then
          Wscript.Echo "The password has expired."
        Else
          Wscript.Echo "The password will expire on " & _
              DateValue(dtmValue + intMaxPwdAge) & " (" & _
                  int((dtmValue + intMaxPwdAge) - now) & " days from today" & _
                      ")."
        End If
    End If






Function FindUser(Byval UserName) 
    on error resume next

    set objRoot = getobject("LDAP://RootDSE")
    domainName = objRoot.get("defaultNamingContext")
    set cn = createobject("ADODB.Connection")
    set cmd = createobject("ADODB.Command")
    set rs = createobject("ADODB.Recordset")

    cn.open "Provider=ADsDSOObject;"
    
    cmd.activeconnection=cn
    cmd.commandtext="SELECT ADsPath FROM 'LDAP://" & domainName & _
            "' WHERE sAMAccountName = '" & UserName & "'"
    
    set rs = cmd.execute

    if err<>0 then
        wscript.echo "Error connecting to Active Directory Database:" & err.description
        wscript.quit
    else
        if not rs.BOF and not rs.EOF then
                rs.MoveFirst
                FindUser = rs(0)
        else
            FindUser = "Not Found"
        end if
    end if

    cn.close
end function

Function IsAccountLocked(byval objUser)
        on error resume next
    set objLockout = objUser.get("lockouttime")

    if err.number = -2147463155 then
        isAccountLocked = False
        exit Function
    end if
    on error goto 0
    
    if objLockout.lowpart = 0 And objLockout.highpart = 0 Then
        isAccountLocked = False
    Else
        isAccountLocked = True
    End If

End Function
