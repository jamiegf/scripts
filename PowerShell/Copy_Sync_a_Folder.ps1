$source = "c:\test\DJ_Music"
$dest = "c:\test\music"

#$exclusions = "c:\exclusions.txt"


#robocopy $source $dest /mir /copyall
#use this only if you want to delete anything in dest that isnt in source
#aka 2 way sync

robocopy $source $dest /copyall /S /E
#use this to not delete anything
#aka 1 way sync