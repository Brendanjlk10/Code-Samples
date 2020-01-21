# -*- coding: utf-8 -*-
# MySQL Workbench Python script
# Data_Reading_Insertion.py
# Name: Brendan Jones
# Date: 4-22-18
# Reading and inserting files into mySQL database
# Written in MySQL Workbench 6.3.10

#import grt
import csv
import datetime
import sys
from sys import stdout
import pymysql
import time

#cur = db.cursor()#Create cursor to database

########################################
#######GET CONNECTION
#######################################
def getConnection():
    return pymysql.connect(host='localhost', user='root', password='mypassword', db='book_fetch_inc', charset = 'utf8')

#Filenames of csv input files
studentFilename = 'D:/OneDrive/Documents/CMSC 461/461 Unnormalized data - Student.csv'
employeeFilename = 'D:/OneDrive/Documents/CMSC 461/461 Unnormalized data - Employees.csv'
teacherFilename = 'D:/OneDrive/Documents/CMSC 461/461 Unnormalized data - Teacher.csv'

try:
    #Get connection to database
    connection = getConnection()
    connection.autocommit(True)
except:
    print("Connection to database failed!")
finally:
    try:
        with connection.cursor() as cursor:
            #Start of file by opening files and creating readers for them
            with open(studentFilename) as studentFile:
                with open(employeeFilename) as employeeFile:
                    with open(teacherFilename) as teacherFile:
                        studentReader = csv.reader(studentFile)#The reader of the student file
                        employeeReader = csv.reader(employeeFile)#The reader of the employee file
                        teacherReader = csv.reader(teacherFile)#The reader of the teacher file
                        studentEntries = []#The collection of rows of the student file
                        employeeEntries = []#The collection of rows of the employee file
                        teacherEntries = []#The collection of rows of the teacher file
                        print("Starting reading files!")
                        #Read in the files
                        for row in studentReader:
                            studentEntries.append(row)
                        for row in employeeReader:
                            employeeEntries.append(row)
                        for row in teacherReader:
                            teacherEntries.append(row)
                        
                        teacherFile.close()
                        employeeFile.close()
                        studentFile.close()
                        print("Files closed")
                        #inserting entries into database
                        
                        #First, into employee table
                        ID = 1
                        for employee in employeeEntries:
                            #print("Start of for loop")
                            if employee[8] == 'bookfetchinc.com':
                                cursor.execute("insert ignore into employee values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (employee[5], employee[9], ID, employee[0], employee[1], employee[3], int(employee[4]), employee[2], employee[6], employee[7]))
                                ID += 1
                        print("Inserted employee table")
                        
                        #Because need to create a Patricia customer service employee to allow trouble ticket T101
                        cursor.execute("insert ignore into employee values ('589-42-7539', 'Customer Support', %s, 'Patricia', 'Marable', 'Female', 20000, 'patritia.marable@bookfetchinc.com', '418 Landon Court', '775-555-4322')", ID)
                        ID = 1
                        print("Inserted Patricia")
                        
                        #University & University Rep Table
                        universityRep = employeeEntries[11]
                        cursor.execute("insert ignore into university values (%s, %s, %s)", (ID, universityRep[8], universityRep[6]))
                        cursor.execute("insert ignore into university_rep values (%s, %s, %s, %s, %s, %s, %s)", (universityRep[5], universityRep[2], ID, universityRep[0], universityRep[1], universityRep[7], universityRep[3]))
                        ID += 1
                        universityRep = employeeEntries[36]
                        cursor.execute("insert ignore into university values (%s, %s, %s)", (ID, universityRep[8], universityRep[6]))
                        cursor.execute("insert ignore into university_rep values (%s, %s, %s, %s, %s, %s, %s)", (universityRep[5], universityRep[2], ID, universityRep[0], universityRep[1], universityRep[7], universityRep[3]))
                        ID += 1
                        universityRep = employeeEntries[42]
                        cursor.execute("insert ignore into university values (%s, %s, %s)", (ID, universityRep[8], universityRep[6]))
                        cursor.execute("insert ignore into university_rep values (%s, %s, %s, %s, %s, %s, %s)", (universityRep[5], universityRep[2], ID, universityRep[0], universityRep[1], universityRep[7], universityRep[3]))
                        ID = 1
                        print("Inserted university & university rep tables")
                        
                        #Book & Book_Author & Book_Keywords & Book_Subcategories
                        for bookEntry in teacherEntries:
                            if bookEntry[8] != 'book':
                                if bookEntry[2] != "":
                                    cursor.execute("insert ignore into book values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 0, null, %s)", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[22], bookEntry[11], bookEntry[8], bookEntry[12], 
                                    bookEntry[16], bookEntry[17], bookEntry[18], bookEntry[20], bookEntry[21], bookEntry[23], bookEntry[2]))
                                else:
                                    cursor.execute("insert ignore into book values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 0, null, 'Fiction')", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[22], bookEntry[11], bookEntry[8], bookEntry[12], 
                                    bookEntry[16], bookEntry[17], bookEntry[18], bookEntry[20], bookEntry[21], bookEntry[23]))
                                
                                authorList = bookEntry[13].split(", ")
                                for theAuthor in authorList:
                                    cursor.execute("insert ignore into book_author values (%s, %s, %s, %s, %s)", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[22], theAuthor))
                                
                                keywordList = bookEntry[14].split()
                                for theKeyword in keywordList:
                                    cursor.execute("insert ignore into book_keywords values (%s, %s, %s, %s, %s)", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[22], theKeyword))
                                
                                if bookEntry[4] != "":
                                    cursor.execute("insert ignore into book_subcategories values(%s, %s, %s, %s, %s)", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[22], bookEntry[4]))
                                else:
                                    cursor.execute("insert ignore into book_subcategories values(%s, %s, %s, %s, 'Thriller')", (bookEntry[19], bookEntry[10], bookEntry[9], bookEntry[22]))
                        print("Inserted books tables")
                        
                        #Student & student_phone_num tables
                        for studentEntry in studentEntries:
                            if studentEntry[2] != 'email' and studentEntry[2] != "":
                                cursor.execute("insert ignore into student values (%s, %s, %s, %s, %s, (select distinct university_ID from university where university.university_name = %s), %s, %s, %s)", (studentEntry[2], studentEntry[0], studentEntry[1], 
                                studentEntry[3], datetime.datetime.strptime(studentEntry[5], "%m/%d/%Y").date(), studentEntry[6], studentEntry[7], studentEntry[8], studentEntry[9]))
                                
                                cursor.execute("insert ignore into student_phone_num values (%s, %s)", (studentEntry[2], studentEntry[4]))
                        print("Inserted student tables")
                        
                        #Trouble ticket, trouble ticket student, and trouble ticket changes
                        for ticketEntry in studentEntries:
                            if ticketEntry[10] != 'Ticket_ID' and ticketEntry[10] != "":
                                if ticketEntry[17] == 'new':
                                    cursor.execute("insert ignore into trouble_ticket values (%s, %s, %s, %s, null, %s, null, 'new', null)", (ticketEntry[10], ticketEntry[11], datetime.datetime.strptime(ticketEntry[12], "%m/%d/%Y").date(), ticketEntry[14], ticketEntry[15]))
                                    if ticketEntry[0] != "":
                                        cursor.execute("insert ignore into trouble_ticket_student values (%s, %s)", (ticketEntry[10], ticketEntry[2]))
                                    else:
                                        cursor.execute("insert ignore into trouble_ticket_employee values (%s, (select distinct SSN from employee where (employee.first_name = %s AND employee.job = 'Customer Support')))", (ticketEntry[10], ticketEntry[13]))
                                    cursor.execute("insert ignore into ticket_changes values (%s, %s, (select distinct SSN from employee where (employee.first_name = %s AND employee.job = 'Customer Support')), 'new')", (ticketEntry[10], datetime.datetime.strptime(ticketEntry[12], "%m/%d/%Y").date(), ticketEntry[13]))
                                elif ticketEntry[17] == 'completed':
                                    cursor.execute("insert ignore into ticket_changes values (%s, %s, (select distinct SSN from employee where (employee.first_name = %s AND employee.job = 'Administrators')), 'completed')", (ticketEntry[10], datetime.datetime.strptime(ticketEntry[12], "%m/%d/%Y").date(), ticketEntry[18]))
                                    cursor.execute("update trouble_ticket set date_completed = %s where ticket_ID = %s", (datetime.datetime.strptime(ticketEntry[12], "%m/%d/%Y").date(), ticketEntry[10]))
                                    cursor.execute("update trouble_ticket set state = 'completed' where ticket_ID = %s", ticketEntry[10])
                                    cursor.execute("update trouble_ticket set fixer_ID = (select distinct SSN from employee where (employee.first_name = %s AND employee.job = 'Administrators')) where ticket_ID = %s", (ticketEntry[18], ticketEntry[10]))
                                    cursor.execute("update trouble_ticket set problem_fix = %s where ticket_ID = %s", (ticketEntry[16], ticketEntry[10]))
                                else:
                                    cursor.execute("insert ignore into ticket_changes values (%s, %s, (select distinct SSN from employee where (employee.first_name = %s AND employee.job = 'Administrators')), %s)", (ticketEntry[10], datetime.datetime.strptime(ticketEntry[12], "%m/%d/%Y").date(), ticketEntry[18], ticketEntry[17]))
                                    cursor.execute("update trouble_ticket set state = %s where ticket_ID = %s", (ticketEntry[17], ticketEntry[10]))
                        print("Inserted ticket tables")
                        
                        #Department Table
                        for departmentEntry in teacherEntries:
                            if departmentEntry[2] != 'Department' and departmentEntry[2] != "":
                                cursor.execute("insert ignore into department values (%s, (select university_ID from university where university.university_name = %s))", (departmentEntry[2], departmentEntry[7]))
                        print("Inserted department table")
                        
                        #Book Rating Table
                        for ratingEntry in studentEntries:
                            if ratingEntry[41] != 'Book_rating_name' and ratingEntry[41] != "":
                                cursor.execute("insert ignore into book_rating values (%s, (select distinct ISBN_13 from book where title = %s), (select distinct purchase_type from book where title = %s), (select distinct book_condition from book where title = %s), (select distinct the_format from book where title = %s), %s, null)", (ratingEntry[2], ratingEntry[41], ratingEntry[41], ratingEntry[41], ratingEntry[41], float(ratingEntry[42])))
                         
                        print("Inserted rating table")
                        for bookRatingEntry in teacherEntries:
                            cursor.execute("update book set average_rating = (select avg(rating) from book_rating where book_rating.ISBN_13 = %s) where book.ISBN_13 = %s", (bookRatingEntry[19], bookRatingEntry[19]))       
                        print("Updated book average rating")
                        
                        #Cart and Cart Books Tables
                        cartID = 1
                        for cartEntry in studentEntries:
                            if cartEntry[19] != "" and cartEntry[19] != 'Cart_created':
                                cursor.execute("insert ignore into cart values (%s, %s, %s, %s)", (cartID, cartEntry[2], datetime.datetime.strptime(cartEntry[19], "%m/%d/%Y").date(), datetime.datetime.strptime(cartEntry[20], "%m/%d/%Y").date()))
                                cursor.execute("insert ignore into cart_books values (%s, (select distinct ISBN_13 from book where book.title = %s), (select distinct purchase_type from book where book.title = %s), (select distinct book_condition from book where book.title = %s), (select distinct the_format from book where book.title = %s), %s)", (cartID, cartEntry[21], cartEntry[21], cartEntry[21], cartEntry[21], cartEntry[23]))
                                if cartEntry[24] != "": #Book 2 of cart, if exists
                                    cursor.execute("insert ignore into cart_books values (%s, (select distinct ISBN_13 from book where book.title = %s), (select distinct purchase_type from book where book.title = %s), (select distinct book_condition from book where book.title = %s), (select distinct the_format from book where book.title = %s), %s)", (cartID, cartEntry[24], cartEntry[24], cartEntry[24], cartEntry[24], cartEntry[26]))
                                cartID += 1
                        print("Inserted cart table")
                        
                        #Orders & Order_Books tables
                        orderID = 1
                        for orderEntry in studentEntries:
                            if orderEntry[27] != "" and orderEntry[27] != 'ORDER_date_created':
                                if orderEntry[28] != "":
                                    cursor.execute("insert ignore into orders values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (orderID, orderEntry[2], datetime.datetime.strptime(orderEntry[27], "%m/%d/%Y").date(), datetime.datetime.strptime(orderEntry[28], "%m/%d/%Y").date(),
                                    orderEntry[40], orderEntry[35], datetime.datetime.strptime(orderEntry[37], "%m/%d/%Y").date(), orderEntry[36], orderEntry[38], orderEntry[39]))
                                else:
                                    cursor.execute("insert ignore into orders values (%s, %s, %s, null, %s, %s, %s, %s, %s, %s)", (orderID, orderEntry[2], datetime.datetime.strptime(orderEntry[27], "%m/%d/%Y").date(),
                                    orderEntry[40], orderEntry[35], datetime.datetime.strptime(orderEntry[37], "%m/%d/%Y").date(), orderEntry[36], orderEntry[38], orderEntry[39]))
                                cursor.execute("insert ignore into order_books values (%s, (select distinct ISBN_13 from book where book.title = %s), (select distinct purchase_type from book where book.title = %s), (select distinct book_condition from book where book.title = %s), (select distinct the_format from book where book.title = %s), %s)", (orderID, orderEntry[29], orderEntry[29], orderEntry[29], orderEntry[29], int(orderEntry[32])))
                                if orderEntry[30] != "":
                                    cursor.execute("insert ignore into order_books values (%s, (select distinct ISBN_13 from book where book.title = %s), (select distinct purchase_type from book where book.title = %s), (select distinct book_condition from book where book.title = %s), (select distinct the_format from book where book.title = %s), %s)", (orderID, orderEntry[30], orderEntry[30], orderEntry[30], orderEntry[30], int(orderEntry[34])))
                                
                                orderID += 1
                        print("Inserted order tables")
                        
                        cursor.execute("update book set total_purchases = 0")
                        for bookOrderQuantity in studentEntries:
                            if bookOrderQuantity[29] != 'ORDER_book1' and bookOrderQuantity[29] != "":
                                cursor.execute("update book set total_purchases = total_purchases + %s where title = %s", (int(bookOrderQuantity[32]), bookOrderQuantity[29]))
                            if bookOrderQuantity[30] != 'ORDER_book2' and bookOrderQuantity[30] != "":
                                cursor.execute("update book set total_purchases = total_purchases + %s where title = %s", (int(bookOrderQuantity[34]), bookOrderQuantity[30]))
                        print("Updated order quantities")
                        
                        #Course & Instructor & Course_Instructor & Required_Books tables
                        courseID = 1
                        for courseTeacherEntry in teacherEntries:
                            if courseTeacherEntry[0] != "" and courseTeacherEntry[0] != 'instructor_fname':
                                cursor.execute("insert ignore into instructor values (%s, %s, %s, %s, (select distinct university_ID from university where university.university_name = %s))", (courseTeacherEntry[3], courseTeacherEntry[0], courseTeacherEntry[1], courseTeacherEntry[2], courseTeacherEntry[7]))
                                cursor.execute("insert ignore into course values (%s, %s, %s, (select distinct university_ID from university where university.university_name = %s), %s, %s)", (courseID, courseTeacherEntry[6], int(courseTeacherEntry[5]), courseTeacherEntry[7], courseTeacherEntry[4], courseTeacherEntry[2]))
                                cursor.execute("insert ignore into course_instructor values (%s, %s, %s, (select distinct university_ID from university where university.university_name = %s), %s)", (courseID, courseTeacherEntry[6], int(courseTeacherEntry[5]), courseTeacherEntry[7], courseTeacherEntry[3]))
                                cursor.execute("insert ignore into required_books values (%s, %s, %s, (select distinct university_ID from university where university.university_name = %s), %s, %s, %s, %s)", (courseID, courseTeacherEntry[6], int(courseTeacherEntry[5]), courseTeacherEntry[7], courseTeacherEntry[19], courseTeacherEntry[10], courseTeacherEntry[9], courseTeacherEntry[22]))
                                courseID += 1
                        print("Inserted course tables")
    except Exception as error:
        print("*****")
        print("reading or insertion failed!")
        print(error)
        print("*****")
    finally:
        connection.close()
