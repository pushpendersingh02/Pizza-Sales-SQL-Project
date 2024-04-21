-- Rank pizzas based on revenue for each pizza category.
select  t.Category, t.Name,sum(d.quantity * p.price) AS Revenue , 
dense_rank() 
over 
(partition by  t.category order by sum(d.quantity * p.price) desc) 
as Pizza_Rank
from orders o
        JOIN
    order_details d ON o.order_id = d.order_id
        JOIN
    pizzas p ON p.pizza_id = d.pizza_id 
		JOIN
	pizza_types t on t.pizza_type_id=p.pizza_type_id
    group by  t.category, t.name;

-- Calculate the percentage contribution of each piza type to total revenue.
SELECT Category, concat (ROUND(((ROUND(SUM(quantity * price), 2) / (SELECT 
                    ROUND(SUM(o.quantity * p.price), 2) AS Revenue
                FROM order_details o
                        JOIN
                pizzas p ON o.pizza_id = p.pizza_id)) * 100),
            2) ,'%')AS Category_Rev_Percentage
FROM pizza_types t
        JOIN
    pizzas p ON p.pizza_type_id = t.pizza_type_id
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY category;


-- Analyze the cumulative revenue generated over time.
SELECT order_date,
round(sum(Revenue) over(order by order_date),2) AS Cumulative_Revenue FROM 
(SELECT 
    Order_date, ROUND(SUM(d.quantity * p.price), 2) AS Revenue
FROM
    orders o
        JOIN
    order_details d ON o.order_id = d.order_id
        JOIN
    pizzas p ON p.pizza_id = d.pizza_id
GROUP BY order_date
ORDER BY o.order_date) as Data;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT Category, Name, Revenue FROM
	(SELECT  t.category, t.name,sum(d.quantity * p.price) AS Revenue , 
	dense_rank() 
    OVER (partition by  t.category order by sum(d.quantity * p.price) desc) AS rnk 
	FROM orders o
        JOIN
    order_details d ON o.order_id = d.order_id
        JOIN
    pizzas p ON p.pizza_id = d.pizza_id 
		JOIN
	pizza_types t ON t.pizza_type_id=p.pizza_type_id
    GROUP BY  t.category, t.name) AS Data WHERE rnk<=3;