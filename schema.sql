CREATE TABLE customer_campaign_performance (
    transaction_id VARCHAR(20) PRIMARY KEY,
    transaction_date DATE,
    brand_name VARCHAR(100),
    category VARCHAR(50),
    customer_segment VARCHAR(50),
    campaign_channel VARCHAR(50),
    campaign_period VARCHAR(20),
    impressions INT,
    clicks INT,
    conversions INT,
    units_sold INT,
    revenue_eur NUMERIC(10,2),
    avg_basket_eur NUMERIC(10,2),
    satisfaction_score NUMERIC(3,2)
);
