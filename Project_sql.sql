-- Retrieve total number of orders placed
SELECT 
    COUNT(*) AS Total_Orders
FROM
    orders;

-- Calculate total revenue generated from pizza sales
SELECT 
    ROUND(SUM(o.quantity * p.price), 2) AS Revenue
FROM
    order_details o
        JOIN
    pizzas p ON o.pizza_id = p.pizza_id;

-- Indentify highest priced piza
SELECT 
    t.name AS Highest_Priced_Piza, p.price AS Price
FROM
    pizzas p
        JOIN
    pizza_types t ON t.pizza_type_id = p.pizza_type_id
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            pizzas);
            
            
-- Identify the most common pizza size ordered

SELECT 
    p.size Most_Common_Size, COUNT(1) AS Total_Orders
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY p.size
ORDER BY COUNT(p.size) DESC
LIMIT 1; 


-- List the top 5 most ordered pizza types along with their quntities.
SELECT 
    name AS Pizza_Name, SUM(o.quantity) AS Quantity_Ordered
FROM
    pizza_types t
        JOIN
    pizzas p ON p.pizza_type_id = t.pizza_type_id
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY t.name
ORDER BY Quantity_Ordered DESC
LIMIT 5;