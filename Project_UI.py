# -*- coding: utf-8 -*-
# MySQL Workbench Python script
# Project_UI.py
# Name: Brendan Jones
# Date: 5-12-18
# The UI for the Project
# Written in Eclipse-Workspace

import datetime
import pymysql
from Tkinter import *
import tkMessageBox

try:
    connection = pymysql.connect(host='localhost', user='root', password='mypassword', db='book_fetch_inc', charset = 'utf8')#Connection to the database
    connection.autocommit(True)
except EXCEPTION as error:
    print("*******")
    print("Error connecting to database!")
    print(error)
    print("*******")
finally:
    ########################################
    #######Add to existing cart
    ########################################
    def addToCartModule(studentID):
        try:
            with connection.cursor() as cursor:
                addToCartWindow = Tk()
                addToCartWindow.configure(bg = "blue")
                addToCartWindow.configure(width = 1500)
                addToCartWindow.configure(height = 300)
                addToCartWindow.title("Add to cart")
                addToCartWindow.propagate(0)
                
                chooseNewBookCartScrollBar = Scrollbar(addToCartWindow)
                chooseNewBookCartScrollBar.pack(side = RIGHT, fill = Y)
                
                newBookListBox = Listbox(addToCartWindow, yscrollcommand = chooseNewBookCartScrollBar.set, width = 200, selectmode = MULTIPLE)
                cursor.execute("select distinct title, purchase_type, book_condition, the_format, price, ISBN_13 from book where quantity > 0")
                newCartBooks = list(cursor.fetchall())
                for newCartBook in newCartBooks:
                    newBookListBox.insert(END, "Title = " + newCartBook[0] + ", Purchase Type = " + newCartBook[1] + ", Book Condition = " + newCartBook[2] + ", Format = " + newCartBook[3] + ", Price = " + str(newCartBook[4]))
                
                newBookListBox.pack(side = LEFT, fill = BOTH)
                chooseNewBookCartScrollBar.config(command = newBookListBox.yview)
                
                def chooseNewCartBooksSelection():
                    newBookListIndex = list()
                    newCartBookList = list()
                    print(newBookListBox.curselection())
                    for newCartListIndex in newBookListBox.curselection():
                        newBookListIndex.append(newCartListIndex)
                    for newBookIndex in newBookListIndex:
                        newCartBookList.append(newCartBooks[newBookIndex])
                    
                    addToCartWindow.quit()
                    addToCartWindow.destroy()
                    booksQuantity = list()
                    for newCartBookSelection in newCartBookList:
                        bookQuantityWindow = Tk()
                        bookQuantityWindow.configure(bg = "blue")
                        bookQuantityWindow.configure(width = 700)
                        bookQuantityWindow.configure(height = 100)
                        bookQuantityWindow.title("How many of the book?")
                        bookQuantityWindow.propagate(0)
                        
                        bookQuantityLabel = Label(bookQuantityWindow, text = ("How many of the book title = " + newCartBookSelection[0] + ",\npurchase type = " + newCartBookSelection[1] + ", book condition = " + newCartBookSelection[2] + ", format = " + newCartBookSelection[3] + " do you want?"))
                        bookQuantityLabel.pack(anchor = CENTER)
                        
                        cursor.execute("select distinct quantity from book where ISBN_13 = %s and purchase_type = %s and book_condition = %s and the_format = %s", (newCartBookSelection[5], newCartBookSelection[1], newCartBookSelection[2], newCartBookSelection[3]))
                        bookAvailableQuantity = cursor.fetchall()[0][0]
                        bookQuantitySpinBox = Spinbox(bookQuantityWindow, from_ = 1, to = bookAvailableQuantity)
                        bookQuantitySpinBox.pack(anchor = CENTER)
                        
                        def bookQuantitySelection():
                            booksQuantity.append(bookQuantitySpinBox.get())
                            bookQuantityWindow.quit()
                            bookQuantityWindow.destroy()
                        
                        bookQuantityButton = Button(bookQuantityWindow, text="Choose Selected Quantity", command=bookQuantitySelection)
                        bookQuantityButton.pack(anchor = CENTER)
                        
                        bookQuantityWindow.mainloop()
                    
                    cursor.execute("select distinct cart_ID from cart where student_email = %s", studentID)
                    newCartID = cursor.fetchall()[0][0]
                    
                    now = datetime.datetime.strptime(datetime.datetime.now().strftime('%m/%d/%Y'), "%m/%d/%Y").date()
                    cursor.execute("update cart set date_updated = %s where student_email = %s", (now, studentID))
                    bookAdding = 0
                    for newCartBook in newCartBookList:
                        cursor.execute("insert ignore into cart_books values(%s, %s, %s, %s, %s, %s)", (newCartID, newCartBook[5], newCartBook[1], newCartBook[2], newCartBook[3], booksQuantity[bookAdding]))
                        bookAdding += 1
                
                chooseNewBooksButton = Button(addToCartWindow, text="Add selected book(s) to your cart", command=chooseNewCartBooksSelection)
                chooseNewBooksButton.pack(anchor=CENTER)
                
                addToCartWindow.mainloop()
        except:
            print("*********")
            print("Error in addToCartModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Remove from existing cart
    ########################################
    def removeFromCartModule(studentID):
        try:
            with connection.cursor() as removeFromCartCursor:
                removeFromCartCursor.execute("select count(distinct cart_ID) from cart where student_email = %s", studentID)
                numStudentCarts = removeFromCartCursor.fetchall()[0][0]
                
                if numStudentCarts == 0:
                    tkMessageBox.showinfo("Student's Cart Removal", "You have no cart to be removed!")
                elif numStudentCarts == 1:
                    removeFromCartWindow = Tk()
                    removeFromCartWindow.configure(bg = "blue")
                    removeFromCartWindow.configure(width = 1200)
                    removeFromCartWindow.configure(height = 300)
                    removeFromCartWindow.title("Remove From Cart")
                    removeFromCartWindow.propagate(0)
                    
                    removeBookCartScrollBar = Scrollbar(removeFromCartWindow)
                    removeBookCartScrollBar.pack(side = RIGHT, fill = Y)
                    
                    removeBooksInCartListBox = Listbox(removeFromCartWindow, yscrollcommand = removeBookCartScrollBar.set, width = 150, selectmode = MULTIPLE)
                    removeFromCartCursor.execute("select distinct cart_ID from cart where student_email = %s", studentID)
                    studentRemoveCartID = removeFromCartCursor.fetchall()[0][0]
                    removeFromCartCursor.execute("select ISBN_13, purchase_type, book_condition, the_format from cart_books where cart_ID = %s", studentRemoveCartID)
                    removeStudentCartBooks = list(removeFromCartCursor.fetchall())
                    
                    for removeStudentCartBook in removeStudentCartBooks:
                        removeFromCartCursor.execute("select title from book where ISBN_13 = %s", removeStudentCartBook[0])
                        bookTitle = removeFromCartCursor.fetchall()[0][0]
                        removeBooksInCartListBox.insert(END, "Title = " + bookTitle + ", Purchase Type = " + removeStudentCartBook[1] + ", Book Condition = " + removeStudentCartBook[2] + ", Format = " + removeStudentCartBook[3])
                    
                    removeBooksInCartListBox.pack(side = LEFT, fill = BOTH)
                    removeBookCartScrollBar.config(command = removeBooksInCartListBox.yview)
                
                    def choosecartBooksSelection():
                        removeBookListIndex = list(removeBooksInCartListBox.curselection())
                        removeCartBookList = list()
                        for deleteBookIndex in removeBookListIndex:
                            removeCartBookList.append(removeStudentCartBooks[deleteBookIndex])
                        
                        for removeCartBookSelection in removeCartBookList:
                            with connection.cursor() as tempCursor:
                                tempCursor.execute("delete from cart_books where (cart_ID = %s AND ISBN_13 = %s AND purchase_type = %s AND book_condition = %s AND the_format = %s)", (studentRemoveCartID, removeCartBookSelection[0], removeCartBookSelection[1], removeCartBookSelection[2], removeCartBookSelection[3]))
                        
                        removeFromCartWindow.quit()
                        removeFromCartWindow.destroy()
                        
                        tkMessageBox.showinfo("Student's Cart Books Removal", "The selected book(s) were removed!")
                    
                    chooseBooksButton = Button(removeFromCartWindow, text="Remove selected book(s) from your cart", command=choosecartBooksSelection)
                    chooseBooksButton.pack(anchor=CENTER)
                else:
                    print(numStudentCarts)
                    raise EXCEPTION("Unexpected number of student carts!")
        except:
            print("*********")
            print("Error in removeFromCartModule!")
            print(error)
            print("*********")
    
    
    ########################################
    #######Student creates a cart.
    #######If student already has a cart, modifies existing cart instead
    ########################################
    def createCartModule(studentID):
        try:
            with connection.cursor() as cursor:
                def modifyExistingCart():
                    tkMessageBox.showinfo("Student's Cart", "You already have a cart! Having you modify your cart instead!")
                    
                    cartCreateModifyWindow = Tk()
                    cartCreateModifyWindow.configure(bg = "blue")
                    cartCreateModifyWindow.configure(width = 300)
                    cartCreateModifyWindow.configure(height = 200)
                    cartCreateModifyWindow.title("What to do?")
                    cartCreateModifyWindow.propagate(0)
                    
                    cartModifyCreateWhatLabel = Label(cartCreateModifyWindow, text = "What do you want to do?")
                    cartModifyCreateWhatLabel.pack(anchor = N)
                    
                    cartCreateModifyRadioVar = IntVar(cartCreateModifyWindow)
                    
                    def cartWhatDoSelection():
                        if cartCreateModifyRadioVar.get() == 1:#Add to cart
                            addToCartModule(studentID)
                        elif cartCreateModifyRadioVar.get() == 2:#Remove from cart
                            removeFromCartModule(studentID)
                        elif cartCreateModifyRadioVar.get() == 3:#Delete cart
                            cursor.execute("select cart_ID from cart where student_email = %s", studentID)
                            studentCartID = cursor.fetchall()[0][0]
                            cursor.execute("delete from cart_books where cart_ID = %s", studentCartID)
                            cursor.execute("delete from cart where student_email = %s", studentID)
                            tkMessageBox.showinfo("Student's Cart Deleted", "Your cart was deleted!")
                            cartCreateModifyWindow.quit()
                            cartCreateModifyWindow.destroy()
                        elif cartCreateModifyRadioVar.get() == 4:#Close window
                            cartCreateModifyWindow.quit()
                            cartCreateModifyWindow.destroy()
                        else:
                            print(cartCreateModifyRadioVar.get())
                            raise EXCEPTION("Unknown cart do radio var value!")
                        
                    addToCartRadio = Radiobutton(cartCreateModifyWindow, text="Add Book(s) to Cart", variable=cartCreateModifyRadioVar, value=1, command=cartWhatDoSelection)
                    addToCartRadio.pack(anchor = W)
                    
                    removeFromCartRadio = Radiobutton(cartCreateModifyWindow, text="Remove Book(s) From Cart", variable=cartCreateModifyRadioVar, value=2, command=cartWhatDoSelection)
                    removeFromCartRadio.pack(anchor = W)
                    
                    deleteCartRadio = Radiobutton(cartCreateModifyWindow, text="Delete Cart", variable=cartCreateModifyRadioVar, value=3, command=cartWhatDoSelection)
                    deleteCartRadio.pack(anchor = W)
                    
                    closeRadio = Radiobutton(cartCreateModifyWindow, text="Close", variable=cartCreateModifyRadioVar, value=4, command=cartWhatDoSelection)
                    closeRadio.pack(anchor = W)
                    
                    cartCreateModifyWindow.mainloop()
                
                cursor.execute("select count(distinct cart_ID) from cart where student_email = %s", studentID)
                numStudentCarts = cursor.fetchall()[0][0]
                
                if numStudentCarts == 0:
                    createCartWindow = Tk()
                    createCartWindow.configure(bg = "blue")
                    createCartWindow.configure(width = 1500)
                    createCartWindow.configure(height = 300)
                    createCartWindow.title("Create a cart")
                    createCartWindow.propagate(0)
                    
                    chooseBookNewCartScrollBar = Scrollbar(createCartWindow)
                    chooseBookNewCartScrollBar.pack(side = RIGHT, fill = Y)
                    
                    bookNewCartListBox = Listbox(createCartWindow, yscrollcommand = chooseBookNewCartScrollBar.set, width = 200, selectmode = MULTIPLE)
                    cursor.execute("select distinct title, purchase_type, book_condition, the_format, price, ISBN_13 from book where quantity > 0")
                    newCartBooks = list(cursor.fetchall())
                    
                    for newCartBook in newCartBooks:
                        bookNewCartListBox.insert(END, "Title = " + newCartBook[0] + ", Purchase Type = " + newCartBook[1] + ", Book Condition = " + newCartBook[2] + ", Format = " + newCartBook[3] + ", Price = " + str(newCartBook[4]))
                    
                    bookNewCartListBox.pack(side = LEFT, fill = BOTH)
                    chooseBookNewCartScrollBar.config(command = bookNewCartListBox.yview)
                    
                    def chooseNewCartBooksSelection():
                        newCartBookListIndex = list()
                        newCartBookList = list()
                        for listIndex in bookNewCartListBox.curselection():
                            newCartBookListIndex.append(listIndex)
                        for bookIndex in newCartBookListIndex:
                            newCartBookList.append(newCartBooks[bookIndex])
                        
                        createCartWindow.quit()
                        createCartWindow.destroy()
                        
                        booksQuantity = list()
                        for cartBookSelection in newCartBookList:
                            bookQuantityWindow = Tk()
                            bookQuantityWindow.configure(bg = "blue")
                            bookQuantityWindow.configure(width = 500)
                            bookQuantityWindow.configure(height = 200)
                            bookQuantityWindow.title("How many of the book?")
                            bookQuantityWindow.propagate(0)
                            
                            bookQuantityLabel = Label(bookQuantityWindow, text = ("How many of the book title = " + cartBookSelection[0] + ",\npurchase type = " + cartBookSelection[1] + ", book condition = " + cartBookSelection[2] + ", format = " + cartBookSelection[3] + " do you want?"))
                            bookQuantityLabel.pack(anchor = CENTER)
                            
                            #print(cartBookSelection)
                            cursor.execute("select distinct quantity from book where ISBN_13 = %s and purchase_type = %s and book_condition = %s and the_format = %s", (cartBookSelection[5], cartBookSelection[1], cartBookSelection[2], cartBookSelection[3]))
                            bookAvailableQuantity = cursor.fetchall()[0][0]
                            bookQuantitySpinBox = Spinbox(bookQuantityWindow, from_ = 1, to = bookAvailableQuantity)
                            bookQuantitySpinBox.pack(anchor = CENTER)
                            
                            def bookQuantitySelection():
                                booksQuantity.append(bookQuantitySpinBox.get())
                                bookQuantityWindow.quit()
                                bookQuantityWindow.destroy()
                            
                            bookQuantityButton = Button(bookQuantityWindow, text="Choose Selected Quantity", command=bookQuantitySelection)
                            bookQuantityButton.pack(anchor = CENTER)
                            
                            bookQuantityWindow.mainloop()
                            
                        newCartID = 1
                        newCartIDWorks = False
                        while newCartIDWorks == False:
                            cursor.execute("select count(cart_ID) from cart where cart_ID = %s", newCartID)
                            cartIDCount = cursor.fetchall()[0][0]
                            if cartIDCount == 0:
                                newCartIDWorks = True
                            elif cartIDCount > 0:
                                newCartID += 1
                            else:#Should never get here
                                raise EXCEPTION("Unexpected cartID count value!")
                        
                        cursor.execute("insert ignore into cart values(%s, %s, %s, null)", (newCartID, studentID, datetime.datetime.strptime(datetime.datetime.now().strftime('%m/%d/%Y'), "%m/%d/%Y").date()))
                        bookAdding = 0
                        for newCartBooking in newCartBookList:
                            cursor.execute("insert ignore into cart_books values(%s, %s, %s, %s, %s, %s)", (newCartID, newCartBooking[5], newCartBooking[1], newCartBooking[2], newCartBooking[3], booksQuantity[bookAdding]))
                            bookAdding += 1
                    
                    chooseNewBooksButton = Button(createCartWindow, text="Add selected book(s) to your cart", command=chooseNewCartBooksSelection)
                    chooseNewBooksButton.pack(anchor=CENTER)
                    
                    createCartWindow.mainloop()
                    
                elif numStudentCarts == 1:
                    modifyExistingCart()
                else:#Should never get here
                    raise EXCEPTION("Unexpected student cart amount: " + numStudentCarts + "!")
        except EXCEPTION as error:
            print("*********")
            print("Error in createCartModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Student's cart, if one exists, gets turned to an order.
    ########################################
    def cartToOrderModule(studentID):
        try:
            with connection.cursor() as cartOrderCursor:
                cartOrderCursor.execute("select count(distinct cart_ID) from cart where student_email = %s", studentID)
                numStudentCarts = cartOrderCursor.fetchall()[0][0]
                
                if numStudentCarts == 0:
                    tkMessageBox.showinfo("Create order", "You currently have no cart!")
                elif numStudentCarts == 1:
                    cartOrderCursor.execute("select distinct cart_ID from cart where student_email = %s", studentID)
                    cartID = cartOrderCursor.fetchall()[0][0]
                    cartOrderCursor.execute("select ISBN_13, purchase_type, book_condition, the_format, quantity from cart_books where cart_ID = %s", cartID)
                    cartBooks = list(cartOrderCursor.fetchall())
                    
                    for bookToOrder in cartBooks:
                        cartOrderCursor.execute("select quantity from book where ISBN_13 = %s and purchase_type = %s and book_condition = %s and the_format = %s", (bookToOrder[0], bookToOrder[1], bookToOrder[2], bookToOrder[3]))
                        if bookToOrder[4] > cartOrderCursor.fetchall()[0][0]:
                            tkMessageBox.showinfo("Error creating order", "For at least one book in your cart, the quantity ordered is greater than the amount available for the book!")
                            raise EXCEPTION("Quantity to be ordered for is greater than its available quantity!")
                    
                    cartOrderWindow = Tk()
                    cartOrderWindow.configure(bg = "blue")
                    cartOrderWindow.configure(width = 320)
                    cartOrderWindow.configure(height = 250)
                    cartOrderWindow.title("Choose info for your order")
                    cartOrderWindow.propagate(0)
                    
                    #'standard', '2-day', '1-day' shipping types
                    shippingTypeFrame = Frame(cartOrderWindow, bg = "blue")
                    shippingTypeLabel = Label(shippingTypeFrame, text = "Shipping Type")
                    shippingTypeLabel.pack(side = LEFT)
                    shippingTypeRadioFrame = Frame(shippingTypeFrame, bg = "blue")
                    shippingTypeRadioVar = IntVar(cartOrderWindow)
                    standardRadio = Radiobutton(shippingTypeRadioFrame, text="Standard", variable=shippingTypeRadioVar, value=1)
                    standardRadio.pack()
                    twoDayRadio = Radiobutton(shippingTypeRadioFrame, text="2-day", variable=shippingTypeRadioVar, value=2)
                    twoDayRadio.pack()
                    oneDayRadio = Radiobutton(shippingTypeRadioFrame, text="1-day", variable=shippingTypeRadioVar, value=3)
                    oneDayRadio.pack()
                    shippingTypeRadioFrame.pack(side = RIGHT)
                    shippingTypeFrame.pack()
                    
                    creditCardNumFrame = Frame(cartOrderWindow, bg = "blue")
                    creditCardNumLabel = Label(creditCardNumFrame, text = "Credit Card Number")
                    creditCardNumLabel.pack(side = LEFT)
                    creditCardNumEntry = Entry(creditCardNumFrame, bd = 1)
                    creditCardNumEntry.pack(side = RIGHT)
                    creditCardNumFrame.pack()
                    
                    creditCardMonthFrame = Frame(cartOrderWindow, bg = "blue")
                    creditCardMonthLabel = Label(creditCardMonthFrame, text = "Credit Card's Expiration Month:")
                    creditCardMonthLabel.pack(side = LEFT)
                    creditCardMonthSpinBox = Spinbox(creditCardMonthFrame, from_ = 1, to = 12)
                    creditCardMonthSpinBox.pack(side = RIGHT)
                    creditCardMonthFrame.pack()
                    
                    creditCardDayFrame = Frame(cartOrderWindow, bg = "blue")
                    creditCardDayLabel = Label(creditCardDayFrame, text = "Credit Card's Expiration Day:")
                    creditCardDayLabel.pack(side = LEFT)
                    creditCardDaySpinBox = Spinbox(creditCardDayFrame, from_ = 1, to = 31)
                    creditCardDaySpinBox.pack(side = RIGHT)
                    creditCardDayFrame.pack()
                    
                    creditCardYearFrame = Frame(cartOrderWindow, bg = "blue")
                    creditCardYearLabel = Label(creditCardYearFrame, text = "Credit Card's Expiration Year:")
                    creditCardYearLabel.pack(side = LEFT)
                    creditCardYearSpinBox = Spinbox(creditCardYearFrame, from_ = 2018, to = 2050)
                    creditCardYearSpinBox.pack(side = RIGHT)
                    creditCardYearFrame.pack()
                    
                    creditCardNameFrame = Frame(cartOrderWindow, bg = "blue")
                    creditCardNameLabel = Label(creditCardNameFrame, text = "Credit Card Name")
                    creditCardNameLabel.pack(side = LEFT)
                    creditCardNameEntry = Entry(creditCardNameFrame, bd = 1)
                    creditCardNameEntry.pack(side = RIGHT)
                    creditCardNameFrame.pack()
                    
                    creditCardTypeFrame = Frame(cartOrderWindow, bg = "blue")
                    creditCardTypeLabel = Label(creditCardTypeFrame, text = "Credit Card Type")
                    creditCardTypeLabel.pack(side = LEFT)
                    creditCardTypeEntry = Entry(creditCardTypeFrame, bd = 1)
                    creditCardTypeEntry.pack(side = RIGHT)
                    creditCardTypeFrame.pack()
                    
                    def creditCardButtonResponse():
                        with connection.cursor() as temporaryCursor:
                            orderID = 1
                            
                            temporaryCursor.execute("select count(distinct order_ID) from orders where order_ID = %s", orderID)
                            orderIDCount = temporaryCursor.fetchall()[0][0]
                            while orderIDCount > 0:
                                orderID += 1
                                temporaryCursor.execute("select count(distinct order_ID) from orders where order_ID = %s", orderID)
                                orderIDCount = temporaryCursor.fetchall()[0][0]
                            today = datetime.datetime.strptime(datetime.datetime.now().strftime('%m/%d/%Y'), "%m/%d/%Y").date()
                            shippingType = ""
                            if shippingTypeRadioVar.get() == 1:
                                shippingType = 'standard'
                            elif shippingTypeRadioVar.get() == 2:
                                shippingType = '2-day'
                            elif shippingTypeRadioVar.get() == 3:
                                shippingType = '1-day'
                            else:#Should never get here
                                print(shippingType)
                                raise EXCEPTION("Unexpected shipping type radio number!")
                            creditCardNum = creditCardNumEntry.get()
                            creditCardExpiration = creditCardMonthSpinBox.get() + "/" + creditCardDaySpinBox.get() + "/" + creditCardYearSpinBox.get()
                            creditCardExpirationObject = datetime.datetime.strptime(creditCardExpiration, "%m/%d/%Y").date()
                            creditCardName = creditCardNameEntry.get()
                            creditCardType = creditCardTypeEntry.get()
                            temporaryCursor.execute("insert ignore into orders values (%s, %s, %s, null, %s, %s, %s, %s, %s, 'new')", (orderID, studentID, today, shippingType, creditCardNum, creditCardExpirationObject, creditCardName, creditCardType))
                            for cartBook in cartBooks:
                                temporaryCursor.execute("update book set quantity = quantity - %s where ISBN_13 = %s and purchase_type = %s and book_condition = %s and the_format = %s", (cartBook[4], cartBook[0], cartBook[1], cartBook[2], cartBook[3]))
                                temporaryCursor.execute("insert ignore into order_books values (%s, %s, %s, %s, %s, %s)", (orderID, cartBook[0], cartBook[1], cartBook[2], cartBook[3], cartBook[4]))
                            
                            temporaryCursor.execute("delete from cart_books where cart_ID = %s", cartID)
                            temporaryCursor.execute("delete from cart where student_email = %s", studentID)
                            
                            cartOrderWindow.quit()
                            cartOrderWindow.destroy()
                        
                            tkMessageBox.showinfo("Order Created", "Your cart has been turned into an order!")
                    
                    creditCardButton = Button(cartOrderWindow, text = "Complete Order", command = creditCardButtonResponse)
                    creditCardButton.pack()
                    
                else:
                    print(numStudentCarts)
                    raise EXCEPTION("Unexpected numStudentCarts value!")
        except EXCEPTION as error:
            print("*********")
            print("Error in cartOrderModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Student Reviews Book
    ########################################
    def reviewBookModule(studentID):
        try:
            with connection.cursor() as reviewCursor:
                reviewWindow = Tk()
                reviewWindow.configure(bg = "blue")
                reviewWindow.configure(width = 1500)
                reviewWindow.configure(height = 300)
                reviewWindow.title("What book(s) would you like to review?")
                reviewWindow.propagate(0)
                
                reviewScrollBar = Scrollbar(reviewWindow)
                reviewScrollBar.pack(side = RIGHT, fill = Y)
                
                reviewListBox = Listbox(reviewWindow, yscrollcommand = reviewScrollBar.set, width = 200, selectmode = MULTIPLE)
                reviewCursor.execute("select distinct title, purchase_type, book_condition, the_format, ISBN_13 from book")
                reviewBooksList = reviewCursor.fetchall()
                
                for reviewBookList in reviewBooksList:
                    reviewListBox.insert(END, "Title = " + reviewBookList[0] + ", Purchase Type = " + reviewBookList[1] + ", Book Condition = " + reviewBookList[2] + ", Format = " + reviewBookList[3])
                
                reviewListBox.pack(side = LEFT, fill = BOTH)
                reviewScrollBar.config(command = reviewListBox.yview)
                
                def reviewButtonResponse():
                    reviewBookListIndex = list()
                    reviewBookList = list()
                    for newCartListIndex in reviewListBox.curselection():
                        reviewBookListIndex.append(newCartListIndex)
                    for newBookIndex in reviewBookListIndex:
                        reviewBookList.append(reviewBooksList[newBookIndex])
                    
                    for reviewBook in reviewBookList:
                        reviewBookWindow = Tk()
                        reviewBookWindow.configure(bg = "blue")
                        reviewBookWindow.configure(width = 500)
                        reviewBookWindow.configure(height = 125)
                        reviewBookWindow.title("Review the book")
                        reviewBookWindow.propagate(0)
                        
                        bookTitleLabel = Label(reviewBookWindow, text = "Title = " + reviewBook[0])
                        bookTitleLabel.pack()
                        
                        bookNumRatingFrame = Frame(reviewBookWindow, bg = "blue")
                        bookNumRatingLabel = Label(bookNumRatingFrame, text = "Rating (1-5): ")
                        bookNumRatingLabel.pack(side = LEFT)
                        bookNumRatingSpinBox = Spinbox(bookNumRatingFrame, from_ = 1, to = 5)
                        bookNumRatingSpinBox.pack(side = RIGHT)
                        bookNumRatingFrame.pack()
                        
                        bookTextReviewFrame = Frame(reviewBookWindow, bg = "blue")
                        bookTextReviewLabel = Label(bookTextReviewFrame, text = "Review: ")
                        bookTextReviewLabel.pack(side = LEFT)
                        bookTextReviewEntry = Entry(bookTextReviewFrame, bd = 1, width = 100)
                        bookTextReviewEntry.pack(side = RIGHT)
                        bookTextReviewFrame.pack()
                        
                        def reviewBookButtonResponse():
                            with connection.cursor() as newCursor:
                                newCursor.execute("insert ignore into book_rating values(%s, %s, %s, %s, %s, %s, %s)", (studentID, reviewBook[4], reviewBook[1], reviewBook[2], reviewBook[3], bookNumRatingSpinBox.get(), bookTextReviewEntry.get()))
                                newCursor.execute("update book set average_rating = (select avg(rating) from book_rating where ISBN_13 = %s and purchase_type = %s and book_condition = %s and the_format = %s) where ISBN_13 = %s and purchase_type = %s and book_condition = %s and the_format = %s", (reviewBook[4], reviewBook[1], reviewBook[2], reviewBook[3], reviewBook[4], reviewBook[1], reviewBook[2], reviewBook[3]))
                                reviewBookWindow.quit()
                                reviewBookWindow.destroy()
                        
                        reviewBookButton = Button(reviewBookWindow, text = "Review book", command = reviewBookButtonResponse)
                        reviewBookButton.pack()
                        
                        reviewBookWindow.mainloop()
                    
                    reviewWindow.quit()
                    reviewWindow.destroy()
                
                reviewButton = Button(reviewWindow, text = "Review Selected Book(s)", command = reviewButtonResponse)
                reviewButton.pack()
                
                reviewWindow.mainloop()
                
        except EXCEPTION as error:
            print("*********")
            print("Error in reviewBookModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Student modifies its cart.
    #######If student has no cart, creates one instead.
    ########################################
    def modifyCartModule(studentID):
        try:
            with connection.cursor() as cursor:
                cursor.execute("select count(distinct cart_ID) from cart where student_email = %s", studentID)
                numStudentCarts = cursor.fetchall()[0][0]
                
                if numStudentCarts == 0:
                    tkMessageBox.showinfo("Student's Cart", "You don't currently have a cart!\nHaving you create a cart instead!")
                    createCartModule(studentID)
                elif numStudentCarts  == 1:
                    cartModifyWhatDoWindow = Tk()
                    cartModifyWhatDoWindow.configure(bg = "blue")
                    cartModifyWhatDoWindow.configure(width = 250)
                    cartModifyWhatDoWindow.configure(height = 200)
                    cartModifyWhatDoWindow.title("What to do?")
                    cartModifyWhatDoWindow.propagate(0)
                    
                    cartModifyWhatToDoLabel = Label(cartModifyWhatDoWindow, text = "What do you want to do?")
                    cartModifyWhatToDoLabel.pack(anchor = N)
                    
                    cartModifyRadioVar = IntVar(cartModifyWhatDoWindow)
                    
                    def cartWhatDoSelection():
                        if cartModifyRadioVar.get() == 1:#Add to cart
                            addToCartModule(studentID)
                        elif cartModifyRadioVar.get() == 2:#Remove from cart
                            removeFromCartModule(studentID)
                        elif cartModifyRadioVar.get() == 3:#Delete cart
                            cursor.execute("select cart_ID from cart where student_email = %s", studentID)
                            studentCartID = cursor.fetchall()[0][0]
                            cursor.execute("delete from cart_books where cart_ID = %s", studentCartID)
                            cursor.execute("delete from cart where student_email = %s", studentID)
                            tkMessageBox.showinfo("Student's Cart Deleted", "Your cart was deleted!")
                            cartModifyWhatDoWindow.quit()
                            cartModifyWhatDoWindow.destroy()
                        elif cartModifyRadioVar.get() == 4:#Close window
                            cartModifyWhatDoWindow.quit()
                            cartModifyWhatDoWindow.destroy()
                        else:
                            print(cartModifyRadioVar.get())
                            raise EXCEPTION("Unkown cart do radio var value!")
                    
                    addToCartRadio = Radiobutton(cartModifyWhatDoWindow, text="Add Book(s) to Cart", variable=cartModifyRadioVar, value=1, command=cartWhatDoSelection)
                    addToCartRadio.pack(anchor = W)
                    
                    removeFromCartRadio = Radiobutton(cartModifyWhatDoWindow, text="Remove Book(s) From Cart", variable=cartModifyRadioVar, value=2, command=cartWhatDoSelection)
                    removeFromCartRadio.pack(anchor = W)
                    
                    deleteCartRadio = Radiobutton(cartModifyWhatDoWindow, text="Delete Cart", variable=cartModifyRadioVar, value=3, command=cartWhatDoSelection)
                    deleteCartRadio.pack(anchor = W)
                    
                    closeRadio = Radiobutton(cartModifyWhatDoWindow, text="Close", variable=cartModifyRadioVar, value=4, command=cartWhatDoSelection)
                    closeRadio.pack(anchor = W)
                    
                    cartModifyWhatDoWindow.mainloop()
                    
                else:
                    raise EXCEPTION("Unexpected number of student carts: " + numStudentCarts + "!")
        except EXCEPTION as error:
            print("*********")
            print("Error in modifyCartModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Student cancels one of its orders.
    #######Orders can be cancelled only if they haven't been shipped or cancelled already.
    #######Book quantity of books for the cancelled order increases appropriately. 
    ########################################
    def cancelOrderModule(studentID):
        try:
            with connection.cursor() as cancelCursor:
                cancelCursor.execute("select count(distinct order_ID) from orders where student_email = %s and order_status != 'shipped' and order_status != 'cancelled'", studentID)
                cancellableOrderCount = cancelCursor.fetchall()[0][0]
                
                if cancellableOrderCount == 0:
                    tkMessageBox.showinfo("Cancel Order", "You don't currently have an order that can be cancelled!")
                elif cancellableOrderCount > 0:
                    orderCancelWindow = Tk()
                    orderCancelWindow.configure(bg = "blue")
                    orderCancelWindow.configure(width = 425)
                    orderCancelWindow.configure(height = 100)
                    orderCancelWindow.title("Cancel order(s)")
                    orderCancelWindow.propagate(0)
                    
                    orderCancelScrollBar = Scrollbar(orderCancelWindow)
                    orderCancelScrollBar.pack(side = RIGHT, fill = Y)
                    
                    orderCancelListBox = Listbox(orderCancelWindow, yscrollcommand = orderCancelScrollBar.set, width = 42, selectmode = MULTIPLE)
                    cancelCursor.execute("select order_ID, date_created from orders where student_email = %s and order_status != 'shipped' and order_status != 'cancelled'", studentID)
                    ordersCanBeCancelled = list(cancelCursor.fetchall())
                    for orderCanBeCancelled in ordersCanBeCancelled:
                        orderCancelListBox.insert(END, "Order ID = " + orderCanBeCancelled[0] + " Order Date Created = " + orderCanBeCancelled[1].strftime('%m/%d/%Y'))
                    orderCancelListBox.pack(side = LEFT, fill = BOTH)
                    orderCancelScrollBar.config(command = orderCancelListBox.yview)
                    
                    def cancelOrderButtonSelection():
                        orderCancelListIndex = list(orderCancelListBox.curselection())
                        
                        orderCancelWindow.quit()
                        orderCancelWindow.destroy()
                        
                        orderCancelList = list()
                        for bookIndex in orderCancelListIndex:
                            orderCancelList.append(ordersCanBeCancelled[bookIndex])
                        
                        for orderCancel in orderCancelList:
                            cancelCursor.execute("update orders set order_status = 'cancelled' where order_ID = %s", orderCancel[0])
                            
                            cancelCursor.execute("select ISBN_13, purchase_type, book_condition, the_format, quantity from order_books where order_ID = %s", orderCancel[0])
                            cancelledBooks = list(cancelCursor.fetchall())
                            for cancelledBook in cancelledBooks:
                                cancelCursor.execute("update book set quantity = quantity + %s where ISBN_13 = %s and purchase_type = %s and book_condition = %s and the_format = %s", (cancelledBook[4], cancelledBook[0], cancelledBook[1], cancelledBook[2], cancelledBook[3]))
                        
                        tkMessageBox.showinfo("Canceled Order(s)", "Selected order(s) were cancelled!")
                        
                    
                    orderCancelButton = Button(orderCancelWindow, text="Cancel selected order(s)", command=cancelOrderButtonSelection)
                    orderCancelButton.pack(anchor=CENTER)
                    
                    orderCancelWindow.mainloop()
                    
                else:#Should never get here
                    print(cancellableOrderCount)
                    raise Exception("Unexpected cancdellable order count!")
                    
                
        except EXCEPTION as error:
            print("*********")
            print("Error in deleteCartModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Initial module for students
    ########################################
    def initialStudentModule(studentID):
        try:
            studentInitialWhatDoWindow = Tk()
            studentInitialWhatDoWindow.configure(bg = "blue")
            studentInitialWhatDoWindow.configure(width = 250)
            studentInitialWhatDoWindow.configure(height = 200)
            studentInitialWhatDoWindow.title("What to do?")
            studentInitialWhatDoWindow.propagate(0)
            
            studentInitialDoRadioVar = IntVar(studentInitialWhatDoWindow)
        
            def studentWhatDoRadioSelection():
                if studentInitialDoRadioVar.get() == 1:#Create cart
                    createCartModule(studentID)
                elif studentInitialDoRadioVar.get() == 2:#Turn cart to order
                    cartToOrderModule(studentID)
                elif studentInitialDoRadioVar.get() == 3:#Review a book
                    reviewBookModule(studentID)
                elif studentInitialDoRadioVar.get() == 4:#Update cart
                    modifyCartModule(studentID)
                elif studentInitialDoRadioVar.get() == 5:#Cancel an order
                    cancelOrderModule(studentID)
                elif studentInitialDoRadioVar.get() == 6:#Return to main screen
                    studentInitialWhatDoWindow.quit()
                    studentInitialWhatDoWindow.destroy()
                    initialScreenModule()
                elif studentInitialDoRadioVar.get() == 7:#Exit window
                    studentInitialWhatDoWindow.quit()
                    studentInitialWhatDoWindow.destroy()
                else:#Shouldn't ever get here
                    print(studentInitialDoRadioVar.get())
                    raise EXCEPTION("Unknown student what do radio selection!")
                    
            
            studentWhatDoLabel = Label(studentInitialWhatDoWindow, text = "What do you want to do?")
            studentWhatDoLabel.pack(anchor = N)
            
            createCartRadio = Radiobutton(studentInitialWhatDoWindow, text="Create Cart", variable=studentInitialDoRadioVar, value=1, command=studentWhatDoRadioSelection)
            createCartRadio.pack(anchor = W)
            
            cartToOrderRadio = Radiobutton(studentInitialWhatDoWindow, text="Turn Cart to Order", variable=studentInitialDoRadioVar, value=2, command=studentWhatDoRadioSelection)
            cartToOrderRadio.pack(anchor = W)
            
            reviewBookRadio = Radiobutton(studentInitialWhatDoWindow, text="Review a Book", variable=studentInitialDoRadioVar, value=3, command=studentWhatDoRadioSelection)
            reviewBookRadio.pack(anchor = W)
            
            updateCartRadio = Radiobutton(studentInitialWhatDoWindow, text="Update Your Cart", variable=studentInitialDoRadioVar, value=4, command=studentWhatDoRadioSelection)
            updateCartRadio.pack(anchor = W)
            
            cancelOrderRadio = Radiobutton(studentInitialWhatDoWindow, text="Cancel an Order", variable=studentInitialDoRadioVar, value=5, command=studentWhatDoRadioSelection)
            cancelOrderRadio.pack(anchor = W)
            
            logoutRadio = Radiobutton(studentInitialWhatDoWindow, text = "Logout", variable = studentInitialDoRadioVar, value = 6, command = studentWhatDoRadioSelection)
            logoutRadio.pack(anchor = W)
            
            exitRadio = Radiobutton(studentInitialWhatDoWindow, text="Exit", variable=studentInitialDoRadioVar, value=7, command=studentWhatDoRadioSelection)
            exitRadio.pack(anchor = W)
            
            studentInitialWhatDoWindow.mainloop()
            
        except EXCEPTION as error:
            print("*********")
            print("Error in initialStudentModule!")
            print(error)
            print("*********")

    ########################################
    #######Create new trouble ticket
    ########################################
    def createNewTicketCustomerServiceModule(customerServiceEmployeesID):
        try:
            with connection.cursor() as cursor:
                createNewTicketWindow = Tk()
                createNewTicketWindow.configure(bg = "blue")
                createNewTicketWindow.configure(width = 310)
                createNewTicketWindow.configure(height = 110)
                createNewTicketWindow.title("Create a new trouble ticket")
                createNewTicketWindow.propagate(0)
                
                newCategoryFrame = Frame(createNewTicketWindow, bg = "blue")
                newCategoryLabel = Label(newCategoryFrame, text = "Trouble Ticket's Category:")
                newCategoryLabel.pack(side = LEFT)
                newCategoryEntry = Entry(newCategoryFrame, bd = 1)
                newCategoryEntry.pack(side = RIGHT)
                newCategoryFrame.pack()
                
                newTitleFrame = Frame(createNewTicketWindow, bg = "blue")
                newTitleLabel = Label(newTitleFrame, text = "Trouble Ticket's Title:")
                newTitleLabel.pack(side = LEFT)
                newTitleEntry = Entry(newTitleFrame, bd = 1)
                newTitleEntry.pack(side = RIGHT)
                newTitleFrame.pack()
                
                newProblemFrame = Frame(createNewTicketWindow, bg = "blue")
                newProblemLabel = Label(newProblemFrame, text = "Trouble Ticket's Problem:")
                newProblemLabel.pack(side = LEFT)
                newProblemEntry = Entry(newProblemFrame, bd = 1)
                newProblemEntry.pack(side = RIGHT)
                newProblemFrame.pack()
                
                def createTicketButtonSelection():
                    newTicketIDWorks = False
                    newTicketIDNum = 131
                    while newTicketIDWorks == False:
                        cursor.execute("select count(ticket_ID) from trouble_ticket where ticket_ID = %s", 'T' + str(newTicketIDNum))
                        ticketIDCount = cursor.fetchall()[0][0]
                        if ticketIDCount == 0:
                            newTicketIDWorks = True
                        elif ticketIDCount > 0:
                            newTicketIDNum += 1
                        else:#Should never get here
                            raise EXCEPTION("Unexpected ticketID count value!")
                    
                    newTicketCategory = newCategoryEntry.get()
                    now = datetime.datetime.strptime(datetime.datetime.now().strftime('%m/%d/%Y'), "%m/%d/%Y").date()
                    newTicketTitle = newTitleEntry.get()
                    newTicketDescription = newProblemEntry.get()
                    
                    cursor.execute("insert ignore into trouble_ticket values(%s, %s, %s, %s, null, %s, null, %s, null)", ('T' + str(newTicketIDNum), newTicketCategory, now, newTicketTitle, newTicketDescription, 'new'))
                    cursor.execute("insert ignore into trouble_ticket_employee values(%s, %s)", ('T' + str(newTicketIDNum), customerServiceEmployeesID))
                    
                    createNewTicketWindow.quit()
                    createNewTicketWindow.destroy()
                
                troubleTicketCreateButton = Button(createNewTicketWindow, text="Create trouble ticket", command=createTicketButtonSelection)
                troubleTicketCreateButton.pack(anchor=CENTER)
                
                createNewTicketWindow.mainloop()
        
        except EXCEPTION as error:
            print("*********")
            print("Error in createNewTroubleTicketModuleCustomerService!")
            print(error)
            print("*********")
    
    ########################################
    #######Customer Service Employee Modifies Tickets
    ########################################
    def modifyTicketCustomerServiceModule(customerServicesEmployeesID):
        try:
            with connection.cursor() as cursor:
                cursor.execute("select count(ticket_ID) from trouble_ticket where state = 'new'")
                numModifiableTickets = cursor.fetchall()[0][0]
                
                cursor.execute("select count(ticket_ID) from trouble_ticket where state = 'new'")
                numAdministrators = cursor.fetchall()[0][0]
                
                if numModifiableTickets == 0:
                    tkMessageBox.showinfo("Trouble Ticket Modification", "There are no tickets you can modify!")
                elif numAdministrators == 0:
                    tkMessageBox.showinfo("Trouble Ticket Modification", "There are no administrators you can assign a ticket to!")
                elif numModifiableTickets > 0 and numAdministrators > 0:
                    modifyTicketCustomerServiceWindow = Tk()
                    modifyTicketCustomerServiceWindow.configure(bg = "blue")
                    modifyTicketCustomerServiceWindow.configure(width = 1025)
                    modifyTicketCustomerServiceWindow.configure(height = 175)
                    modifyTicketCustomerServiceWindow.title("Choose the ticket and the administrator to assign it to")
                    modifyTicketCustomerServiceWindow.propagate(0)
                    
                    #Creating list box for ticket to be assigned
                    selectTicketCustomerServiceFrame = Frame(modifyTicketCustomerServiceWindow, bg = "blue")
                    
                    chooseTicketCustomerServiceScrollBar = Scrollbar(selectTicketCustomerServiceFrame)
                    chooseTicketCustomerServiceScrollBar.pack(side = LEFT, fill = Y)
                    
                    ticketsCustomerServiceListBox = Listbox(selectTicketCustomerServiceFrame, yscrollcommand = chooseTicketCustomerServiceScrollBar.set, width = 60, exportselection = 0)
                    cursor.execute("select distinct ticket_ID, title from trouble_ticket where state = 'new'")
                    chooseTicketsCustomerService = list(cursor.fetchall())
                    
                    for chooseTicketCustomerService in chooseTicketsCustomerService:
                        ticketsCustomerServiceListBox.insert(END, "Ticket ID = " + chooseTicketCustomerService[0] + "  Title = " + chooseTicketCustomerService[1])
                    
                    ticketsCustomerServiceListBox.pack(side = RIGHT, fill = BOTH)
                    chooseTicketCustomerServiceScrollBar.config(command = ticketsCustomerServiceListBox.yview)
                    
                    selectTicketCustomerServiceFrame.pack(side = LEFT)
                    
                    #Creating list box for administrator to assign the ticket to
                    selectAdministratorCustomerServiceFrame = Frame(modifyTicketCustomerServiceWindow, bg = "blue")
                    
                    chooseAdministratorCustomerServiceScrollBar = Scrollbar(selectAdministratorCustomerServiceFrame)
                    chooseAdministratorCustomerServiceScrollBar.pack(side = RIGHT, fill = Y)
                    
                    administratorsCustomerServiceListBox = Listbox(selectAdministratorCustomerServiceFrame, yscrollcommand = chooseAdministratorCustomerServiceScrollBar.set, width = 60, exportselection = 0)
                    cursor.execute("select distinct SSN, employee_ID, first_name, last_name from employee where job = 'Administrators' or job = 'SuperAdministrators'")
                    chooseAdministratorsCustomerService = list(cursor.fetchall())
                    
                    for chooseAdministratorCustomerService in chooseAdministratorsCustomerService:
                        administratorsCustomerServiceListBox.insert(END, "Administrator ID = " + chooseAdministratorCustomerService[1] + "  Name = " + chooseAdministratorCustomerService[2] + " " + chooseAdministratorCustomerService[3])
                    
                    administratorsCustomerServiceListBox.pack(side = LEFT, fill = BOTH)
                    chooseAdministratorCustomerServiceScrollBar.config(command = administratorsCustomerServiceListBox.yview)
                    
                    selectAdministratorCustomerServiceFrame.pack(side = RIGHT)
                    
                    def modifyTicketSelection():
                        ticketID = chooseTicketsCustomerService[ticketsCustomerServiceListBox.curselection()[0]][0]
                        administratorID = chooseAdministratorsCustomerService[administratorsCustomerServiceListBox.curselection()[0]][0]
                        cursor.execute("update trouble_ticket set fixer_ID = %s where ticket_ID = %s", (administratorID, ticketID))
                        modifyTicketCustomerServiceWindow.quit()
                        modifyTicketCustomerServiceWindow.destroy()
                    
                    chooseBooksButton = Button(modifyTicketCustomerServiceWindow, text="Assign selected ticket to selected administrator", command = modifyTicketSelection)
                    chooseBooksButton.pack(side = BOTTOM)
                    
                    modifyTicketCustomerServiceWindow.mainloop()
                    
                else:#Should never get here
                    print(numModifiableTickets)
                    raise EXCEPTION("Negative number of tickets!")
                
        except EXCEPTION as error:
            print("*********")
            print("Error in initialCustomerServiceModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Initial module for customer service employees
    ########################################
    def initialCustomerServiceModule(customerServiceEmployeeID):
        try:
            initialCustomerServiceWindow = Tk()
            initialCustomerServiceWindow.configure(bg = "blue")
            initialCustomerServiceWindow.configure(width = 310)
            initialCustomerServiceWindow.configure(height = 125)
            initialCustomerServiceWindow.title("What do you want to do?")
            initialCustomerServiceWindow.propagate(0)
            
            customerServiceDoRadioVar = IntVar()
            
            def customerServiceWhatDoSelection():
                if customerServiceDoRadioVar.get() == 1:#Create trouble ticket
                    createNewTicketCustomerServiceModule(customerServiceEmployeeID)
                elif customerServiceDoRadioVar.get() == 2:#Modify trouble ticket
                    modifyTicketCustomerServiceModule(customerServiceEmployeeID)
                elif customerServiceDoRadioVar.get() == 3:#Logout
                    initialCustomerServiceWindow.quit()
                    initialCustomerServiceWindow.destroy()
                    initialScreenModule()
                elif customerServiceDoRadioVar.get() == 4:#Exit
                    initialCustomerServiceWindow.quit()
                    initialCustomerServiceWindow.destroy()
                else:
                    print(customerServiceDoRadioVar.get())
                    raise EXCEPTION("Unknown customer service what do radio selection!")
            
            customerServiceLabel = Label(initialCustomerServiceWindow, text = "What do you want to do?")
            customerServiceLabel.pack(anchor = W)
            
            createNewTicketRadio = Radiobutton(initialCustomerServiceWindow, text="Create a new trouble ticket", variable=customerServiceDoRadioVar, value=1, command = customerServiceWhatDoSelection)
            createNewTicketRadio.pack(anchor = W)
            
            updateTicketRadio = Radiobutton(initialCustomerServiceWindow, text="Update a trouble ticket", variable=customerServiceDoRadioVar, value=2, command = customerServiceWhatDoSelection)
            updateTicketRadio.pack(anchor = W)
            
            logoutRadio = Radiobutton(initialCustomerServiceWindow, text = "Logout", variable = customerServiceDoRadioVar, value = 3, command = customerServiceWhatDoSelection)
            logoutRadio.pack(anchor = W)
            
            exitRadio = Radiobutton(initialCustomerServiceWindow, text = "Exit", variable = customerServiceDoRadioVar, value = 4, command = customerServiceWhatDoSelection)
            exitRadio.pack(anchor = W)
            
            initialCustomerServiceWindow.mainloop()
        
        except EXCEPTION as error:
            print("*********")
            print("Error in initialCustomerServiceModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Create book with inventory
    ########################################
    def createBookModule(administratorID):
        try:
            with connection.cursor() as cursor:
                createBookWindow = Tk()
                createBookWindow.configure(bg = "blue")
                createBookWindow.configure(width = 425)
                createBookWindow.configure(height = 250)
                createBookWindow.title("Create a book")
                createBookWindow.propagate(0)
                
                newISBNFrame = Frame(createBookWindow, bg = "blue")
                newISBNLabel = Label(newISBNFrame, text = "Book's ISBN:")
                newISBNLabel.pack(side = LEFT)
                newISBNEntry = Entry(newISBNFrame, bd = 1, width = 15)
                newISBNEntry.pack(side = RIGHT)
                newISBNFrame.pack()
            
        except EXCEPTION as error:
            print("*********")
            print("Error in createBookModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Initial module for administrators
    ########################################
    def initialAdministratorModule(administratorID):
        try:
            initialAdministratorWindow = Tk()
            initialAdministratorWindow.configure(bg = "blue")
            initialAdministratorWindow.configure(width = 425)
            initialAdministratorWindow.configure(height = 150)
            initialAdministratorWindow.title("What do you want to do?")
            initialAdministratorWindow.propagate(0)
            
            administratorDoRadioVar = IntVar()
            
            def administratorWhatDoSelection():
                if administratorDoRadioVar.get() == 1:#Create book with inventory
                    print("TODO")
                elif administratorDoRadioVar.get() == 2:#Create new university with departments and courses with book associations
                    print("TODO")
                elif administratorDoRadioVar.get() == 3:#Logout
                    initialAdministratorWindow.quit()
                    initialAdministratorWindow.destroy()
                    initialScreenModule()
                elif administratorDoRadioVar.get() == 4:#Exit
                    initialAdministratorWindow.quit()
                    initialAdministratorWindow.destroy()
                else:#Should never get here
                    print(administratorDoRadioVar.get())
                    raise EXCEPTION("Unknown customer service what do radio selection!")
            
            administratorLabel = Label(initialAdministratorWindow, text = "What do you want to do?")
            administratorLabel.pack(anchor = W)
            
            createNewBookRadio = Radiobutton(initialAdministratorWindow, text="Create a new book with inventory", variable=administratorDoRadioVar, value=1, command = administratorWhatDoSelection)
            createNewBookRadio.pack(anchor = W)
            
            createNewUniversityRadio = Radiobutton(initialAdministratorWindow, text="Create a new university with departments and courses with book associations", variable=administratorDoRadioVar, value=2, command = administratorWhatDoSelection)
            createNewUniversityRadio.pack(anchor = W)
            
            logoutRadio = Radiobutton(initialAdministratorWindow, text = "Logout", variable = administratorDoRadioVar, value = 3, command = administratorWhatDoSelection)
            logoutRadio.pack(anchor = W)
            
            exitRadio = Radiobutton(initialAdministratorWindow, text = "Exit", variable = administratorDoRadioVar, value = 4, command = administratorWhatDoSelection)
            exitRadio.pack(anchor = W)
            
            initialAdministratorWindow.mainloop()
        
        except EXCEPTION as error:
            print("*********")
            print("Error in initialAdministratorModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Initial module for super administrator
    ########################################
    def initialSuperAdministratorModule(superAdministratorID):
        try:
            initialSuperAdministratorWindow = Tk()
            initialSuperAdministratorWindow.configure(bg = "blue")
            initialSuperAdministratorWindow.configure(width = 425)
            initialSuperAdministratorWindow.configure(height = 200)
            initialSuperAdministratorWindow.title("What do you want to do?")
            initialSuperAdministratorWindow.propagate(0)
            
            superAdministratorDoRadioVar = IntVar()
            
            administratorLabel = Label(initialSuperAdministratorWindow, text = "What do you want to do?")
            administratorLabel.pack(anchor = W)
            
            createNewBookRadio = Radiobutton(initialSuperAdministratorWindow, text="Create a new book with inventory", variable=superAdministratorDoRadioVar, value=1)
            createNewBookRadio.pack(anchor = W)
            
            createUniversityRadio = Radiobutton(initialSuperAdministratorWindow, text="Create a new university with departments, courses, & book associations", variable=superAdministratorDoRadioVar, value=2)
            createUniversityRadio.pack(anchor = W)
            
            createCustomerServiceEmployee = Radiobutton(initialSuperAdministratorWindow, text = "Create a new customer service employee", variable = superAdministratorDoRadioVar, value = 3)
            createCustomerServiceEmployee.pack(anchor = W)
            
            deleteAdministrator = Radiobutton(initialSuperAdministratorWindow, text = "Delete an administrator", variable = superAdministratorDoRadioVar, value = 4)
            deleteAdministrator.pack(anchor = W)
            
            logoutRadio = Radiobutton(initialSuperAdministratorWindow, text = "Logout", variable = superAdministratorDoRadioVar, value = 5)
            logoutRadio.pack(anchor = W)
            
            exitRadio = Radiobutton(initialSuperAdministratorWindow, text = "Exit", variable = superAdministratorDoRadioVar, value = 6)
            exitRadio.pack(anchor = W)
            
            initialSuperAdministratorWindow.mainloop()
        
        except EXCEPTION as error:
            print("*********")
            print("Error in initialAdministratorModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Choose existing student module
    ########################################
    def chooseExistingStudentModule():
        try:
            with connection.cursor() as cursor:
                chooseStudentWindow = Tk()
                chooseStudentWindow.configure(bg = "blue")
                chooseStudentWindow.configure(width = 500)
                chooseStudentWindow.configure(height = 300)
                chooseStudentWindow.title("Which student are you?")
                chooseStudentWindow.propagate(0)
                
                chooseStudentScrollBar = Scrollbar(chooseStudentWindow)
                chooseStudentScrollBar.pack(side = RIGHT, fill = Y)
                
                studentListBox = Listbox(chooseStudentWindow, yscrollcommand = chooseStudentScrollBar.set, width = 60)
                cursor.execute("select distinct student_email, first_name, last_name from student")
                studentEmails = list(cursor.fetchall())
                
                for studentEmail in studentEmails:
                    studentListBox.insert(END, "Email = " + studentEmail[0] + " Name = " + studentEmail[1] + " " + studentEmail[2])
                
                studentListBox.pack(side = LEFT, fill = BOTH)
                chooseStudentScrollBar.config(command = studentListBox.yview)
                
                def chooseStudentButtonSelection():
                    studentID = studentEmails[studentListBox.curselection()[0]][0]
                    chooseStudentWindow.quit()
                    chooseStudentWindow.destroy()
                    initialStudentModule(studentID)
                
                chooseStudentButton = Button(chooseStudentWindow, text="Choose the student", command=chooseStudentButtonSelection)
                chooseStudentButton.pack(anchor=CENTER)
                
                chooseStudentWindow.mainloop()
                
        except EXCEPTION as error:
            print("*********")
            print("Error in chooseStudentModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Choose whether new or existing student module
    ########################################
    def createNewStudentModule():
        try:
            with connection.cursor() as cursor:
                createNewStudentWindow = Tk()
                createNewStudentWindow.configure(bg = "blue")
                createNewStudentWindow.configure(width = 285)
                createNewStudentWindow.configure(height = 375)
                createNewStudentWindow.title("Create a new student")
                createNewStudentWindow.propagate(0)
                
                newEmailFrame = Frame(createNewStudentWindow, bg = "blue")
                newEmailLabel = Label(newEmailFrame, text = "Student's email:")
                newEmailLabel.pack(side = LEFT)
                newEmailEntry = Entry(newEmailFrame, bd = 1)
                newEmailEntry.pack(side = RIGHT)
                newEmailFrame.pack()
                
                newFirstNameFrame = Frame(createNewStudentWindow, bg = "blue")
                newFirstNameLabel = Label(newFirstNameFrame, text = "Student's first name:")
                newFirstNameLabel.pack(side = LEFT)
                newFirstNameEntry = Entry(newFirstNameFrame, bd = 1)
                newFirstNameEntry.pack(side = RIGHT)
                newFirstNameFrame.pack()
                
                newLastNameFrame = Frame(createNewStudentWindow, bg = "blue")
                newLastNameLabel = Label(newLastNameFrame, text = "Student's last name:")
                newLastNameLabel.pack(side = LEFT)
                newLastNameEntry = Entry(newLastNameFrame, bd = 1)
                newLastNameEntry.pack(side = RIGHT)
                newLastNameFrame.pack()
                
                newAddressFrame = Frame(createNewStudentWindow, bg = "blue")
                newAddressLabel = Label(newAddressFrame, text = "Student's address:")
                newAddressLabel.pack(side = LEFT)
                newAddressEntry = Entry(newAddressFrame, bd = 1)
                newAddressEntry.pack(side = RIGHT)
                newAddressFrame.pack()
                
                newBirthMonthFrame = Frame(createNewStudentWindow, bg = "blue")
                newBirthMonthLabel = Label(newBirthMonthFrame, text = "Student's birth month:")
                newBirthMonthLabel.pack(side = LEFT)
                newBirthMonthSpinBox = Spinbox(newBirthMonthFrame, from_ = 1, to = 12)
                newBirthMonthSpinBox.pack(side = RIGHT)
                newBirthMonthFrame.pack()
                
                newBirthDayFrame = Frame(createNewStudentWindow, bg = "blue")
                newBirthDayLabel = Label(newBirthDayFrame, text = "Student's birth day:")
                newBirthDayLabel.pack(side = LEFT)
                newBirthDaySpinBox = Spinbox(newBirthDayFrame, from_ = 1, to = 31)
                newBirthDaySpinBox.pack(side = RIGHT)
                newBirthDayFrame.pack()
                
                newBirthYearFrame = Frame(createNewStudentWindow, bg = "blue")
                newBirthYearLabel = Label(newBirthYearFrame, text = "Student's birth year:")
                newBirthYearLabel.pack(side = LEFT)
                newBirthYearSpinBox = Spinbox(newBirthYearFrame, from_ = 1899, to = 2018)
                newBirthYearSpinBox.pack(side = RIGHT)
                newBirthYearFrame.pack()
                
                newUniversityFrame = Frame(createNewStudentWindow, bg = "blue")
                newUniversityLabel = Label(newUniversityFrame, text = "Student's university:")
                newUniversityLabel.pack(side = LEFT)
                newUniversityListBox = Listbox(newUniversityFrame, height = 6)
                cursor.execute("select distinct university_name from university")
                newUniversityNames = list(cursor.fetchall())
                for newUniversityName in newUniversityNames:
                    newUniversityListBox.insert(END, newUniversityName[0])
                newUniversityListBox.pack(side = RIGHT)
                newUniversityFrame.pack()
                
                newMajorFrame = Frame(createNewStudentWindow, bg = "blue")
                newMajorLabel = Label(newMajorFrame, text = "Student's major:")
                newMajorLabel.pack(side = LEFT)
                newMajorEntry = Entry(newMajorFrame, bd = 1)
                newMajorEntry.pack(side = RIGHT)
                newMajorFrame.pack()
                
                newStatusFrame = Frame(createNewStudentWindow, bg = "blue")
                newStatusLabel = Label(newStatusFrame, text = "Student's status:")
                newStatusLabel.pack(side = LEFT)
                newStatusRadioVar = IntVar(createNewStudentWindow)
                newStatusRadioFrame = Frame(newStatusFrame, bg = "blue")
                newUndergraduateRadio = Radiobutton(newStatusRadioFrame, text="Undergraduate", variable=newStatusRadioVar, value=1)
                newUndergraduateRadio.pack()
                newGraduateRadio = Radiobutton(newStatusRadioFrame, text="Graduate", variable=newStatusRadioVar, value=2)
                newGraduateRadio.pack()
                newStatusRadioFrame.pack(side = RIGHT)
                newStatusFrame.pack()
                
                newYearFrame = Frame(createNewStudentWindow, bg = "blue")
                newYearLabel = Label(newYearFrame, text = "Student's year:")
                newYearLabel.pack(side = LEFT)
                newYearSpinBox = Spinbox(newYearFrame, from_ = 1, to = 10)
                newYearSpinBox.pack(side = RIGHT)
                newYearFrame.pack()
                
                newPhoneNumFrame = Frame(createNewStudentWindow, bg = "blue")
                newPhoneNumLabel = Label(newPhoneNumFrame, text = "Student's phone #(s) (separated\nby comma no space):")
                newPhoneNumLabel.pack(side = LEFT)
                newPhoneNumEntry = Entry(newPhoneNumFrame, bd = 1)
                newPhoneNumEntry.pack(side = RIGHT)
                
                def createNewStudentButtonSelection():
                    newEmail = newEmailEntry.get()
                    newFirstName = newFirstNameEntry.get()
                    newLastName = newLastNameEntry.get()
                    newAddress = newAddressEntry.get()
                    newBirthDate = newBirthMonthSpinBox.get() + "/" + newBirthDaySpinBox.get() + "/" + newBirthYearSpinBox.get()
                    newBirthDateObject = datetime.datetime.strptime(newBirthDate, "%m/%d/%Y").date()
                    newUniversityName = newUniversityListBox.get(ACTIVE)
                    cursor.execute("select distinct university_ID from university where university_name = %s", newUniversityName)
                    newUniversityID = cursor.fetchall()[0][0]
                    newMajor = newMajorEntry.get()
                    newStatus = ""
                    if newStatusRadioVar.get() == 1:
                        newStatus = "UnderGrad"
                    elif newStatusRadioVar.get() == 2:
                        newStatus = "Grad"
                    else:
                        print(newStatusRadioVar.get())
                        print("Unknown status radio var value!")
                    newYear = newYearSpinBox.get()
                    newPhoneNums = newPhoneNumEntry.get().split(",")
                    
                    cursor.execute("insert ignore into student values(%s, %s, %s, %s, %s, %s, %s, %s, %s)", (newEmail,
                    newFirstName, newLastName, newAddress, newBirthDateObject, newUniversityID, newMajor, newStatus, newYear))
                    for newPhoneNum in newPhoneNums:
                        cursor.execute("insert ignore into student_phone_num values (%s, %s)", (newEmail, newPhoneNum))
                    
                    createNewStudentWindow.quit()
                    createNewStudentWindow.destroy()    
                    initialStudentModule(newEmail)
                
                createNewStudentButton = Button(createNewStudentWindow, text="Create new student", command=createNewStudentButtonSelection)
                createNewStudentButton.pack()
                
                createNewStudentWindow.mainloop()
                    
        except EXCEPTION as error:
            print("*********")
            print("Error in createNewStudentModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Choose whether new or existing student module
    ########################################
    def chooseNewExistingStudentModule():
        try:
            newExistingStudentWindow = Tk()
            newExistingStudentWindow.configure(bg = "blue")
            newExistingStudentWindow.configure(width = 350)
            newExistingStudentWindow.configure(height = 100)
            newExistingStudentWindow.title("Are you a new or existing student?")
            newExistingStudentWindow.propagate(0)
            
            newExistingStudentRadioVar = IntVar(newExistingStudentWindow)
            
            def newExistingStudentRadioButtonSelection():
                if newExistingStudentRadioVar.get() == 1:#Existing student
                    newExistingStudentWindow.quit()
                    newExistingStudentWindow.destroy()
                    chooseExistingStudentModule()
                elif newExistingStudentRadioVar.get() == 2:#New student
                    newExistingStudentWindow.quit()
                    newExistingStudentWindow.destroy()
                    createNewStudentModule()
                else:#Should never get here
                    print(newExistingStudentRadioVar.get())
                    raise EXCEPTION("Unknown new existing student radio button selection!")
            
            initialRadioLabel = Label(newExistingStudentWindow, text = "Are you a new or existing student?")
            initialRadioLabel.pack(anchor = N)
            
            existingStudentRadio = Radiobutton(newExistingStudentWindow, text="Existing Student", variable=newExistingStudentRadioVar, value=1, command=newExistingStudentRadioButtonSelection)
            existingStudentRadio.pack(anchor = W)
            
            newStudentRadio = Radiobutton(newExistingStudentWindow, text="New Student", variable=newExistingStudentRadioVar, value=2, command=newExistingStudentRadioButtonSelection)
            newStudentRadio.pack(anchor = W)
            
            newExistingStudentWindow.mainloop()
        except:
            print("*********")
            print("Error in chooseNewExistingStudentModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Choose customer service employee module
    ########################################
    def chooseCustomerServiceEmployeeModule():
        try:
            with connection.cursor() as cursor:
                chooseCustomerServiceWindow = Tk()
                chooseCustomerServiceWindow.configure(bg = "blue")
                chooseCustomerServiceWindow.configure(width = 500)
                chooseCustomerServiceWindow.configure(height = 250)
                chooseCustomerServiceWindow.title("Which customer service employee are you?")
                chooseCustomerServiceWindow.propagate(0)
                
                chooseCustomerServiceScrollBar = Scrollbar(chooseCustomerServiceWindow)
                chooseCustomerServiceScrollBar.pack(side = RIGHT, fill = Y)
                
                customerServiceListBox = Listbox(chooseCustomerServiceWindow, yscrollcommand = chooseCustomerServiceScrollBar.set, width = 40)
                cursor.execute("select distinct SSN, first_name, last_name from employee where job = 'Customer Support'")
                customerServiceIDs = list(cursor.fetchall())
                
                for customerServiceID in customerServiceIDs:
                    customerServiceListBox.insert(END, "SSN: " + customerServiceID[0] + " Name: " + customerServiceID[1] + " " + customerServiceID[2])
                
                customerServiceListBox.pack(side = LEFT, fill = BOTH)
                chooseCustomerServiceScrollBar.config(command = customerServiceListBox.yview)
                
                def chooseCustomerServiceButtonSelection():
                    customerServiceEmployeeID = customerServiceIDs[customerServiceListBox.curselection()[0]][0]
                    print(customerServiceEmployeeID)
                    chooseCustomerServiceWindow.quit()
                    chooseCustomerServiceWindow.destroy()
                    initialCustomerServiceModule(customerServiceEmployeeID)
                
                chooseCustomerServiceButton = Button(chooseCustomerServiceWindow, text="Choose the customer service employee", command=chooseCustomerServiceButtonSelection)
                chooseCustomerServiceButton.pack(anchor=CENTER)
                
                chooseCustomerServiceWindow.mainloop()
                
        except EXCEPTION as error:
            print("*********")
            print("Error in chooseCustomerServiceEmployeeModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Choose administrator module
    ########################################
    def chooseAdministratorModule():
        try:
            with connection.cursor() as cursor:
                chooseAdministratorWindow = Tk()
                chooseAdministratorWindow.configure(bg = "blue")
                chooseAdministratorWindow.configure(width = 450)
                chooseAdministratorWindow.configure(height = 225)
                chooseAdministratorWindow.title("Which administrator are you?")
                chooseAdministratorWindow.propagate(0)
                
                chooseAdministratorScrollBar = Scrollbar(chooseAdministratorWindow)
                chooseAdministratorScrollBar.pack(side = RIGHT, fill = Y)
                
                administratorListBox = Listbox(chooseAdministratorWindow, yscrollcommand = chooseAdministratorScrollBar.set, width = 45)
                cursor.execute("select distinct SSN, first_name, last_name from employee where job = 'Administrators'")
                administratorIDs = list(cursor.fetchall())
                
                for administratorID in administratorIDs:
                    administratorListBox.insert(END, "SSN = " + administratorID[0] + " Name = " + administratorID[1] + " " + administratorID[2])
                
                administratorListBox.pack(side = LEFT, fill = BOTH)
                chooseAdministratorScrollBar.config(command = administratorListBox.yview)
                
                def chooseAdministratorButtonSelection():
                    administratorID = administratorIDs[administratorListBox.curselection()[0]][0]
                    chooseAdministratorWindow.quit()
                    chooseAdministratorWindow.destroy()
                    initialAdministratorModule(administratorID)
                
                chooseAdministratorButton = Button(chooseAdministratorWindow, text="Choose the administrator", command=chooseAdministratorButtonSelection)
                chooseAdministratorButton.pack(anchor=CENTER)
                
                chooseAdministratorWindow.mainloop()
                
        except EXCEPTION as error:
            print("*********")
            print("Error in chooseAdministratorModule!")
            print(error)
            print("*********")
    
    ########################################
    #######Choose super administrator module
    ########################################
    def chooseSuperAdmistratorModule():
        try:
            with connection.cursor() as cursor:
                cursor.execute("select distinct SSN from employee where job = 'SuperAdministrators'")
                initialSuperAdministratorModule(cursor.fetchall()[0][0])
        except EXCEPTION as error:
            print("*********")
            print("Error in chooseSuperAdministratorModule!")
            print(error)
            print("*********")
            
    
    ########################################
    #######Initial screen to say your employee type
    ########################################
    def initialScreenModule():
        try:
            initialWindow = Tk()
            initialWindow.configure(bg = "blue")
            initialWindow.configure(width = 250)
            initialWindow.configure(height = 130)
            initialWindow.title("What are you?")
            initialWindow.propagate(0)
            
            initialRadioVar = IntVar(initialWindow)
            
            def initialRadioButtonSelection():
                if initialRadioVar.get() == 1:#Student
                    initialWindow.quit()
                    initialWindow.destroy()
                    chooseNewExistingStudentModule()
                elif initialRadioVar.get() == 2:#Customer Service Employee
                    initialWindow.quit()
                    initialWindow.destroy()
                    chooseCustomerServiceEmployeeModule()
                elif initialRadioVar.get() == 3:#Administrator
                    initialWindow.quit()
                    initialWindow.destroy()
                    chooseAdministratorModule()
                elif initialRadioVar.get() == 4:#Super Administrator
                    initialWindow.quit()
                    initialWindow.destroy()
                    chooseSuperAdmistratorModule()
                else:#Should never get here
                    raise EXCEPTION("Unknown initial radio button selection!")
            
            initialRadioLabel = Label(initialWindow, text = "Who are you?")
            initialRadioLabel.pack(anchor = N)
            
            studentRadio = Radiobutton(initialWindow, text="Student", variable=initialRadioVar, value=1, command=initialRadioButtonSelection)
            studentRadio.pack(anchor = W)
            
            customerServiceRadio = Radiobutton(initialWindow, text="Customer Service Employee", variable=initialRadioVar, value=2, command=initialRadioButtonSelection)
            customerServiceRadio.pack(anchor = W)
            
            administratorRadio = Radiobutton(initialWindow, text="Administrator", variable=initialRadioVar, value=3, command=initialRadioButtonSelection)
            administratorRadio.pack(anchor = W)
            
            superAdministratorRadio = Radiobutton(initialWindow, text="Super Administrator", variable=initialRadioVar, value=4, command=initialRadioButtonSelection)
            superAdministratorRadio.pack(anchor = W)
            
            initialWindow.mainloop()
            
        except EXCEPTION as error:
            print("*********")
            print("Error in initialScreenModule!")
            print(error)
            print("*********")
    
    
    initialScreenModule()
    connection.close()
