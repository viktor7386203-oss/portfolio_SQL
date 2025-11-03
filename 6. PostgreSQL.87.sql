WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.second_name,
        SUM(po.price * po.count) AS total_sales
    FROM
        pharma_orders po
    JOIN
        customers c ON po.customer_id = c.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.second_name
)
SELECT
    customer_id,
    first_name,
    last_name,
    second_name,
    total_sales,
    ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS rank
FROM
    customer_totals
ORDER BY
    rank
LIMIT 10;
