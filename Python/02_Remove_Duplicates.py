def remove_duplicates(s):
    result = ""
    
    for char in s:
        if char not in result:
            result += char
    
    return result

n = int(input())  # number of test cases

for _ in range(n):
    string = input()
    print(remove_duplicates(string)) 


## INPUT:
3
aabbcc
programming
hello world


## OUTPUT:
abc
progamin
helo wrd



