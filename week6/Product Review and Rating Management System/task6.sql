USE inventory_db;

CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE DEFAULT (CURRENT_DATE),
CONSTRAINT fk_reviews_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

     CONSTRAINT fk_reviews_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

SELECT * FROM reviews;
INSERT INTO reviews
(customer_id, product_id, rating, review_text)
VALUES
(1, 1, 5, 'Excellent product and very good quality'),
(2, 2, 4, 'Good product with nice performance'),
(3, 3, 3, 'Product is okay but can be improved'),
(4, 4, 5, 'Very satisfied with the product'),
(5, 5, 2, 'Quality was not as expected');
SELECT
    p.Product_Name,
    r.Rating,
    r.Review_Text
FROM Products p
JOIN Reviews r
    ON p.Product_ID = r.Product_ID
WHERE p.Product_ID = 1;
SELECT
    c.Customer_Name,
    r.Product_ID,
    r.Rating,
    r.Review_Text,
    r.Review_Date
FROM Customers c
JOIN Reviews r
    ON c.Customer_ID = r.Customer_ID
ORDER BY c.Customer_Name;
SELECT
    p.Product_Name,
    COUNT(r.Review_ID) AS Review_Count
FROM Products p
JOIN Reviews r
    ON p.Product_ID = r.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Review_Count DESC
LIMIT 1;
SELECT
    c.Customer_Name,
    p.Product_Name,
    r.Rating,
    r.Review_Text,
    r.Review_Date
FROM Reviews r
JOIN Customers c
    ON r.Customer_ID = c.Customer_ID
JOIN Products p
    ON r.Product_ID = p.Product_ID
ORDER BY r.Review_Date DESC;
SELECT
    p.Product_Name,
    r.Rating,
    r.Review_Text
FROM Products p
JOIN Reviews r
    ON p.Product_ID = r.Product_ID
WHERE r.Rating > 4;
SELECT
    Product_ID,
    AVG(Rating) AS Average_Rating
FROM Reviews
GROUP BY Product_ID;
SELECT
    Product_ID,
    COUNT(Review_ID) AS Number_of_Reviews
FROM Reviews
GROUP BY Product_ID;
SELECT
    Product_ID,
    AVG(Rating) AS Average_Rating
FROM Reviews
GROUP BY Product_ID
ORDER BY Average_Rating DESC
LIMIT 1;
SELECT
    Product_ID,
    AVG(Rating) AS Average_Rating
FROM Reviews
GROUP BY Product_ID
HAVING AVG(Rating) > 4;
SELECT
    p.Product_Name,
    COUNT(r.Review_ID) AS Number_of_Reviews,
    ROUND(AVG(r.Rating), 2) AS Average_Rating
FROM Products p
JOIN Reviews r
    ON p.Product_ID = r.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Average_Rating DESC;
SELECT
    p.Product_Name,
    COUNT(r.Review_ID) AS Number_of_Reviews,
    ROUND(AVG(r.Rating), 2) AS Average_Rating,
    CASE
        WHEN AVG(r.Rating) >= 4 THEN 'Highly Rated'
        WHEN AVG(r.Rating) < 3 THEN 'Requires Improvement'
        ELSE 'Average'
    END AS Product_Feedback_Status
FROM Products p
JOIN Reviews r
    ON p.Product_ID = r.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Number_of_Reviews DESC, Average_Rating DESC;
SELECT
    SUM(CASE WHEN Rating = 5 THEN 1 ELSE 0 END) AS Five_Star_Ratings,
    SUM(CASE WHEN Rating = 4 THEN 1 ELSE 0 END) AS Four_Star_Ratings,
    COUNT(DISTINCT CASE WHEN Rating <= 2 THEN Product_ID END) AS Low_Rated_Products
FROM Reviews;