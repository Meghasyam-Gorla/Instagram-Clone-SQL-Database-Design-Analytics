# Instagram Clone – SQL Database Design & Analytics

## 📌 Project Overview
This project focuses on designing and implementing a relational database for an Instagram-like social media platform and performing SQL-based analytics to extract meaningful insights from user activity data. The system models core social media entities such as users, posts, comments, likes, followers, and hashtags, and supports advanced analytical queries and stored procedures.

Synthetic data (5,000+ users and large-scale interactions) was generated using Python (Faker) to simulate real-world usage patterns while maintaining logical data constraints (e.g., post dates occur after user creation dates).

---

## 🛠️ Tech Stack
- **Database:** MySQL / SQL Server  
- **Data Generation:** Python (Faker)  
- **Tools:** MySQL Workbench / SQL Server Management Studio, GitHub  

---

## 🗂️ Database Schema

### Core Tables
- `users(user_id, username, email, full_name, bio, profile_pic, created_at, is_private, is_verified)`
- `posts(post_id, user_id, caption, media_url, created_at, location)`
- `comments(comment_id, post_id, user_id, comment_text, created_at)`
- `likes(like_id, post_id, user_id, created_at)`
- `followers(follower_id, following_id, followed_at)`
- `hashtags(hashtag_id, tag)`
- `post_hashtags(post_id, hashtag_id)`

**Relationships:**
- One user → many posts  
- One post → many likes & comments  
- Many-to-many: posts ↔ hashtags (via `post_hashtags`)  
- Many-to-many: users ↔ users (followers)

---

## 📊 Key Business Questions Answered

1. How many users signed up each month?  
2. Which users are the most active by number of posts?  
3. What percentage of users have never posted any content?  
4. What is the average number of posts per user?  
5. Which users joined in the last 30 days and have posted at least once?  
6. Which posts have the highest number of likes?  
7. Which posts have the highest number of comments?  
8. What is the average likes and comments per post?  
9. Which posts have zero likes or zero comments?  
10. Which users receive the highest total engagement (likes + comments) on their posts?  
11. Which hashtags are used the most across all posts?  
12. Which hashtags drive the highest average likes per post?  
13. Which users use hashtags most frequently?  
14. Who are the top 10 most followed users?  
15. Which users follow many accounts but have very few followers (potential spam behavior)?  
16. Which users have zero posts, zero followers, and zero likes received?  
17. Which newly created users show unusually high activity?  

---

## ⚙️ Advanced SQL (Stored Procedures)

- **Top N Most Liked Posts**  
  Parameterized stored procedure to return the most liked posts dynamically.

- **User Engagement Summary**  
  Stored procedure to return total posts, likes received, comments received, and followers for a given user.

- **Monthly Growth Report**  
  Stored procedure to generate monthly new users, posts, and likes metrics.

---

## 🚨 Fake / Suspicious Account Detection
Basic heuristics were applied to flag potential fake or low-quality accounts, such as:
- Users with zero posts and zero followers    
- Recently created users with abnormal activity  

---

## 📁 Repository Structure

```text
instagram-clone-sql-analysis/
│
├── schema.sql          # Table creation scripts
├── users.csv           # Synthetic user data (generated using Faker)
├── posts.csv
├── comments.csv
├── likes.csv
├── followers.csv
├── hashtags.csv
├── post_hashtags.csv
├── queries.sql         # Analytical SQL queries
└── README.md           # Project documentation



---

## 🚀 How to Run

1. Create the database and tables using `schema.sql`.
2. Import CSV files into the respective tables.
3. Execute queries from `queries.sql` to reproduce insights.
4. (Optional) Run stored procedures for automated reports.

---

## 📈 Sample Insights

- Identified top-performing posts based on likes and comments.  
- Discovered high-engagement hashtags driving user interactions.  
- Highlighted power users and potential spam accounts using follower patterns.  
- Analyzed monthly user growth and engagement trends.

---

## 🎯 What This Project Demonstrates

- Relational database design and normalization  
- Realistic synthetic data generation  
- Complex SQL joins and aggregations  
- Time-based analytics  
- Stored procedures for reusable reporting  
- Practical social media analytics use cases  

---

## 📬 Contact
If you’d like to discuss this project or provide feedback, feel free to connect with me on LinkedIn.
https://www.linkedin.com/in/meghasyam-gorla-8173a0248/

---

## 🙌 Author
Gorla Meghasyam
Aspiring Data Scientist | Python | Sql | Power-BI


