Const adOpenStatic = 3
Const adLockOptimistic = 3

strCode = InputBox ("Enter code")
Set objConnection = CreateObject("ADODB.connection")
Set objRecordSet = CreateObject("ADODB.Recordset")

objConnection.Open _
	"Provider=SQLOLEDB;Data Source=btguksql05 ;" &_
	"Trusted_Connection=Yes;Initial Catalog=AM_BTG;" &_
	"User ID=SA; Password=secure;"
	
objRecordSet.Open "Select * from FA_Accounts where FA_Code = " & StrCode & , _
	objConnection, adOpenStatic, adLockOptimistic
	
	objRecordset.MoveFirst
	Do Until objRecordSet.EOF
	msgbox objRecordSet.Fields.Item("FA_Userkey2")
	objRecordset.MoveNext
Loop

	