
-- Clculate the percentage contribution of each piza type to total revenue.
SELECT 
    category, concat (ROUND(((ROUND(SUM(quantity * price), 2) / (SELECT 
                    ROUND(SUM(o.quantity * p.price), 2) AS Revenue
                FROM
                    order_details o
                        JOIN
                    pizzas p ON o.pizza_id = p.pizza_id)) * 100),
            2) ,'%')AS category_rev
FROM
    pizza_types t
        JOIN
    pizzas p ON p.pizza_type_id = t.pizza_type_id
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY category