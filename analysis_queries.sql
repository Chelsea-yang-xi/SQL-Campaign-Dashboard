-- 1. Revenue by brand
SELECT brand_name,
       category,
       ROUND(SUM(revenue_eur), 2) AS total_revenue
FROM customer_campaign_performance
GROUP BY brand_name, category
ORDER BY total_revenue DESC;

-- 2. Conversion rate by campaign channel
SELECT campaign_channel,
       SUM(clicks) AS total_clicks,
       SUM(conversions) AS total_conversions,
       ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate_pct
FROM customer_campaign_performance
GROUP BY campaign_channel
ORDER BY conversion_rate_pct DESC;

-- 3. Average basket value by customer segment
SELECT customer_segment,
       ROUND(AVG(avg_basket_eur), 2) AS avg_basket_value
FROM customer_campaign_performance
GROUP BY customer_segment
ORDER BY avg_basket_value DESC;

-- 4. Campaign impact by category and campaign period
SELECT category,
       campaign_period,
       ROUND(SUM(revenue_eur), 2) AS total_revenue,
       ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction
FROM customer_campaign_performance
GROUP BY category, campaign_period
ORDER BY category, total_revenue DESC;

-- 5. Ranking brands within category by revenue
SELECT brand_name,
       category,
       ROUND(SUM(revenue_eur), 2) AS total_revenue,
       RANK() OVER (PARTITION BY category ORDER BY SUM(revenue_eur) DESC) AS category_rank
FROM customer_campaign_performance
GROUP BY brand_name, category
ORDER BY category, category_rank;

-- 6. Underperforming campaigns: high impressions, low conversions
SELECT brand_name,
       campaign_channel,
       SUM(impressions) AS total_impressions,
       SUM(conversions) AS total_conversions,
       ROUND(100.0 * SUM(conversions) / NULLIF(SUM(impressions),0), 2) AS impression_to_conversion_pct
FROM customer_campaign_performance
GROUP BY brand_name, campaign_channel
HAVING SUM(impressions) > 20000 AND SUM(conversions) < 200
ORDER BY impression_to_conversion_pct ASC;
