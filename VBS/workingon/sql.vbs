Const adOpenStatic = 3
Const adLockOptimistic = 3

strCode = InputBox ("Enter Dimensions User Name ie 'JBLOGGS'")

Set objConnection = CreateObject("ADODB.connection")
Set objRecordSet = CreateObject("ADODB.Recordset")

objConnection.Open _
	"Provider=SQLOLEDB;Data Source=UKBSSSQL10 ;" &_
	"Trusted_Connection=Yes;Initial Catalog=ACCNTS;" &_
	"User ID=SA; Password=Secure2010;"
	
objRecordSet.Open "Update ACCNTS.dbo.SYS_USER set USER_ACTIVE=0,USER_BATCHING=NULL,USER_ALLOC_AC_S=NULL,USER_ALLOC_AC_P=NULL where USER_NAME = '" & strCode & "'", _
	objConnection, adOpenStatic, adLockOptimistic
	
	'objRecordset.MoveFirst
	'Do Until objRecordSet.EOF
	'msgbox objRecordSet.Fields.Item("USER_NAME")
	'objRecordset.MoveNext
'Loop
