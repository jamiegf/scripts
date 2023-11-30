$ServerName = "10.10.10.86"
$DatabaseName = "Ultraplay"
$userName = "Checker"
$password = "99RedBalloons1"


function Test-SQLConnection
{    
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        $ConnectionString
    )
    try
    {
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnectionString;
        $sqlConnection.Open();
        $sqlConnection.Close();

        return $true;
    }
    catch
    {
        return $false;
    }
}

Test-SQLConnection "Data Source=$serverName;database=$databaseName;User ID=$userName;Password=$password;"