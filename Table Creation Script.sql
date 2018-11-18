create table employee
	(SSN			char(11),
	 job			enum('Administrators', 'SuperAdministrators', 'Customer Support') not null,
     employee_ID	varchar(100),
     first_name		varchar(100) not null,
     last_name		varchar(100) not null,
     gender			enum('Male', 'Female') not null,
     salary			int,
     email_address	varchar(100),
     address		varchar(100),
     telephone_num	char(12),
     primary key	(SSN)
	);
create table university
	(university_ID		varchar(100),
     university_name	varchar(100) not null,
     address			varchar(100),
     primary key		(university_ID)
	);
create table book
	(ISBN_13			varchar(15),
     purchase_type		enum('rent','buy') not null,
     book_condition		enum('new', 'old') not null,
     the_format			enum('hardcover', 'paperback', 'electronic'),
     price				numeric(9,2),
     title				varchar(500) not null,
     quantity			smallint not null,
     the_language		varchar(100),
     publish_date		char(4),
     ISBN				varchar(11),
     publisher			varchar(100),
     edition_num		smallint not null,
     weight				smallint,
     total_purchases	smallint,
     average_rating		real,
     category			varchar(200),
     primary key		(ISBN_13, purchase_type, book_condition, the_format)
    );
create table student
	(student_email	varchar(100),
     first_name		varchar(100) not null,
     last_name		varchar(100) not null,
     address		varchar(100),
     birth_date		date not null,
     university_ID	varchar(100),
     major			varchar(100),
     student_status	enum('UnderGrad', 'Grad') not null,
     current_year	smallint not null,
     primary key	(student_email),
     foreign key	(university_ID) references university (university_ID) on delete set null
	);
create table trouble_ticket
	(ticket_ID				char(4),
     category				char(100) not null,
     date_created			date,
     title					varchar(100) not null,
     date_completed			date,
     problem_description	varchar(200),
     problem_fix			varchar(200),
     state					enum('new', 'assigned', 'in-process', 'completed'),
     fixer_ID				char(11),
     primary key			(ticket_ID),
     foreign key			(fixer_ID) references employee(SSN) on delete set null
    );
create table trouble_ticket_student
	(ticket_ID		char(4),
     creator_ID		varchar(100),
     primary key	(ticket_ID),
     foreign key	(ticket_ID) references trouble_ticket(ticket_ID),
     foreign key	(creator_ID) references student(student_email) on delete set null
    );
create table trouble_ticket_employee
	(ticket_ID		char(4),
     creator_ID		char(11),
     primary key	(ticket_ID),
     foreign key	(ticket_ID) references trouble_ticket(ticket_ID),
     foreign key	(creator_ID) references employee(SSN) on delete set null
    );
create table ticket_changes
	(ticket_ID		char(4),
	 date_changed	date,
     changer_ID		char(11),
     new_state		enum('new', 'assigned', 'in-process', 'completed'),
     primary key	(ticket_ID, date_changed, changer_ID, new_state),
     foreign key	(ticket_ID) references trouble_ticket(ticket_ID),
     foreign key	(changer_ID) references employee(SSN)
    );
create table book_author
	(ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
     author			varchar(100),
     primary key	(ISBN_13, purchase_type, book_condition, the_format, author),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format)
    );
create table book_keywords
	(ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
	 keyword		varchar(100),
     primary key	(ISBN_13, purchase_type, book_condition, the_format, keyword),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format)
    );
create table book_subcategories
	(ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
	 subcategory	varchar(100),
     primary key	(ISBN_13, purchase_type, book_condition, the_format, subcategory),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format)
    );
create table book_rating
	(student_email	varchar(100),
     ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
     rating			real,
     text_review	varchar(500),
     primary key	(student_email, ISBN_13, purchase_type, book_condition, the_format),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format),
     foreign key	(student_email) references student(student_email)
    );
create table recommendations
	(student_email	varchar(100),
     ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
     primary key	(student_email, ISBN_13, purchase_type, book_condition, the_format),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format),
     foreign key	(student_email) references student(student_email)
    );
