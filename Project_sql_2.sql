
-- Find the total quantity of each pizza category ordered.
SELECT 
    t.category AS Pizza_Category,
    SUM(o.quantity) AS Total_Orders
FROM
    order_details o
        JOIN
    pizzas p ON o.pizza_id = p.pizza_id
        JOIN
    pizza_types t ON t.pizza_type_id = p.pizza_type_id
GROUP BY t.category
ORDER BY Total_Orders DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) Hour_of_the_Day,
    COUNT(order_id)  Orders_in_the_Hour
FROM
    orders
GROUP BY HOUR(order_time)
ORDER BY Hour_of_the_Day;

-- Find the category wise distribution of pizzas
SELECT 
    category AS Category, COUNT(pizza_type_id) AS Pizza_Count
FROM
    pizza_types
GROUP BY category;

-- Determine the top 3 most ordered pizza types based on revenue
SELECT 
    t.category AS Pizza_Type,
    ROUND(SUM(o.quantity * p.price), 2) AS Revenue
FROM
    pizza_types t
        JOIN
    pizzas p ON p.pizza_type_id = t.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY t.category
ORDER BY revenue desc LIMIT 3;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(qty), 0) as Avg_No_Pizza_per_Day
FROM
    (SELECT 
        (order_date), SUM(quantity) AS qty
    FROM
        orders o
    JOIN order_details d ON o.order_id = d.order_id
    GROUP BY (order_date)) AS date;
    
-- Determine the top 3 most ordered pizza types based on revenue
SELECT 
	t.name AS Pizza_Type,
    ROUND(SUM(o.quantity * p.price), 2) AS Revenue
FROM  pizza_types t
        JOIN
    pizzas p ON p.pizza_type_id = t.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY t.name
ORDER BY revenue desc LIMIT 3;