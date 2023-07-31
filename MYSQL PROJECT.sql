CREATE DATABASE LIBRARY;
USE LIBRARY;
#1
CREATE TABLE Branch (Branch_no INT PRIMARY KEY,Manager_Id INT,Branch_address VARCHAR(45),Contact_no VARCHAR(10));
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 301, '001 KTYM', 7894561230),
(2, 302, '002 KLM', 3216549870),
(3, 303, '003 PTNA', 4561239870),
(4, 304, '004 TVM', 8527419630),
(5, 305, '005 TRSR', 9638527410),
(6, 306, '006 PLKD', 7418529630);
SELECT *FROM Branch;
#2
CREATE TABLE Employee (Emp_Id INT PRIMARY KEY,Emp_name VARCHAR(20),Position VARCHAR(20),Salary INT);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary) VALUES
(301, 'Amal Bahuleyan', 'Manager', 50000),
(302, 'Nandu Das', 'Assistant Manager', 45000),
(303, 'Anandhu Raj', 'Assistant', 45000),
(304, 'Adersh Y', 'Clerk', 35000),
(305, 'Ramshad', 'Assistant', 45000),
(306, 'Anju Lekshmi', 'Clerk', 35000),
(307, 'Noorjahan', 'Assistant', 48500),
(308, 'Prajin', 'Clerk', 36000);
SELECT * FROM Employee;
#3
CREATE TABLE Customer (Customer_Id INT PRIMARY KEY,Customer_name VARCHAR(25),Customer_address VARCHAR(45),Reg_date DATE);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(101, 'Anand', 'Rose villa', '2022-07-14'),
(102, 'Nadirsha', 'Jasmin villa', '2022-02-22'),
(103, 'Aslam', 'Daisy villa', '2023-04-12'),
(104,'Raheez ', 'Lilly villa', '2023-04-10'),
(105, 'Jasmin', 'lotus villa', '2022-06-05'),
(106, 'Hida', 'Marigold villa', '2022-03-20');
SELECT * FROM Customer;
#4
CREATE TABLE IssueStatus (Issue_Id INT PRIMARY KEY,Issued_cust INT,Issued_book_name VARCHAR(25),Issue_date DATE,Isbn_book VARCHAR(25),
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 1, 'Book A', '2023-06-05', 'ISBN001'),
(2, 2, 'Book B', '2023-06-10', 'ISBN002'),
(3, 3, 'Book C', '2023-06-12', 'ISBN003'),
(4, 1, 'Book D', '2023-06-15', 'ISBN004'),
(5, 4, 'Book E', '2023-06-05', 'ISBN005'),
(6, 5, 'Book F', '2023-06-10', 'ISBN006'),
(7, 6, 'Book G', '2023-06-12', 'ISBN007'),
(8, 4, 'Book H', '2023-06-15', 'ISBN008');
SELECT * FROM IssueStatus;
#5
CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY,Return_cust INT,Return_book_name VARCHAR(25),Return_date DATE,Isbn_book2 VARCHAR(25),
FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 1, 'Book 1', '2023-01-11', 'ISBN001'),
(2, 2, 'Book 2', '2023-05-22', 'ISBN002'),
(3, 3, 'Book 3', '2023-04-10', 'ISBN003'),
(4, 4, 'Book 4', '2023-04-10', 'ISBN005'),
(5, 5, 'Book 5', '2023-06-70', 'ISBN006'),
(6, 6, 'Book 6', '2023-04-26', 'ISBN007');
SELECT * FROM ReturnStatus;
#6
CREATE TABLE Books (ISBN VARCHAR(25) PRIMARY KEY,Book_title VARCHAR(25),Category VARCHAR(20),Rental_Price DECIMAL(10, 2),
  Status ENUM('yes', 'no'),Author VARCHAR(20),Publisher VARCHAR(20));
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('ISBN001', 'Book 1', 'History', 12.00, 'yes', 'Sethu', 'XAR Publishing'),
('ISBN002', 'Book 2', 'Biography', 9.50, 'yes', 'Sarah Thomas', 'ABG Books'),
('ISBN003', 'Book 3', 'Fiction', 14.00, 'no', 'Shelly Thomas', 'IKL Publishers'),
('ISBN004', 'Book 4', 'Science Fiction', 10.00, 'yes', 'Padmanabhan', 'UIK Press'),
('ISBN005', 'Book 5', 'biography', 5.00, 'yes', 'Benyamin', 'PLO Publishing'),
('ISBN006', 'Book 6', 'Mystery', 7.50, 'yes', 'MT', 'MNO Books'),
('ISBN007', 'Book 7', 'Fiction', 17.00, 'no', 'T J Joseph', 'YHU Publishers'),
('ISBN008', 'Book 8', 'History', 6.00, 'yes', 'M B Rajesh', 'XCD Press');
SELECT * FROM Books;
# 1) Retrieve the book title, category and rental price of all available books.
SELECT Book_title, Category, Rental_Price FROM Books WHERE Status= 'yes';
# 2) List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary FROM Employee ORDER BY Salary desc;
# 3) Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT IssueStatus.Issued_book_name, Customer.Customer_name FROM IssueStatus INNER JOIN Customer 
ON IssueStatus.Issued_cust = Customer.Customer_Id
ORDER by Issued_book_name;
# 4) Display the total count of books in each category.
SELECT Category, COUNT(*) as TOTAL_COUNT FROM books GROUP BY Category;
# 5) Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position FROM Employee WHERE Salary>50000;
# 6) List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT Customer.Customer_name 
FROM Customer 
	LEFT JOIN IssueStatus 
    ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Reg_date < '2022-01-01' AND Issued_cust IS NULL ;
# 7) Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(Emp_Id) FROM Branch LEFT JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id GROUP BY Branch_no;
# 8) Display the names of customers who have issued books in the month of June 2023. 
SELECT Customer.Customer_name FROM CustomerLEFT JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Issue_date LIKE '2023-06-__'
GROUP BY Customer_name;
# 9) Retrieve book_title from book table containing history. 
SELECT Book_title FROM Books WHERE Category = 'History';
# 10) Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(Emp_id) as Count_of_Employees
FROM Branch 
	INNER JOIN Employee 
    ON Branch.Manager_Id = Employee.Emp_Id 
GROUP BY Branch_no 
having COUNT(Emp_Id)>5;







