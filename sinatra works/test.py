n=int(raw_input())
a=[]
for i in range(n):    
	x=raw_input()
	y=float(raw_input())
	b=[x,y]
	a.append(b)
a.sort(key=lambda z:(z[1],z[0]))
temp=a[0][1]
flag=0
for j in range(1,n):
	if a[j][1]>temp and flag==0:
		print a[j][0]
		flag=1
		temp=a[j][1]
		continue
	if temp==a[j][1] and flag==1:
	    print a[j][0]
