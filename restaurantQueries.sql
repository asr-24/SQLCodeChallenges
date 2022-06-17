--question 1

SELECT FirstName,
       LastName,
       Email
  FROM Customers
 ORDER BY LastName;
 

-- question 2

CREATE TABLE ResponseInfo (
    CustomerID INTEGER,
    PartySize  INTEGER,
    FOREIGN KEY (
        CustomerID
    )
    REFERENCES Customers (CustomerID) 
);


-- question 3

-- table 1
SELECT *
  FROM Dishes
 ORDER BY Price;
 
-- table 2
SELECT *
  FROM Dishes
 WHERE Type IN ("Appetizer", "Beverage") 
 ORDER BY Type;
 
-- table 3
SELECT *
  FROM Dishes
 WHERE Type NOT IN ("Beverage") 
 ORDER BY Type;
 

-- question 4

INSERT INTO Customers (
                          FirstName,
                          LastName,
                          Email,
                          Address,
                          City,
                          State,
                          Phone,
                          Birthday
                      )
                      VALUES (
                          "Anna",
                          "Smith",
                          "asmith@kinetecoinc.com",
                          "479 Lapis Dr.",
                          "Memphis",
                          "TN",
                          "(555) 555-1212",
                          "1973-07-21"
                      );
                      

-- question 5

SELECT CustomerID,
       Address
  FROM Customers
 WHERE Address = "27170 6th Ave.";

UPDATE Customers
   SET Address = "74 Pine St.",
       City = "New York",
       State = "NY"
 WHERE CustomerID = 26;
 

-- question 6

SELECT CustomerID,
       Email,
       Phone
  FROM Customers
 WHERE Email = "tjenkins@rouxacademy.org";

DELETE FROM Customers
      WHERE CustomerID = 4;
      

-- question 7

INSERT INTO ResponseInfo VALUES (
                             (
                                 SELECT CustomerID
                                   FROM Customers
                                  WHERE Email = "atapley2j@kinetecoinc.com"
                             ),
                             4
                         );
                         

-- question 8

SELECT R.*,
       C.FirstName,
       C.LastName
  FROM Reservations AS R,
       Customers AS C
 WHERE C.LastName LIKE "St%son" AND 
       R.Date LIKE "%06-14%" AND 
       C.CustomerID = R.CustomerID;
       

-- question 9

INSERT INTO Reservations (
                             ReservationID,
                             CustomerID,
                             Date,
                             PartySize
                         )
                         VALUES (
                             2002,
                             (
                                 SELECT CustomerID
                                   FROM Customers
                                  WHERE Email = "asmith@kinetecoinc.com"
                             ),
                             "2020-07-14 18:00:00",
                             5
                         );
                         

-- question 10

INSERT INTO Orders (
                       OrderID,
                       CustomerID,
                       OrderDate
                   )
                   VALUES (
                       1001,
                       (
                           SELECT CustomerID
                             FROM Customers
                            WHERE FirstName = Loretta AND 
                                  LastName = Hundey AND 
                                  Address = "6939 Elka Place"
                       ),
                       Datetime() 
                   );
                   

INSERT INTO OrdersDishes (
                            OrdersDishesID, 
                            OrderID, 
                            DishID
                         )
                         VALUES (
                             4022,
                             1001,
                             (
                                 SELECT DishID
                                 FROM Dishes
                                 WHERE Name = "House Salad"
                             )
                         );

INSERT INTO OrdersDishes (
                            OrdersDishesID, 
                            OrderID, 
                            DishID
                         )
                         VALUES (
                             4023,
                             1001,
                             (
                                 SELECT DishID
                                 FROM Dishes
                                 WHERE Name = "Mini Cheeseburgers"
                             )
                         );
                         
INSERT INTO OrdersDishes (
                            OrdersDishesID, 
                            OrderID, 
                            DishID
                         )
                         VALUES (
                             4024,
                             1001,
                             (
                                 SELECT DishID
                                 FROM Dishes
                                 WHERE Name = "Tropical Blue Smoothie"
                             )
                         );
                         


--question 11

SELECT C.CustomerID,
       C.FavoriteDish,
       D.Name
  FROM Customers AS C,
       Dishes AS D
 WHERE C.FirstName = "Cleo" AND 
       C.LastName = "Goldwater" AND 
       C.FavoriteDish = D.DishID;

UPDATE Customers
   SET FavoriteDish = (
           SELECT DishID
             FROM Dishes
            WHERE Name = "Quinoa Salmon Salad"
       )
 WHERE CustomerID = 42;


--question 12

SELECT C.FirstName,
       C.LastName,
       C.Email,
       Count(O.OrderID) AS NumberOfOrders
  FROM Customers AS C,
       Orders AS O
 WHERE C.CustomerID = O.CustomerID
 GROUP BY C.CustomerID
 ORDER BY NumberOfOrders DESC
 LIMIT 5;

