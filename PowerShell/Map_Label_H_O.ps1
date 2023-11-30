net use h: /delete
net use h: "\\wn-2k8fi02\home$\$env:username" /persistent:yes
net use o: /delete
net use o: "\\wn-2k8fi02\filestore\shareddata\delivery" /persistent:yes


$sh=New-Object -com Shell.Application

$sh.NameSpace('h:').Self.Name = "Home Drive : $env:username"
$sh.NameSpace('O:').Self.Name = "Operations Drive"