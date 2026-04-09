-- 山狸看剧数据库初始化脚本
-- 创建数据库
CREATE DATABASE IF NOT EXISTS shanli_drama CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE shanli_drama;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    openid VARCHAR(255) UNIQUE,
    unionid VARCHAR(255),
    phone VARCHAR(20) UNIQUE,
    nickname VARCHAR(100) DEFAULT '',
    avatar VARCHAR(500) DEFAULT '',
    gender INT DEFAULT 0,
    vip_level INT DEFAULT 0,
    vip_expire_at DATETIME,
    coin_balance INT DEFAULT 0,
    total_watch_seconds INT DEFAULT 0,
    status INT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_phone (phone),
    INDEX idx_openid (openid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 剧集表
CREATE TABLE IF NOT EXISTS dramas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    cover_url VARCHAR(500) DEFAULT '',
    vertical_cover_url VARCHAR(500) DEFAULT '',
    description TEXT DEFAULT '',
    genre VARCHAR(100) DEFAULT '',
    tags VARCHAR(500) DEFAULT '',
    episode_count INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'serial',
    is_exclusive BOOLEAN DEFAULT FALSE,
    is_new BOOLEAN DEFAULT FALSE,
    play_count INT DEFAULT 0,
    collect_count INT DEFAULT 0,
    sort_weight INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_is_new (is_new),
    INDEX idx_sort_weight (sort_weight)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 单集表
CREATE TABLE IF NOT EXISTS episodes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    drama_id INT NOT NULL,
    episode_number INT NOT NULL,
    title VARCHAR(255) DEFAULT '',
    description TEXT DEFAULT '',
    video_url VARCHAR(500) DEFAULT '',
    duration_seconds INT DEFAULT 0,
    is_free BOOLEAN DEFAULT TRUE,
    coin_cost INT DEFAULT 0,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (drama_id) REFERENCES dramas(id) ON DELETE CASCADE,
    INDEX idx_drama_id (drama_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 观看记录表
CREATE TABLE IF NOT EXISTS watch_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    drama_id INT NOT NULL,
    episode_id INT NOT NULL,
    watch_progress_seconds INT DEFAULT 0,
    watch_duration_seconds INT DEFAULT 0,
    completed BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (drama_id) REFERENCES dramas(id) ON DELETE CASCADE,
    FOREIGN KEY (episode_id) REFERENCES episodes(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_drama_id (drama_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 收藏表
CREATE TABLE IF NOT EXISTS favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    drama_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (drama_id) REFERENCES dramas(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_drama (user_id, drama_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 关注表
CREATE TABLE IF NOT EXISTS user_follows (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    follow_user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (follow_user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_follow (user_id, follow_user_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 金币流水表
CREATE TABLE IF NOT EXISTS coin_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    amount INT NOT NULL,
    balance_after INT NOT NULL,
    description VARCHAR(500) DEFAULT '',
    related_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 每日任务表
CREATE TABLE IF NOT EXISTS daily_tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_key VARCHAR(100) UNIQUE NOT NULL,
    task_name VARCHAR(255) NOT NULL,
    description TEXT DEFAULT '',
    coin_reward INT NOT NULL,
    target_value INT NOT NULL,
    task_type VARCHAR(50) NOT NULL,
    sort_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 用户每日任务记录
CREATE TABLE IF NOT EXISTS user_daily_tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    task_id INT NOT NULL,
    progress INT DEFAULT 0,
    completed BOOLEAN DEFAULT FALSE,
    reward_claimed BOOLEAN DEFAULT FALSE,
    task_date VARCHAR(10) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES daily_tasks(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_task_date (user_id, task_id, task_date),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 签到记录表
CREATE TABLE IF NOT EXISTS user_checkins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    checkin_date VARCHAR(10) UNIQUE NOT NULL,
    day_number INT NOT NULL,
    coin_reward INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- VIP订单表
CREATE TABLE IF NOT EXISTS vip_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_no VARCHAR(100) UNIQUE NOT NULL,
    plan_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    pay_method VARCHAR(50),
    pay_status VARCHAR(50) DEFAULT 'pending',
    pay_time DATETIME,
    vip_start_at DATETIME,
    vip_expire_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_order_no (order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 评论表
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    drama_id INT NOT NULL,
    episode_id INT,
    content TEXT NOT NULL,
    parent_id INT,
    like_count INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (drama_id) REFERENCES dramas(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_drama_id (drama_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 点赞表
CREATE TABLE IF NOT EXISTS user_likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    target_type VARCHAR(50) NOT NULL,
    target_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_target (user_id, target_type, target_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 广告配置表
CREATE TABLE IF NOT EXISTS advertisements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ad_position VARCHAR(50) NOT NULL,
    ad_provider VARCHAR(50) DEFAULT 'pangolin',
    ad_unit_id VARCHAR(255) NOT NULL,
    priority INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_ad_position (ad_position)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 宝箱配置表
CREATE TABLE IF NOT EXISTS blind_boxes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    box_name VARCHAR(255) NOT NULL,
    box_type VARCHAR(50) NOT NULL,
    coin_cost INT NOT NULL,
    probability_config TEXT DEFAULT '{}',
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 系统配置表
CREATE TABLE IF NOT EXISTS system_configs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    config_key VARCHAR(100) UNIQUE NOT NULL,
    config_value TEXT NOT NULL,
    description VARCHAR(500) DEFAULT '',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
