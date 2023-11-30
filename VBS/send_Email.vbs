Set objEmail = CreateObject("CDO.Message")
	objEmail.From = "rajan.gangadharan@bytes.co.uk"
	objEmail.To = "jason.lee@bytes.co.uk; rajan.gangadharan@bytes.co.uk"
	objEmail.Subject = "gay boy"
	objEmail.TextBody = "Rajan is really very very gay"
	objEmail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	objEmail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "exchange.bytes.co.uk"
	objEmail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
	objEmail.Configuration.Fields.Update
	objEmail.Send