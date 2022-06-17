--question 1

SELECT (
           SELECT COUNT( * ) 
             FROM Books
            WHERE Title LIKE "%Dracula%"
       )
-      (
           SELECT COUNT( * ) 
             FROM Loans
            WHERE ReturnedDate IS NULL AND 
                  BookID IN (
                      SELECT BookID
                        FROM Books
                       WHERE Title LIKE "%Dracula%"
                  )
       )
       AS AvailableBooks_Dracula;
       

-- question 2 

INSERT INTO Books (
                      Title,
                      Author,
                      Published,
                      Barcode
                  )
                  VALUES (
                      "Dracula",
                      "Bram Stoker",
                      "1897",
                      "4819277482"
                  ),
                  (
                      "Gulliver's Travels",
                      "Jonathan Swift",
                      "1729",
                      "4899254401"
                  );


--question 3 

INSERT INTO Loans (
                      BookID,
                      PatronID,
                      LoanDate,
                      DueDate
                  )
                  VALUES (
                      (
                          SELECT BookID
                            FROM Books
                           WHERE Barcode = "2855934983"
                      ),
                      (
                          SELECT PatronID
                            FROM Patrons
                           WHERE Email = "jvaan@wisdompets.com"
                      ),
                      "2020-08-25",
                      "2020-09-08"
                  ),
                  (
                      (
                          SELECT BookID
                            FROM Books
                           WHERE Barcode = "4043822646"
                      ),
                      (
                          SELECT PatronID
                            FROM Patrons
                           WHERE Email = "jvaan@wisdompets.com"
                      ),
                      "2020-08-25",
                      "2020-09-08"
                  );
                  

-- question 4

SELECT P.PatronID,
       P.FirstName,
       P.LastName,
       P.Email,
       B.BookID,
       B.Title,
       L.LoanDate
  FROM Patrons AS P,
       Books AS B,
       Loans AS L
 WHERE P.PatronID = L.PatronID AND 
       B.BookID = L.BookID AND 
       L.DueDate = "2020-07-13" AND 
       L.ReturnedDate IS NULL;


--question 5

UPDATE Loans
   SET ReturnedDate = "2020-07-05"
 WHERE BookID IN (
           SELECT BookID
             FROM Books
            WHERE Barcode IN ("6435968624", "5677520613", "8730298424") 
       )
AND 
       ReturnedDate IS NULL;


--question 6

SELECT P.PatronID,
       P.FirstName,
       P.LastName,
       P.Email,
       COUNT( * ) AS BooksCheckedOut
  FROM Patrons AS P,
       Loans AS L
 WHERE L.PatronID = P.PatronID
 GROUP BY P.PatronID
 ORDER BY BooksCheckedOut
 LIMIT 10;


--question 7 

SELECT DISTINCT B.Title,
                B.Published,
                B.Barcode
  FROM Books AS B,
       Loans AS L
 WHERE B.BookID = L.BookID AND 
       B.Published LIKE "189_" AND 
       L.ReturnedDate IS NOT NULL;


--question 8 

SELECT Published,
       COUNT( * ) AS BooksPublished
  FROM Books
 GROUP BY Published
 ORDER BY BooksPublished DESC;



--question 9 

SELECT B.Title,
       B.Author,
       Count( * ) AS NumberOfTimesIssued
  FROM Books AS B,
       Loans AS L
 WHERE B.BookID = L.BookID
 GROUP BY B.Title
 ORDER BY NumberOfTimesIssued DESC
 LIMIT 5;