create database instaclonedb;
use instaclonedb;

create table users(
userid varchar(10) primary key,
username varchar(50),
email varchar(100),
fullname varchar(100),
bio text,
profile_pic varchar(255),
created_at datetime,
is_private int,
is_verified int );

create table posts(
postid varchar(10) primary key,
userid varchar(10),
caption text,
media_url varchar(255),
created_at datetime,
location varchar(100),
foreign key(userid) references users(userid) );

create table comments(
commentid varchar(10) primary key,
postid varchar(10),
userid varchar(10),
comment_text text,
created_at datetime,
foreign key(postid) references posts(postid),
foreign key(userid) references users(userid) );

create table likes(
likeid varchar(10) primary key,
postid varchar(10),
userid varchar(10),
created_at datetime,
foreign key (postid) references posts(postid),
foreign key (userid) references users(userid) );

create table followers(
follower_id varchar(10),
following_id varchar(10),
followed_at datetime,
foreign key(follower_id) references users(userid),
foreign key(following_id) references users(userid) );

create table hashtags(
hashtag_id varchar(10) primary key,
tag varchar(50) );

create table post_hashtags(
postid varchar(10),
hashtag_id varchar(10),
foreign key(postid) references posts(postid),
foreign key(hashtag_id) references hashtags(hashtag_id) );
