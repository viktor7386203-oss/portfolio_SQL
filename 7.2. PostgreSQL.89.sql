WITH customer_cumulative_sales AS (
    SELECT
        c.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        po.report_date,
        SUM(po.price * po.count) OVER (PARTITION BY c.customer_id ORDER BY po.report_date) AS cumulative_sales,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY po.report_date DESC) AS rn
    FROM
        pharma_orders po
    JOIN
        customers c ON po.customer_id = c.customer_id
)
SELECT
    customer_id,
    full_name,
    cumulative_sales
FROM
    customer_cumulative_sales
WHERE
    rn = 1
ORDER BY
    customer_id;
