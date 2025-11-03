WITH gorzdrav_customers AS (
    SELECT
        c.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        COUNT(po.order_id) AS order_count
    FROM
        pharma_orders po
    JOIN
        customers c ON po.customer_id = c.customer_id
    WHERE
        po.pharmacy_name = 'Горздрав'
    GROUP BY
        c.customer_id,
        c.last_name,
        c.first_name,
        c.second_name
    ORDER BY
        order_count DESC
    LIMIT 10
),
zdravsiti_customers AS (
    SELECT
        c.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        COUNT(po.order_id) AS order_count
    FROM
        pharma_orders po
    JOIN
        customers c ON po.customer_id = c.customer_id
    WHERE
        po.pharmacy_name = 'Здравсити'
    GROUP BY
        c.customer_id,
        c.last_name,
        c.first_name,
        c.second_name
    ORDER BY
        order_count DESC
    LIMIT 10
)
SELECT
    'Горздрав' AS pharmacy_name,
    customer_id,
    full_name,
    order_count
FROM
    gorzdrav_customers
UNION ALL
SELECT
    'Здравсити' AS pharmacy_name,
    customer_id,
    full_name,
    order_count
FROM
    zdravsiti_customers
ORDER BY
    pharmacy_name,
    order_count DESC;
