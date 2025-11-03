SELECT
    c.customer_id,
    CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
    po.report_date,
    po.price * po.count AS order_total,
    SUM(po.price * po.count) OVER (PARTITION BY c.customer_id ORDER BY po.report_date) AS cumulative_sales
FROM
    pharma_orders po
JOIN
    customers c ON po.customer_id = c.customer_id
ORDER BY
    c.customer_id,
    po.report_date;
