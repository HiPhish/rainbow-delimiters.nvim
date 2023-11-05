SELECT (1 + (2 + (3 + (4 + (5 + (6 + (7 + (8 + ((9) + (0))))))))));

SELECT
    (1 + ((2)((())) - 3)) AS "expression",
    (()) AS "list",
    -- ((((())))) AS "list" -- this will cause problems with the highlighting!
    "users"."id" AS "user_id",
    SUM("orders"."sum_prices") AS "user_orders_amount"
FROM "users"
JOIN (
    SELECT
        "orders"."id",
        "orders"."user_id",
        SUM("orders"."amount") AS "sum_prices"
    FROM "orders"
    GROUP BY
        "orders"."id",
        "orders"."user_id"
) AS "orders" ON "orders"."user_id" = "users"."id"
WHERE "users"."age" = (2 + (3 * 4)) AND (4 - (5 * 0)) = (1 * (2 + 2 + (5)))
    AND "users"."id" IN (1, 2, 3, 4)
GROUP BY
    "users"."id";

SELECT *
FROM products
where (
    Product_Category = 'Fit'
	AND  Product_number IN (1234, 1235, 1236, 1237, 1238)
)
or
	(Product_Category IN ('Tight', 'Wide') AND Product_number = 1324);

SELECT 10 FROM generate_series(1, 10) WHERE (TRUE);
