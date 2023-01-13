-- Dumping data for table 'SUPPLIER'
-- 

INSERT INTO SUPPLIER (Sno, Sname, Status, City) VALUES 
('s1', 'Smith', 20, 'London' );

INSERT INTO SUPPLIER (Sno, Sname, Status, City) VALUES 
('s2', 'Jones', 10, 'Paris' );

INSERT INTO SUPPLIER (Sno, Sname, Status, City) VALUES 
('s3', 'Blake', 30, 'Paris' );

INSERT INTO SUPPLIER (Sno, Sname, Status, City) VALUES 
('s4', 'Clark', 20, 'London' );

INSERT INTO SUPPLIER (Sno, Sname, Status, City) VALUES 
('s5', 'Adams', 30, NULL );

--Dumping data for table 'PART'
-- 

INSERT INTO PART (Pno, Pname, Color, Weight, City) VALUES 
('p1', 'Nut', 'Red', 12, 'London' );

INSERT INTO PART (Pno, Pname, Color, Weight, City) VALUES 
('p2', 'Bolt', 'Green', 17, 'Paris' );

INSERT INTO PART (Pno, Pname, Color, Weight, City) VALUES 
('p3', 'Screw', NULL, 17, 'Rome' );

INSERT INTO PART (Pno, Pname, Color, Weight, City) VALUES 
('p4', 'Screw', 'Red', 14, 'London' );

INSERT INTO PART (Pno, Pname, Color, Weight, City) VALUES 
('p5', 'Cam', 'Blue', 12, 'Paris' );

INSERT INTO PART (Pno, Pname, Color, Weight, City) VALUES 
('p6', 'Cog', 'Red', 19, 'London' );


--Dumping data for table 'SHIPMENT'
-- 

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s1', 'p1', 300, .005);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s1', 'p2', 200, .009);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s1', 'p3', 400, .004);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s1', 'p4', 200, .009);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s1', 'p5', DEFAULT, .01);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s1', 'p6', DEFAULT, .01);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s2', 'p1', 300, .006);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s2', 'p2', 400, .004);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s3', 'p2', 200, .009);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s3', 'p3', 200, NULL);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s4', 'p2', 200, .008);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s4', 'p3', NULL, NULL);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s4', 'p4', 300, .006);

INSERT INTO SHIPMENT (Sno, Pno, Qty, Price) VALUES 
('s4', 'p5', 400, .003);
