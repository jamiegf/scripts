$ZipExistsError = new-object -comobject wscript.shell
$intAnswer = $ZipExistsError.popup("Zip already exists at destination. Would you like to use this zip? If no - please delete or rename zip", `
0,"Delete Files",4)
If ($intAnswer -eq 6) {
  $ZipExistsError.popup("You answered yes.")
} else {
  $ZipExistsError.popup("You answered no.")
}