# `CROSS JOIN`

- Returns a Cartesian product of rows from both tables
- Join every row from the first table with every row from the second table
- Does not establish a relationship between the joined tables

## Format

```sql
SELECT select_list
FROM T1 CROSS JOIN T2;
```

## Figure Explanations

<img src="../../figures/cross-join-explanation.png">

## Example of Cross Joins

Combinations of all products and stores

```sql
SELECT
    product_id,
    product_name,
    store_id,
    0 AS quantity -- Giving a default value
FROM production.products CROSS JOIN sales.stores
ORDER BY
    product_name,
    store_id;
```

Find products that have no sales across the stores

```sql
SELECT
    s.store_id,
    p.product_id,
    ISNULL(sales, 0) AS sales
FROM sales.stores AS s 
    CROSS JOIN production.products AS p
    LEFT JOIN (
        SELECT
            s.store_id,
            p.product_id,
            SUM (quantity * i.list_price) AS sales
        FROM sales.orders AS o
        INNER JOIN sales.order_items AS i ON i.order_id = o.order_id
        INNER JOIN sales.stores AS s ON s.store_id = o.store_id
        INNER JOIN production.products AS p ON p.product_id = i.product_id
        GROUP BY
            s.store_id,
            p.product_id
    ) AS c 
        ON c.store_id = s.store_id
        AND c.product_id = p.product_id
WHERE sales IS NULL
ORDER BY
    product_id,
    store_id;
```
