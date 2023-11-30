

#Add-PSSnapin SqlServerCmdletSnapin100
#Add-PSSnapin SqlServerProviderSnapin100


$SQLServer = "ukbsssql12"




$id = read-host "enter id" 

#$a = Invoke-Sqlcmd -Query ("select known_as from hrpro_test.dbo.Personnel_Records WHERE ID = '738' ") -serverinstance "ukbsssql12" -username sa -password secure

#internal_Phone, Telephone_DDI (ext, phoneno)
$DataRow = Invoke-Sqlcmd -Query ("select known_as,surname, department, Job_Title, Manager  from hrpro_test.dbo.Personnel_Records WHERE Staff_no = '$id' ") -serverinstance $SQLServer -username sa -password secure
#$a  =  $FirsName.TrimEnd() 
$FirstName = $DataRow[0]
$SurName =$DataRow[1]
$Dept = $DataRow[2]
$Jobtitle = $DataRow[3]
$Manager = $DataRow[4]


$FirstName + "." + $SurName + "@bytes.co.uk"

$Dept
$Jobtitle
$Manager



