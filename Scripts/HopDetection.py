import os

def most_common(lst):
	return max(set(lst),key = lst.count)

os.system('''cat text | grep Cha | cut -d ":" -f2 > text1''')
a = open("text1","r").read()
a = a.lstrip(" 37\n ")
a = a.replace("\n","")	
l = map(int,a.split(" "))
s = []
for i in l:
	if i not in s:
		s.append(i)
l1 = []
for i in range(len(s)-1):
	hop1 = s[i+1] - s[i]
	hop2 = 37 + s[i+1] - s[i]
	if(hop1 >= 5 or hop1 <= 16):
		l1.append(hop1)
	elif(hop2 >= 5 or hop2 <= 16):
		l1.append(hop2)
hop = most_common(l1)
print "Hop :",hop
