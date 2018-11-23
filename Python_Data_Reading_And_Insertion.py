# -*- coding: utf-8 -*-
# MySQL Workbench Python script
# Name: Brendan Jones
# Date: 4-22-18
# Reading and inserting files into mySQL database
# Written in MySQL Workbench 6.3.10

import grt
import csv
#import mforms

db = MySQLdb.connect(host=127.0.0.1, user=Brendanjlk10, passwd=Bj&5426256277, db=Book_Fetch_Inc)#Create connection to the database
cur = db.cursor()#Create cursor to database

#Filenames of csv input files
studentFilename = 'Unnormalized data - Student.csv'
employeeFilename = '461 Unnormalized data - Employees.csv'
teacherFilename = '461 Unnormalized data - Teacher.csv'

#Start of file by opening files and creating readers for them
with open(studentFilename) as studentFile:
    with open(employeeFilename) as employeeFile:
        with open(teacherFilename) as teacherFile:
            studentReader = csv.reader(studentFile)#The reader of the student file
            employeeReader = csv.reader(employeeFile)#The reader of the employee file
            teacherReader = csv.reader(teacherFile)#The reader of the teacher file
            studentEntries = []#The collection of rows of the student file
            employeeEntry = []#The collection of rows of the employee file
            teacherEntry = []#The collection of rows of the teacher file
            #Read in the files
            for row in studentReader:
                studentEntries.append(row)
            for row in employeeReader:
                employeeEntries.append(row)
            for row in teacherReader:
                teacherEntries.append(row)
            
            #inserting entries into database
            
            #First, into employee table
            ID = 0
            for employee in employeeEntries:
                if employee[8] == 'bookfetchinc.com':
                    cur.execute("insert into employee values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (employee[5], employee[9], ID, employee[0], employee[1], employee[3], employee[4], employee[2], employee[6], employee[7]))
                    ID += 1
            #Because need to create a Patricia customer service employee to allow trouble ticket T101
            cur.execute("insert into employee values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", ('589-42-753', 'Customer Support', ID, 'Patricia', 'Marable', 'Female', 20000, 'patritia.marable@bookfetchinc.com', '418 Landon Court', '775-555-4322'))
            ID = 0
            
            #University & University Rep Table
            universityRep = employeeEntries[11]
            cur.execute("insert into university values (%s, %s, %s)", (ID, universityRep[8], universityRep[6]))
            cur.execute("insert into university_rep values (%s, %s, %s, %s, %s, %s, %s)", (universityRep[5], universityRep[2], ID, universityRep[0], universityRep[1], universityRep[7], universityRep[8]))
            ID += 1
            universityRep = employeeEntries[36]
            cur.execute("insert into university values (%s, %s, %s)", (ID, universityRep[8], universityRep[6]))
            cur.execute("insert into university_rep values (%s, %s, %s, %s, %s, %s, %s)", (universityRep[5], universityRep[2], ID, universityRep[0], universityRep[1], universityRep[7], universityRep[8]))
            ID += 1
            universityRep = employeeEntries[42]
            cur.execute("insert into university values (%s, %s, %s)", (ID, universityRep[8], universityRep[6]))
            cur.execute("insert into university_rep values (%s, %s, %s, %s, %s, %s, %s)", (universityRep[5], universityRep[2], ID, universityRep[0], universityRep[1], universityRep[7], universityRep[8]))
            
            #Book & Book_Author & Book_Keywords & Book_Subcategories
            booksChecked = 0
            for bookEntry in teacherEntries:
                if bookEntry[8] != 'book':#TODO: Books not associated with teacher
                    tempBookCount = 0
                    alreadyAdded = false
                    while tempBookCount < booksChecked:
                        oldBookEntry = teacherEntries[tempBookCount + 1]
                        if oldBookEntry[19] == bookEntry[19]:
                            alreadyAdded = true
                        tempBookCount += 1
                    
                    if alreadyAdded == false:
                        if bookEntry[2] != "":
                            cur.execute("insert into book values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 0, null, %s)", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[11], bookEntry[8], bookEntry[12], 
                            bookEntry[16], bookEntry[17], bookEntry[18], bookEntry[20], bookEntry[21], bookEntry[22], bookEntry[23], bookEntry[2]))
                        else:
                            cur.execute("insert into book values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 0, null, 'Fiction')", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[11], bookEntry[8], bookEntry[12], 
                            bookEntry[16], bookEntry[17], bookEntry[18], bookEntry[20], bookEntry[21], bookEntry[22], bookEntry[23]))
                        
                        authorList = bookEntry[13].split(", ")
                        for theAuthor in authorList:
                            cur.execute("insert into book_author values (%s, %s)", (bookEntry[19], theAuthor))
                        
                        keywordList = bookEntry[14].split()
                        for theKeyword in keywordList:
                            cur.execute("insert ignore into book_keywords values (%s, %s)", (bookEntry[19], theKeyword))
                        
                        if bookEntry[4] != "":
                            cur.execute("insert into book_subcategories values(%s, %s)", (bookEntry[19], bookEntry[4]))
                        else:
                            cur.execute("insert into book_subcategories values(%s, 'Thriller')", bookEntry[19])
                    booksChecked += 1
            
            #Student & student_phone_num tables
            for studentEntry in studentEntries:
                if studentEntry[2] != 'email' and studentEntry[2] != null:
                    cur.execute("insert ignore into student values (%s, %s, %s, %s, %s, select university_ID from university where university.name = %s, %s, %s, %s)", (studentEntry[2], studentEntry[0], studentEntry[1], 
                    studentEntry[3], convert(date, convert(varchar(10), studentEntry[5]), 101), studentEntry[6], studentEntry[7], studentEntry[8], studentEntry[9]))
                    cur.execute("insert ignore into student_phone_num values (%s, %s)", (studentEntry[2], studentEntry[4]))
            
            #Trouble ticket, trouble ticket student, and trouble ticket changes
            for ticketEntry in studentEntries:
                if ticketEntry[10] != 'Ticket_ID' and ticketEntry[10] != "":
                    if ticketEntry[17] == 'new':
                        cur.execute("insert ignore into trouble_ticket values (%s, %s, %s, %s, null, %s, null, 'new', null)", (ticketEntry[10], ticketEntry[11], convert(date, convert(varchar(10), ticketEntry[12]), 101), ticketEntry[14], ticketEntry[15]))
                        if ticketEntry[0] != "":
                            cur.execute("insert ignore into trouble_ticket_student values (%s, %s)", (ticket_ID[10], ticket_ID[2]))
                        else:
                            cur.execute("insert ignore into trouble_ticket_employee values (%s, select SSN from employee where (employee.first_name == %s OR employee.last_name == %s)", (ticket_ID[10], ticket_ID[13], ticket_ID[13]))
                        cur.execute("insert ignore into ticket_changes values (%s, %s, select SSN from employee where (employee.first_name == %s OR employee.last_name == %s), 'new')", (ticketEntry[10], convert(date, convert(varchar(10), ticketEntry[12]), 101), ticketEntry[13], ticketEntry[13]))
                    elif ticketEntry[17] == 'completed':
                        cur.execute("insert ignore into ticket_changes values (%s, %s, select SSN from employee where (employee.first_name == %s OR employee.last_name == %s), 'completed')", (ticketEntry[10], ticketEntry[12], ticketEntry[18], ticketEntry[18]))
                        cur.execute("update trouble_ticket set date_completed = %s where ticket_ID == %s", (ticketEntry[12], ticketEntry[10])
                        cur.execute("update trouble_ticket set state = 'completed' where ticket_ID == %s", ticketEntry[10]) 
                        cur.execute("update trouble_ticket set fixer_ID = (select SSN from employee where (employee.first_name == %s OR employee.last_name == %s)) where ticket_ID == %s", (ticketEntry[18], ticketEntry[18], ticketEntry[10]))
                        cur.execute("update trouble_ticket set problem_fix = %s where ticket_ID == %s", 
                    else:
                        cur.execute("insert ignore into ticket_changes values (%s, %s, select SSN from employee where (employee.first_name == %s OR employee.last_name == %s), %s)", (ticketEntry[10], ticketEntry[12], ticketEntry[18], ticketEntry[18], ticketEntry[17]))
                        cur.execute("update trouble_ticket set state = %s where ticket_ID == %s", (ticketEntry[17], ticketEntry[10]))
            
            #Department Table
            for departmentEntry in teacherEntries:
                if departmentEntry[2] != 'Department' and departmentEntry[2] != "":
                    cur.execute("insert ignore into department values (%s, %s)", (departmentEntry[2], departmentEntry[7]))
            
            #Book Rating Table
            for ratingEntry in studentEntries:
                if ratingEntry[41] != 'Book_rating_name' and ratingEntry[41] != "":
                    cur.execute("insert ignore into book_rating values (%s, select ISBN_13 from book where title == %s, %s, null)", (ratingEntry[2], ratingEntry[41], int(ratingEntry[42])))

            #Cart and Cart Books Tables
            cartID = 1
            for cartEntry in studentEntries:
                if cartEntry[19] != "" and cartEntry[19] != 'Cart_created':
                    cur.execute("insert ignore into cart values (%s, %s, %s, %s)", (cartID, cartEntry[2], convert(date, convert(varchar(10), cartEntry[19]), 101), convert(date, convert(varchar(10), cartEntry[20]), 101)))
                    cur.execute("insert ignore into cart_boks values (%s, select ISBN_13 from book where book.title == %s), %s, %s)", (cartID, cartEntry[21], cartEntry[23], cartEntry[22]))
                    if cartEntry[24] != "":#Book 2 of cart, if exists
                        cur.execute("insert ignore into cart_boks values (%s, select ISBN_13 from book where book.title == '%s'), %s, %s)", (cartID, cartEntry[24], cartEntry[26], cartEntry[25]))
                    cartID += 1
            
            #Orders & Order_Books tables
            orderID = 1
            for orderEntry in orderEntries:
                if orderEntry[27] != "" and orderEntry[27] != 'ORDER_date_created'
                    if orderEntry[28] != "":
                        cur.execute("insert ignore into orders values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (orderID, orderEntry[2], convert(date, convert(varchar(10), orderEntry[27]), 101), convert(date, convert(varchar(10), orderEntry[28]), 101),
                        orderEntry[40], orderEntry[35], convert(date, convert(varchar(10), orderEntry[37]), 101), orderEntry[36], orderEntry[38], orderEntry[39]))
                    else:
                        cur.execute("insert ignore into orders values (%s, %s, %s, null, %s, %s, %s, %s, %s, %s)", (orderID, orderEntry[2], convert(date, convert(varchar(10), orderEntry[27]), 101),
                        orderEntry[40], orderEntry[35], convert(date, convert(varchar(10), orderEntry[37]), 101), orderEntry[36], orderEntry[38], orderEntry[39]))
                    
                    cur.execute("insert ignore into order_books values (%s, select ISBN_13 from book where book.title == %s, %s, %s)", (orderID, orderEntry[29], int(orderEntry[32]), orderEntry[31]))
                    if orderEntry[30] != ""
                        cur.execute("insert ignore into order_books values (%s, select ISBN_13 from book where book.title == %s, %s, %s)", (orderID, orderEntry[30], int(orderEntry[34]), orderEntry[33]))
                    
                    orderID += 1
            
            #Course & Instructor & Course_Instructor & Required_Books tables
            courseID = 1
            for courseTeacherEntry in teacherEntries:
                if courseTeacherEntry[0] != "" and courseTeacherEntry[0] != 'instructor_fname'
                    cur.execute("insert ignore into instructor values (%s, %s, %s, %s, select university_ID from university where university.name == %s)", (courseTeacherEntry[3], courseTeacherEntry[0], courseTeacherEntry[1], courseTeacherEntry[2], courseTeacherEntry[7]))
                    cur.execute("insert ignore into course values (%s, %s, %s, select university_ID from university where university.name == %s, %s, %s)", (courseID, courseTeacherEntry[6], int(courseTeacherEntry[5]), courseTeacherEntry[7], courseTeacherEntry[4], courseTeacherEntry[2]))
                    cur.execute("insert ignore into course_instructor values (%s, %s, %s, select university_ID from university where university.name == %s, %s)", (courseID, courseTeacherEntry[6], int(courseTeacherEntry[5]), courseTeacherEntry[7], courseTeacherEntry[3]))
                    cur.execute("insert ignore into required_books values (%s, %s, %s, select university_ID from university where university.name == %s, %s)", (courseID, courseTeacherEntry[6], int(courseTeacherEntry[5]), courseTeacherEntry[7], courseTeacherEntry[19]))
                    courseID += 1

teacherFile.close()
employeeFile.close()
studentFile.close()














