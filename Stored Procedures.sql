use instaclonedb;
-- Create a stored procedure to return the Top N most liked posts.
Delimiter //
create procedure top(in N int)
Begin 
select postid,count(likeid) as likes_count from likes
group by postid
order by  likes_count desc
limit N;
End //
Delimiter ;

call top(10);

-- Create a stored procedure to generate a user engagement summary (posts, likes received, comments received, followers).
Delimiter //
create procedure engagement_summary(in usr varchar(10))
Begin
select u.userid,u.username, count(p.postid), count(l.likeid),count(c.commentid),count(f.follower_id)
from users u
left join posts p
on u.userid = p.userid
left join followers f
on u.userid = f.following_id
left join likes l
on l.postid = p.postid
left join comments c
on p.postid = c.postid
group by u.userid, u.username
having u.userid = usr;
end //
Delimiter ;

call engagement_summary('USR01403');

-- Create a stored procedure to produce a monthly growth report.
delimiter //
create procedure monthly_growth(in yr int)
begin
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

select m.yr as year,m.mo as month,
coalesce(a.new_users, 0) as new_users,
coalesce(b.total_posts, 0) as total_posts,
coalesce(c.total_likes, 0) as total_likes
from months m
left join a 
on m.yr = a.yr and m.mo = a.mo
left join b 
on m.yr = b.yr and m.mo = b.mo
left join c 
on m.yr = c.yr and m.mo = c.mo
where m.yr = yr;

end //
delimiter ;

call monthly_growth(2024);


