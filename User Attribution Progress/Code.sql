--SLIDE# 4
SELECT COUNT(DISTINCT utm_campaign) AS total_campaigns
FROM page_visits
ORDER BY 1;

SELECT COUNT(DISTINCT utm_source) AS total_sources
FROM page_visits
ORDER BY 1;

SELECT DISTINCT utm_campaign, 
       utm_source
FROM page_visits;




--SLIDE# 5
SELECT DISTINCT page_name
FROM page_visits;




--SLIDE# 7
WITH first_touch AS (
   SELECT user_id, 
   MIN(timestamp) AS first_touch_at
   FROM page_visits
   GROUP BY user_id)
SELECT ft.user_id, 
       ft.first_touch_at, 
       pv.utm_source, 
       pv.utm_campaign, 
       COUNT(utm_campaign) AS ft_count
FROM first_touch ft
JOIN page_visits pv
   ON ft.user_id = pv.user_id
   AND ft.first_touch_at = pv.timestamp
GROUP BY 4
ORDER BY 5 DESC;




--SLIDE# 8
WITH last_touch AS (
   SELECT user_id, 
   MAX(timestamp) AS last_touch_at
   FROM page_visits
   GROUP BY user_id)
SELECT lt.user_id, 
       lt.last_touch_at, 
       pv.utm_source, 
       pv.utm_campaign, 
       COUNT(utm_campaign) AS lt_count
FROM last_touch lt
JOIN page_visits pv
   ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
GROUP BY 4
ORDER BY 5 DESC;




--SLIDE# 9
SELECT COUNT(DISTINCT user_id) AS users
FROM page_visits
WHERE page_name = '4 - purchase';




--SLIDE# 10
WITH last_touch AS (
   SELECT user_id, 
   MAX(timestamp) AS last_touch_at
   FROM page_visits
   WHERE page_name = '4 - purchase'
   GROUP BY user_id)
SELECT lt.user_id, 
       lt.last_touch_at, 
       pv.utm_source, 
       pv.utm_campaign, 
       COUNT(utm_campaign) AS lt_count
FROM last_touch lt
JOIN page_visits pv
   ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
GROUP BY 4
ORDER BY 5 DESC;