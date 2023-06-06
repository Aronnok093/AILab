import  s3Module  as  m1

fn = 'stdDb.py'
ln = 2

m1.display_file_lines(fn,ln)

n=m1.num_of_lines(fn)
print("Number of lines in {} is {}.".format(fn,n))

m1.display_file(fn)



