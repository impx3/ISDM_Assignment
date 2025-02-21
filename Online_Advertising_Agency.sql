use [Online_Advertising_Agency_Management_System];

/*Table of registered businesses*/
CREATE TABLE CLIENT(
ClientID VARCHAR(4) NOT NULL,
ClientName VARCHAR(40) NOT NULL,
Email VARCHAR(35) CHECK (Email LIKE '%_@__%.__%') NOT NULL,
CONSTRAINT pk_CLIENT PRIMARY KEY (ClientID) );

/*Table of advertisement details*/
CREATE TABLE ADVERTISEMENT (
AdID VARCHAR(5) NOT NULL,
Ad_Title VARCHAR(64) NOT NULL,
Video CHAR(1) NOT NULL,
Banner CHAR(1) NOT NULL,
Picture CHAR(1) NOT NULL,
Category VARCHAR (20) NOT NULL,
Ad_Description VARCHAR (200),
ClientID VARCHAR(4) NOT NULL,
CONSTRAINT pk_ADVERTISEMENT PRIMARY KEY (AdID, ClientID),
CONSTRAINT fk_ADVERTISEMENT FOREIGN KEY (ClientID) REFERENCES CLIENT
(ClientID));

/*Table of clients' contact information*/
CREATE TABLE CLIENT_ContactNo (
ClientID VARCHAR(4) NOT NULL,
ContactNo VARCHAR(10) NOT NULL,
CONSTRAINT pk_CLIENT_ContactNo PRIMARY KEY (ClientID, ContactNo),
CONSTRAINT fk_CLIENT_ContactNo FOREIGN KEY (ClientID) REFERENCES CLIENT
(ClientID),
CONSTRAINT ContactNo_CHK CHECK (ContactNo BETWEEN 0000000000 AND 9999999999)
);

/*Client-posts-ad Table*/
CREATE TABLE Post_Ad (
AdID VARCHAR(5) NOT NULL,
ClientID VARCHAR(4) NOT NULL,
Post_Date DATE NOT NULL,
CONSTRAINT pk_Post_Ad PRIMARY KEY (AdID, ClientID),
CONSTRAINT fk_Post_Ad1 FOREIGN KEY (AdID, ClientID) REFERENCES ADVERTISEMENT
(AdID, ClientID));

/*Table of payment information*/
CREATE TABLE PAYMENT(
OrderID VARCHAR(4) NOT NULL,
Status VARCHAR(10) NOT NULL,
Fee DECIMAL (10,2) NOT NULL,
Method VARCHAR(12) NOT NULL,
CONSTRAINT pk_PAYMENT PRIMARY KEY (OrderID) );

/*Table of client payments*/
CREATE TABLE client_payment (
ClientID VARCHAR(4) NOT NULL,
OrderID VARCHAR(4) NOT NULL,
Payment_date DATE,
CONSTRAINT pk_client_payment PRIMARY KEY (ClientID, OrderID),
CONSTRAINT fk_client_payment1 FOREIGN KEY (ClientID) REFERENCES CLIENT
(ClientID),
CONSTRAINT fk_client_payment2 FOREIGN KEY (OrderID) REFERENCES PAYMENT
(OrderID) );

/*Table of departments*/
CREATE TABLE DEPARTMENT(
DeptID VARCHAR(4) NOT NULL,
DName VARCHAR(10) NOT NULL,
Number_of_Employees INT NOT NULL,
CONSTRAINT pk_DEPARTMENT PRIMARY KEY (DeptID) );


/*Table of employees*/
CREATE TABLE EMPLOYEE (
Eno VARCHAR(4) NOT NULL,
FirstName VARCHAR(20) NOT NULL,
MiddleName VARCHAR(20) NOT NULL,
Surname VARCHAR(20) NOT NULL,
Title VARCHAR(20) NOT NULL,
dob DATE NOT NULL,
Address VARCHAR(60) NOT NULL,
Salary DECIMAL (10,2) NOT NULL,
EmpEmail VARCHAR(35) CHECK (EmpEmail LIKE '%_@__%.__%') NOT NULL,
Age INT NOT NULL,
DeptID VARCHAR(4) NOT NULL,
CONSTRAINT pk_EMPLOYEE PRIMARY KEY (Eno),
CONSTRAINT fk_EMPLOYEE1 FOREIGN KEY (DeptID) REFERENCES DEPARTMENT (DeptID)
);

