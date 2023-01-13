

CREATE TABLE SUPPLIER
(
	Sno		VARCHAR(6),
	Sname	VARCHAR(20)	NOT NULL,
	Status	INT check(Status>0),
	City	VARCHAR(20),
	PRIMARY KEY(Sno)
	
);
CREATE TABLE PART
(
	Pno		VARCHAR(6),
	Pname	VARCHAR(20)	NOT NULL,
	Color	VARCHAR(20),
	Weight	INT check(Weight>=1 and Weight<=100),
	City	VARCHAR(20),
	PRIMARY KEY(Pno),
	UNIQUE(Pname, Color)
);

CREATE TABLE SHIPMENT
(
	Sno		VARCHAR(6) ,
	Pno		VARCHAR(6),
	Qty		INT default 100,
	Price	decimal(10, 3) check(price > 0), 
	PRIMARY KEY(Sno, Pno),
	FOREIGN KEY(Sno) REFERENCES SUPPLIER(Sno),
	FOREIGN KEY(Pno) REFERENCES PART(Pno)
);