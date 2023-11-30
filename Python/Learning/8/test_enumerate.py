a = ["foo","bar","baz",'bar','any','much']

indexes = [index for index in range(len(a)) if a[index] == 'bar']
print (indexes)