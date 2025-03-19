### 📌 Geographic & City-Tier Trends

-- 1️⃣7️⃣ Which city tier has the highest percentage of second-hand bike sales?
```sql
SELECT ms."City Tier", 
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage_sales
FROM motorcycle_sales ms
WHERE ms."Owner Type" IN ('Second', 'Third')
GROUP BY ms."City Tier"
ORDER BY percentage_sales DESC;
```

-- 1️⃣8️⃣ Which states have the highest number of high-engine capacity (>500cc) motorcycles?
```sql
SELECT ms."State", COUNT(*) AS high_cc_bikes
FROM motorcycle_sales ms
WHERE ms."Engine Capacity (cc)" > 500
GROUP BY ms."State"
ORDER BY high_cc_bikes DESC;
```

-- 1️⃣9️⃣ How do fuel type preferences vary by city tier?
```sql
SELECT ms."City Tier", ms."Fuel Type", COUNT(*) AS fuel_type_count
FROM motorcycle_sales ms
GROUP BY ms."City Tier", ms."Fuel Type"
ORDER BY ms."City Tier", fuel_type_count DESC;
```

-- 2️⃣0️⃣ Which metro cities have the highest percentage of premium bikes (₹1,00,000+)?
```sql
SELECT ms."State", COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS premium_bike_percentage
FROM motorcycle_sales ms
WHERE ms."City Tier" = 'Metro' AND ms."Price (INR)" >= 100000
GROUP BY ms."State"
ORDER BY premium_bike_percentage DESC;
```
