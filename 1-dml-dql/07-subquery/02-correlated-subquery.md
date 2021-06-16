# Correlated Subquery

- Also known as a *Repeating Subquery*
- A subquery that depends on the outer query for its values
  - Normally, a subquery executes first before the outer query
  - So typically, the outer query is the one that depends on the subquery
- **A correlated subquery is a subquery that uses the values of the outer query**
  - It depends on the outer query for its values
  - Because of this dependency, a correlated subquery cannot be executed independently as a simple subquery
  - **A correlated subquery is executed repeatedly, once for each row evaluated by the outer query**
  - You can think of Correlated Subquery as a *For-Loop-ed* query

## Example

Finds the products whose list price is equal to the highest list price of the products within the same category

A key here is to use table aliases 

```sql
SELECT
    product_name,
    list_price,
    category_id
FROM production.products AS p1
WHERE list_price IN (
    -- List of max_prices per product category
    SELECT MAX (p2.list_price)
    FROM production.products AS p2
    WHERE p2.category_id = p1.category_id
    GROUP BY p2.category_id
)
ORDER BY 
    category_id,
    product_name;
```

For each product evaluated by the outer query:

- Find the highest price of all products in its category
- If the price of the current product is equal to the highest price of all products in its category
  - Include the product in the result set
- This process continues for the next product and so on

### Equivalent Pseudo-Code

```python
for product_details in production.products:
  if list_price in max_price_per_product_category:
    result_set.append(product_details)
```