/*Table of employees' user accounts*/
CREATE TABLE User_Account(
userAcc_id VARCHAR(5) NOT NULL,
Role VARCHAR (25) NOT NULL,
emp_username VARCHAR (15) NOT NULL,
Eno VARCHAR(4) NOT NULL,
Access_permission VARCHAR (20) NOT NULL,
CONSTRAINT pk_User_Account PRIMARY KEY (userAcc_id, Eno),
CONSTRAINT fk_User_Account FOREIGN KEY (Eno) REFERENCES EMPLOYEE (Eno) );


/*Table of employees' contact information*/
CREATE TABLE EMPLOYEE_ContactNo (
Eno VARCHAR(4) NOT NULL,
Contact_No VARCHAR (10) NOT NULL,
CONSTRAINT pk_EMPLOYEE_ContactNo PRIMARY KEY (Eno, Contact_No),
CONSTRAINT fk_EMPLOYEE_ContactNo FOREIGN KEY (Eno) REFERENCES EMPLOYEE (Eno),
CONSTRAINT E_Contact_No_CHK CHECK (Contact_No BETWEEN 0000000000 AND
9999999999) );

/*Employee-works in-department Table*/
CREATE TABLE Emp_Dept (
Eno VARCHAR(4) NOT NULL,
DeptID VARCHAR(4) NOT NULL,
Start_date DATE NOT NULL,
No_of_hours INT NOT NULL,
CONSTRAINT pk_Emp_Dept PRIMARY KEY (Eno, DeptID),
CONSTRAINT fk_Emp_Dept1 FOREIGN KEY (Eno) REFERENCES EMPLOYEE (Eno),
CONSTRAINT fk_Emp_Dept2 FOREIGN KEY (DeptID) REFERENCES DEPARTMENT (DeptID) );

/*Employee-publishes-advertisement Table*/
CREATE TABLE publish_ad (
Eno VARCHAR(4) NOT NULL,
AdID VARCHAR(5) NOT NULL,
ClientID VARCHAR(4) NOT NULL,
publish_date DATE,
end_date DATE,
CONSTRAINT pk_publish_ad PRIMARY KEY (Eno, AdID, ClientID),
CONSTRAINT fk_publish_ad1 FOREIGN KEY (AdID, ClientID) REFERENCES
ADVERTISEMENT (AdID, ClientID),
CONSTRAINT fk_publish_ad2 FOREIGN KEY (Eno) REFERENCES EMPLOYEE (Eno));

/*Table of complaint information*/
CREATE TABLE Complaint (
Complaint_ID VARCHAR(5) NOT NULL,
C_Title VARCHAR (50) NOT NULL,
C_Status VARCHAR (15) NOT NULL,
ClientID VARCHAR(4) NOT NULL,
CONSTRAINT pk_Complaint PRIMARY KEY (Complaint_ID, ClientID),
CONSTRAINT fk_Complaint FOREIGN KEY (ClientID) REFERENCES CLIENT (ClientID));


/*Client-makes-complaint Table*/
CREATE TABLE makes_Complaint (
Complaint_ID VARCHAR(5) NOT NULL,
ClientID VARCHAR(4) NOT NULL,
complaint_Date DATE NOT NULL,
CONSTRAINT pk_makes_Complaint PRIMARY KEY (Complaint_ID, ClientID),
CONSTRAINT fk_makes_Complaint1 FOREIGN KEY (Complaint_ID, ClientID) REFERENCES
Complaint (Complaint_ID, ClientID) );

/*Table of end-user information*/
CREATE TABLE EndUser (
UserID VARCHAR(5) NOT NULL,
UserName VARCHAR (30) NOT NULL,
User_Email VARCHAR(35) CHECK (User_Email LIKE '%_@__%.__%') NOT NULL,
CONSTRAINT pk_EndUser PRIMARY KEY (UserID) );

/*End user-likes-advertisement table - user favourites*/
CREATE TABLE User_favourites (
UserID VARCHAR(5) NOT NULL,
Favourite_ad VARCHAR(5) NOT NULL,
ClientID VARCHAR(4) NOT NULL,
CONSTRAINT pk_User_favourites PRIMARY KEY (UserID, Favourite_ad, ClientID),
CONSTRAINT fk_User_favourites1 FOREIGN KEY (Favourite_ad, ClientID) REFERENCES
ADVERTISEMENT (AdID, ClientID),
CONSTRAINT fk_User_favourites2 FOREIGN KEY (UserID) REFERENCES EndUser
(UserID) );


