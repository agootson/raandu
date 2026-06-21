-- =====================================
-- RAANDU DATABASE
-- The Digital Village of South Sudan
-- =====================================

CREATE DATABASE IF NOT EXISTS raandu;

USE raandu;

-- =====================================
-- USERS
-- =====================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    country VARCHAR(100),
    bio TEXT,
    profile_picture VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================
-- POSTS
-- =====================================

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    likes_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

-- =====================================
-- COMMENTS
-- =====================================

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (post_id)
    REFERENCES posts(id)
    ON DELETE CASCADE,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

-- =====================================
-- LIKES
-- =====================================

CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE,

    FOREIGN KEY (post_id)
    REFERENCES posts(id)
    ON DELETE CASCADE
);

-- =====================================
-- FOLLOWERS
-- =====================================

CREATE TABLE followers (
    id INT AUTO_INCREMENT PRIMARY KEY,

    follower_id INT NOT NULL,
    following_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (follower_id)
    REFERENCES users(id)
    ON DELETE CASCADE,

    FOREIGN KEY (following_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

-- =====================================
-- COMMUNITIES
-- =====================================

CREATE TABLE communities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================
-- COMMUNITY MEMBERS
-- =====================================

CREATE TABLE community_members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    community_id INT NOT NULL,
    user_id INT NOT NULL,

    FOREIGN KEY (community_id)
    REFERENCES communities(id)
    ON DELETE CASCADE,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

-- =====================================
-- SAMPLE COMMUNITIES
-- =====================================

INSERT INTO communities (name, description)
VALUES
('Bor', 'Community for people from Bor'),
('Juba', 'Community for people from Juba'),
('Students', 'Student discussions and opportunities'),
('Technology', 'Tech and innovation in South Sudan'),
('Scholarships', 'Scholarship opportunities'),
('Business', 'Entrepreneurship and business');