create table cart
	(cart_ID		smallint,
     student_email	varchar(100),
     date_created	date not null,
     date_updated	date,
     primary key	(cart_ID),
     foreign key	(student_email) references student(student_email) on delete set null
    );
create table cart_books
	(cart_ID		smallint,
     ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
     quantity		smallint not null,
     primary key	(cart_ID, ISBN_13, purchase_type, book_condition, the_format),
     foreign key	(cart_ID) references cart(cart_ID),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format)
    );
create table student_phone_num
	(student_email	varchar(100),
     phone_number	char(10),
     primary key	(student_email, phone_number),
     foreign key	(student_email) references student(student_email)
    );
create table orders
	(order_ID			varchar(100),
     student_email		varchar(100),
     date_created		date not null,
     date_fulfilled		date,
     shipping_type		enum('standard', '2-day', '1-day') not null,
     credit_card_num	varchar(20),
     credit_card_exp	date,
     credit_card_name	varchar(100),
     credit_card_type	varchar(100),
     order_status		enum('new', 'processed', 'awaiting shipping', 'shipping', 'shipped', 'cancelled'),
     primary key		(order_ID),
     foreign key		(student_email) references student(student_email) on delete set null
    );
create table order_books
	(order_ID		varchar(100),
     ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
     quantity		smallint,
     primary key	(order_ID, ISBN_13, purchase_type, book_condition, the_format),
     foreign key	(order_ID) references orders(order_ID),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format)
    );
create table university_rep
	(SSN			char(11),
     email			varchar(100),
     university_ID	varchar(100),
     first_name		varchar(100),
     last_name		varchar(100),
     phone_num		char(12),
     gender			enum('Male', 'Female'),
     primary key	(SSN),
     foreign key	(university_ID) references university(university_ID) on delete set null
    );
create table department
	(department_name	varchar(100),
     university_ID		varchar(100),
     primary key		(department_name, university_ID),
     foreign key		(university_ID) references university(university_ID)
    );
create table course
	(course_ID			varchar(125),
     semester			enum('Fall', 'Winter', 'Spring', 'Summer') not null,
     the_year			smallint not null,
     university_ID		varchar(100),
     class_name			varchar(100),
     department_name	varchar(100),
     primary key		(course_ID, semester, the_year, university_ID),
     foreign key		(university_ID) references university(university_ID),
     foreign key		(department_name) references department(department_name)
    );
create table instructor
	(instructor_email	varchar(100),
     first_name			varchar(100) not null,
     last_name			varchar(100) not null,
     department_name	varchar(100),
     university_ID		varchar(100),
     primary key		(instructor_email),
     foreign key		(university_ID) references university(university_ID) on delete set null,
     foreign key		(department_name) references department(department_name) on delete set null
    );
create table course_instructor
	(course_ID			varchar(125),
     semester			enum('Fall', 'Winter', 'Spring', 'Summer'),
     the_year			smallint,
     university_ID		varchar(100),
     instructor_email	varchar(100),
     primary key		(course_ID, semester, the_year, university_ID, instructor_email),
     foreign key		(course_ID, semester, the_year) references course(course_ID, semester, the_year),
     foreign key		(university_ID) references university(university_ID),
     foreign key		(instructor_email) references instructor(instructor_email)
    );
create table required_books
	(course_ID		varchar(125),
     semester		enum('Fall', 'Winter', 'Spring', 'Summer'),
     the_year		smallint,
     university_ID	varchar(100),
     ISBN_13		varchar(15),
     purchase_type	enum('rent','buy') not null,
     book_condition	enum('new', 'old') not null,
     the_format		enum('hardcover', 'paperback', 'electronic'),
     primary key	(course_ID, semester, the_year, university_ID, ISBN_13, purchase_type, book_condition, the_format),
     foreign key	(course_ID, semester, the_year) references course(course_ID, semester, the_year),
     foreign key	(university_ID) references university(university_ID),
     foreign key	(ISBN_13, purchase_type, book_condition, the_format) references book(ISBN_13, purchase_type, book_condition, the_format)
    );
