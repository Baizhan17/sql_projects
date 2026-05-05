-- SELECT COUNT(*) FROM books;

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
-- INSERT INTO books (
--     isbn, 
--     book_title, 
--     category, 
--     rental_price, 
--     status, 
--     author, 
--     publisher
-- )
-- VALUES (
--     '978-1-60129-456-2',
--     'To Kill a Mockingbird',
--     'Classic',
--     6.00,
--     'yes',
--     'Harper Lee',
--     'J.B. Lippincott & Co.'
-- );



-- Task 2: Update an Existing Member's Address

-- UPDATE members
-- SET member_address = '125 Main St'
-- WHERE member_id = 'C101';
-- SELECT * FROM members;


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

-- SELECT * FROM issued_status WHERE issued_id = 'IS121';

-- DELETE FROM issued_status
-- WHERE issued_id = 'IS121';

-- SELECT * FROM issued_status;

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
-- SELECT 
--     e.emp_name,
--     COUNT(i.issued_id) AS total_books_issued,
--     STRING_AGG(b.book_title, ', ') AS books_list
-- FROM public.issued_status i
-- JOIN public.employees e 
--     ON i.issued_emp_id = e.emp_id
-- JOIN public.books b 
--     ON i.issued_book_isbn = b.isbn
-- WHERE e.emp_id = 'E101'
-- GROUP BY e.emp_name;


-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

-- SELECT 
--     m.member_id,
--     m.member_name,
--     COUNT(i.issued_id) AS total_books_issued,
--     MIN(i.issued_date) AS first_issue_date,
--     MAX(i.issued_date) AS last_issue_date,
--     STRING_AGG(DISTINCT b.book_title, ', ') AS books_issued
-- FROM public.members m
-- JOIN public.issued_status i 
--     ON m.member_id = i.issued_member_id
-- JOIN public.books b 
--     ON i.issued_book_isbn = b.isbn
-- GROUP BY m.member_id, m.member_name
-- HAVING COUNT(i.issued_id) > 1
-- ORDER BY total_books_issued DESC;



-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

-- CREATE TABLE book_issue_summary AS
-- SELECT 
--     b.isbn,
--     b.book_title,
--     b.category,
--     COUNT(i.issued_id) AS total_book_issued_cnt,
--     MIN(i.issued_date) AS first_issued_date,
--     MAX(i.issued_date) AS last_issued_date,
--     ROUND(AVG(b.rental_price)::numeric, 2) AS avg_rental_price
-- FROM public.books b
-- LEFT JOIN public.issued_status i
--     ON b.isbn = i.issued_book_isbn
-- GROUP BY b.isbn, b.book_title, b.category
-- ORDER BY total_book_issued_cnt DESC;
-- SELECT * FROM book_issue_summary;

-- Task 7. Retrieve All Books in a Specific Category:

-- SELECT * FROM books
-- WHERE category='Fantasy'



-- Task 8: Find Total Rental Income by Category:

-- SELECT 
--     category,
--     SUM(total_book_issued_cnt * avg_rental_price) AS total_rental_income
-- FROM book_issue_summary
-- WHERE category = 'Fantasy'
-- GROUP BY category;

-- task 9 List Employees with Their Branch Manager's Name and their branch details:

-- SELECT e1.*,
-- e2.emp_name as manager,
-- b.branch_id FROM employees as e1
-- JOIN 
-- branch as b 
-- ON b.branch_id=e1.branch_id
-- JOIN
-- employees as e2 
-- ON b.manager_id=e2.emp_id


-- Task 10. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

-- CREATE TABLE book_price_above AS
-- SELECT 
--     b.isbn,
--     b.book_title,
--     b.category,
--     b.rental_price
-- FROM public.books b
-- WHERE b.rental_price > 7;

-- SELECT * FROM book_price_above;

-- Task 11: Retrieve the List of Books Not Yet Returned
SELECT DISTINCT ist.issued_book_name 
FROM issued_status AS ist
LEFT JOIN return_status AS rs 
    ON ist.issued_id = rs.issued_id
	WHERE rs.return_id IS NULL;

SELECT * FROM return_status;