/*End user-views-advertisement Table*/
CREATE TABLE user_view_ad (
UserID VARCHAR(5) NOT NULL,
ClientID VARCHAR(4) NOT NULL,
AdID VARCHAR(5) NOT NULL,
CONSTRAINT pk_user_view_ad PRIMARY KEY (UserID, AdID, ClientID),
CONSTRAINT fk_user_view_ad1 FOREIGN KEY (UserID) REFERENCES EndUser (UserID),
CONSTRAINT fk_user_view_ad2 FOREIGN KEY (AdID,ClientID) REFERENCES
ADVERTISEMENT (AdID,ClientID) );


/*inserting data as records to the tables*/
INSERT INTO CLIENT (ClientID, ClientName, Email)
VALUES ('C001', 'Matthew', 'matthewbp@gmail.com'),
('C002', 'John', 'john12gp@gmail.com'),
('C003', 'Yohan', 'yohanjyp@gmail.com'),
('C004', 'Chris', 'chris143@gmail.com'),
('C005', 'Felix', 'felix20@gmail.com') ;

INSERT INTO ADVERTISEMENT (AdID, Ad_Title, Video, Banner, Picture, Category,
Ad_Description, ClientID)
VALUES ('AD001', 'Special Discounts', 'N', 'N', 'Y', 'Electronics','Be sure to
check out our special discounts on USB devices', 'C002'),
('AD002', 'New Feature', 'Y', 'Y', 'N', 'Electronics', 'This new feature will
drive away your worries','C002'),
('AD003', 'Special Offer', 'N', 'Y', 'Y', 'Fashion', 'Special offer on accessories
at any of our stores islandwide','C003'),
('AD004', 'New Product', 'N', 'N', 'Y', 'Food & Beverages', 'Enjoy our delicious
line-up of milkshakes!','C001'),
('AD005', 'New Ford Mustang', 'Y', 'N', 'N', 'Vehicles', 'New Ford Mustang is
right here','C004') ;

INSERT INTO CLIENT_ContactNo (ClientID, ContactNo)
VALUES ('C001', 0741820896),
('C002', 0752820840),
('C003', 0368515722),
('C003', 0784522289),
('C004', 0700863818) ;

INSERT INTO Post_Ad (AdID, ClientID, Post_Date)
VALUES ('AD001', 'C002', '2023-05-25'),
('AD002', 'C002', '2023-05-10'),
('AD003', 'C003', '2023-02-20'),
('AD004', 'C001', '2023-05-30'),
('AD005', 'C004', '2023-03-08') ;

INSERT INTO PAYMENT (OrderID, Status, Fee, Method)
VALUES ('P001', 'Completed', 25000.00, 'EFT'),
('P002', 'Pending', 4000.00 , 'PayPal'),
('P003', 'Completed', 5000.00 , 'EFT'),
('P004', 'Completed', 10000.00 , 'Credit card'),
('P005', 'Pending', 8000.00 , 'PayPal') ;

INSERT INTO client_payment ( ClientID, OrderID, Payment_date)
VALUES ('C004', 'P001', '2023-03-05'),
('C002', 'P002', '2023-06-21'),
('C002', 'P003', '2023-05-05'),
('C003', 'P004', '2023-02-16'),
('C001', 'P005', '2023-06-26') ;

INSERT INTO DEPARTMENT (DeptID, DName, Number_of_Employees)
VALUES ('D001', 'Marketing',20),
('D002', 'Finance',20),
('D003', 'HR',15),
('D004', 'Analytics',10),
('D005', 'Creative',10) ;

INSERT INTO EMPLOYEE (Eno, FirstName, MiddleName, Surname, Title, dob, Address,
Salary, EmpEmail, Age, DeptID)
VALUES ('E001', 'Harry','James','Potter','Designer','1989-07-31','152, Keyzer
Street, Colombo 11',200000.00,'harryjp80@gmail.com',43,'D005'),
('E002', 'Hermione','Jean','Granger','Data Analyst','1979-09-19','28, De Vos
Avenue, Duplication Road, Colombo',500000.00,'hermionejg19@gmail.com',43,
'D004'),
('E003', 'Draco','Lucius','Malfoy','HR Manager','1980-06-05','140, St Michels
Road, Colombo',100000.00,'dracomalfoy@gmail.com',42,'D003'),
('E004','Ronald','Bilius','Weasley','Publisher','1980-03-01','179, Inner Flower
Road, Colombo 03',150000.00, 'ronaldbw@gmail.com',43,'D001'),
('E005', 'Ginerva','Molly','Weasley','Financial Manager','1981-08-11','287, Old
Moor Street, Colombo 12',100000.00,'giinnyweasley@gmail.com',41,'D002') ;

INSERT INTO User_Account ( userAcc_id, Role, emp_username, Eno, Access_permission)
VALUES ('UA001','Designer' ,'E1HarryP' ,'E001' ,'Standard User'),
('UA002','Data Analyst' ,'E2HermioneG' ,'E002' ,'Administrator'),
('UA003','HR Manager' ,'E3DracoM' ,'E003' ,'Standard User'),
('UA004','Publisher' ,'E4RonaldW' ,'E004' ,'Standard User'),
('UA005','Financial Manager' ,'E5GinervaW' ,'E005' ,'Standard User') ;

INSERT INTO EMPLOYEE_ContactNo (Eno, Contact_No)
VALUES ('E001', 0758522831),
('E002', 0712868528),
('E003', 0772546435),
('E003', 0721523238),
('E004', 0362965321) ;

INSERT INTO Emp_Dept (Eno, DeptID, Start_date, No_of_hours)
VALUES ('E001', 'D005','2020-01-05' ,40 ),
('E002', 'D004','2018-11-01' ,40 ),
('E003', 'D003','2016-06-02' ,40 ),
('E004', 'D001','2013-09-01' ,40 ),
('E005', 'D002','2015-03-01' ,50 ) ;

INSERT INTO publish_ad (Eno, AdID, ClientID, publish_date, end_date)
VALUES ('E004','AD001', 'C002','2023-05-30', '2023-06-14'),
('E004','AD002', 'C002','2023-05-15', '2023-05-31'),
('E004','AD003', 'C003','2023-02-25', '2023-03-25'),
('E004','AD004', 'C001','2023-06-03', '2023-07-03'),
('E004','AD005', 'C004','2023-03-12', '2023-03-30') ;

INSERT INTO Complaint (Complaint_ID, C_Title, C_Status, ClientID)
VALUES ('CP001', 'Ad isn’t compatible with mobile devices', 'Responded', 'C003'),
('CP002', 'Budget issue', 'Responded', 'C004'),
('CP003', 'Click-through rate declining', 'Responded', 'C001'),
('CP004', 'Displaying ad different to the schedule', 'Responded', 'C005'),
('CP005', 'Problem with landing page', 'Pending', 'C002') ;

INSERT INTO makes_Complaint (Complaint_ID, ClientID, complaint_Date)
VALUES ('CP001', 'C003','2023-02-25'),
('CP002', 'C004','2023-03-12'),
('CP003', 'C001','2023-01-18'),
('CP004', 'C005','2022-12-28'),
('CP005', 'C002','2023-05-20') ;

INSERT INTO EndUser (UserID,UserName,User_Email )
VALUES ('EU001', 'Jack Frost','jackrotg@gmail.com'),
('EU002', 'Bruce Wayne','brucegotham12@gmail.com'),
('EU003', 'Clark Kent','clarkzoel@gmail.com'),
('EU004', 'Steve Rogers','steveus13@gmail.com'),
('EU005', 'Gwen Stacy','gwenstacy88@gmail.com');

INSERT INTO User_favourites (UserID, Favourite_ad, ClientID)
VALUES ('EU001', 'AD004','C001'),
('EU003', 'AD001','C002'),
('EU004', 'AD002','C002'),
('EU004', 'AD001','C002'),
('EU005', 'AD003','C003');

INSERT INTO user_view_ad (UserID, ClientID, AdID)
VALUES ('EU001', 'C001', 'AD004' ),
('EU002', 'C004', 'AD005' ),
('EU003', 'C002', 'AD001' ),
('EU004', 'C002', 'AD002' ),
('EU004', 'C002', 'AD001' );