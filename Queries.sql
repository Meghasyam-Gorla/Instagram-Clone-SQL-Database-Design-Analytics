use instaclonedb;

-- How many users signed up each month?
select year(created_at) as year,monthname(created_at) as month,count(*) as count
from users
group by year(created_at),monthname(created_at);

-- Which users are the most active by number of posts?
select u.username,u.fullname, u.userid, count(*) as count from posts as p
inner join users as u
on p.userid = u.userid
group by u.userid
order by count desc
limit 5;

-- What percentage of users have never posted any content?
SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN p.postid IS NULL THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS percent_users_with_no_posts
FROM users u
LEFT JOIN posts p
    ON u.userid = p.userid;
    
-- What is the average number of posts per user?
SELECT 
    ROUND(AVG(post_count), 2) AS avg_posts_per_user
FROM (
    SELECT 
        u.userid,
        COUNT(p.postid) AS post_count
    FROM users u
    LEFT JOIN posts p
        ON u.userid = p.userid
    GROUP BY u.userid
) t;

-- Which users joined in the last 30 days and have posted at least once?
select distinct u.userid, u.username,u.fullname,u.created_at from users u
inner join posts p
on p.userid = u.userid
where datediff(current_date(),date(u.created_at)) <= 30;

-- Which posts have the highest number of likes? (Top 10)
select postid, count(*) as count from likes
group by postid
order by count desc
limit 10;

-- Which posts have the highest number of comments? (Top 10)
select postid, count(*) as count from comments
group by postid
order by count desc
limit 10;

-- What is the average likes and comments per post?
SELECT 
    ROUND(AVG(likes_count), 2) AS avg_likes_per_post,
    ROUND(AVG(comments_count), 2) AS avg_comments_per_post
FROM (
    SELECT 
        p.postid,
        COUNT(DISTINCT l.likeid) AS likes_count,
        COUNT(DISTINCT c.commentid) AS comments_count
    FROM posts p
    LEFT JOIN likes l 
        ON p.postid = l.postid
    LEFT JOIN comments c 
        ON p.postid = c.postid
    GROUP BY p.postid
) t;

-- Which posts have zero likes or zero comments?
select * from (select p.postid, count(l.likeid) as likes_count, count(c.commentid) as comments_count
from posts p
left join likes l
on p.postid = l.postid
left join comments c
on p.postid = c.postid
group by p.postid) as t
where t.likes_count = 0 or t.comments_count = 0;

-- Which users receive the highest total engagement (likes + comments) on their posts?
select u.userid,u.username,p.postid, count(l.likeid) + count(c.commentid) as total
from posts p
inner join users u
on u.userid = p.userid
left join likes l
on p.postid = l.postid
left join comments c
on p.postid = c.postid
group by p.postid
order by total desc;

-- Which hashtags are used the most across all posts?
select h.tag, count(p.postid) as count from hashtags h
inner join post_hashtags as p
on h.hashtag_id = p.hashtag_id
group by h.tag
order by count desc;

-- Which hashtags drive the highest average likes per post?
SELECT 
    h.tag,
    ROUND(AVG(likes_per_post), 2) AS avg_likes_per_post
FROM (
    SELECT 
        ph.hashtag_id,
        p.postid,
        COUNT(l.likeid) AS likes_per_post
    FROM post_hashtags ph
    JOIN posts p
        ON ph.postid = p.postid
    LEFT JOIN likes l
        ON p.postid = l.postid
    GROUP BY ph.hashtag_id, p.postid
) t
JOIN hashtags h
    ON t.hashtag_id = h.hashtag_id
GROUP BY h.tag
ORDER BY avg_likes_per_post DESC;

-- Which users use hashtags most frequently in their posts?
select u.userid,u.username,count(ph.hashtag_id) as count
from users u 
left join posts p
on u.userid = p.userid
left join post_hashtags ph
on p.postid = ph.postid
group by u.userid
order by count desc;
 
 -- Who are the top 10 most followed users?
 select following_id, count(*) from followers
 group by following_id
 order by count(*) desc
 limit 5;
 
 -- Which users follow many accounts?
select follower_id, count(follower_id) as count1
from followers
group by follower_id
order by count1 desc;

-- Which users have zero posts, zero followers, and zero likes received?
select u.userid, count(p.postid) as count1,
count(l.likeid) as count2,count(c.commentid) as count3
from users u
left join posts p
on u.userid = p.userid
left join likes l
on l.postid = p.postid
left join comments c
on c.postid = p.postid
group by u.userid
having count1 = 0 and count2 = 0 and count3 = 0;

-- What is the monthly growth of users, posts, and likes?
with months as (select year(u.created_at) as yr, monthname(u.created_at) as mo
from users u
union
select year(p.created_at), monthname(p.created_at) 
from posts p
union
select year(l.created_at),monthname(l.created_at)
from likes l),
a as (select year(created_at) as yr,monthname(created_at) as mo, count(*) as new_users
from users
group by year(created_at),monthname(created_at)),
b as (select year(created_at) as yr,monthname(created_at) as mo, count(*) as total_posts
from posts
group by year(created_at),monthname(created_at)),
c as (select year(created_at) as yr,monthname(created_at) as mo, count(*) as total_likes
from likes
group by year(created_at),monthname(created_at))

SELECT m.yr AS year,m.mo AS month,
COALESCE(a.new_users, 0) AS new_users,
COALESCE(b.total_posts, 0) AS total_posts,
COALESCE(c.total_likes, 0) AS total_likes
FROM months m
LEFT JOIN a ON m.yr = a.yr AND m.mo = a.mo
LEFT JOIN b ON m.yr = b.yr AND m.mo = b.mo
LEFT JOIN c ON m.yr = c.yr AND m.mo = c.mo
ORDER BY year, month;










