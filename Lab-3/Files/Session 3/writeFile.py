
fn = 'fl1.py'
ln = 3
f1=open(fn, "w")
print("\n")       
for i in range(ln):
        name=str(input("Enter the name:"))
        dept=str(input("Enter the department:"))
        cgpa=str(input("Enter the cgpa:"))
        std=name+"\t"+dept+"\t"+cgpa
        print(std, end="\n", file=f1)
        print("\n")
f1.close

f1=open(fn, "r")       
for l in f1:
        name, dept, cgpa =l.split("\t")
        print(name, dept, float(cgpa), end="\n")
f1.close
