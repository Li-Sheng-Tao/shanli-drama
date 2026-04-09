USE shanli_drama;

-- 插入每日任务
INSERT INTO daily_tasks (task_key, task_name, description, coin_reward, target_value, task_type, sort_order) VALUES
('watch_1min', '看剧1分钟', '观看视频1分钟', 5, 60, 'watch_duration', 1),
('watch_5min', '看剧5分钟', '观看视频5分钟', 20, 300, 'watch_duration', 2),
('watch_10min', '看剧10分钟', '观看视频10分钟', 50, 600, 'watch_duration', 3),
('checkin', '每日签到', '每天签到领取金币', 10, 1, 'checkin', 4),
('share_drama', '分享剧集', '分享剧集到微信', 20, 1, 'share', 5),
('reserve_drama', '预约剧集', '预约即将上新的剧集', 10, 1, 'reserve', 6);

-- 插入系统配置
INSERT INTO system_configs (config_key, config_value, description) VALUES
('coin_per_minute', '5', '每分钟观看获得金币数'),
('max_daily_coin', '60', '每日观看金币上限'),
('vip_week_price', '9.90', '周会员价格'),
('vip_month_price', '29.90', '月会员价格'),
('vip_quarter_price', '79.90', '季会员价格'),
('vip_year_price', '199.90', '年会员价格');

-- 插入广告配置
INSERT INTO advertisements (ad_position, ad_provider, ad_unit_id, priority, is_active) VALUES
('splash', 'pangolin', 'splash_ad_unit_id', 1, TRUE),
('unlock', 'pangolin', 'unlock_ad_unit_id', 1, TRUE),
('feed', 'pangolin', 'feed_ad_unit_id', 1, TRUE);

-- 插入宝箱配置
INSERT INTO blind_boxes (box_name, box_type, coin_cost, probability_config, is_active) VALUES
('小宝箱', 'small', 100, '{"min": 50, "max": 200}', TRUE),
('中宝箱', 'medium', 500, '{"min": 300, "max": 800}', TRUE),
('大宝箱', 'large', 1000, '{"min": 800, "max": 2000}', TRUE);

-- 插入测试剧集（5个）
INSERT INTO dramas (title, cover_url, vertical_cover_url, description, genre, tags, episode_count, status, is_exclusive, is_new, play_count, collect_count, sort_weight) VALUES
('总裁的替身新娘', 'https://example.com/covers/drama1.jpg', 'https://example.com/covers/drama1_v.jpg', '豪门总裁与替身新娘的虐恋情深', '甜宠', '总裁,替身,甜宠', 100, 'serial', TRUE, TRUE, 10000, 500, 100),
('重生之复仇女王', 'https://example.com/covers/drama2.jpg', 'https://example.com/covers/drama2_v.jpg', '重生后复仇虐渣，成为女王', '逆袭', '重生,复仇,逆袭', 80, 'serial', FALSE, TRUE, 8000, 400, 90),
('穿越时空爱上你', 'https://example.com/covers/drama3.jpg', 'https://example.com/covers/drama3_v.jpg', '穿越时空与古代王爷的浪漫爱情', '穿越', '穿越,爱情,王爷', 120, 'serial', TRUE, FALSE, 15000, 800, 95),
('神秘庄园的秘密', 'https://example.com/covers/drama4.jpg', 'https://example.com/covers/drama4_v.jpg', '庄园里的悬疑案件，揭开真相', '悬疑', '悬疑,推理,庄园', 60, 'finished', FALSE, FALSE, 5000, 300, 80),
('霸道王爷俏王妃', 'https://example.com/covers/drama5.jpg', 'https://example.com/covers/drama5_v.jpg', '霸道王爷与俏皮王妃的欢喜冤家', '甜宠', '王爷,王妃,甜宠', 90, 'serial', TRUE, TRUE, 12000, 600, 85);

-- 插入测试单集（每个剧集10集）
INSERT INTO episodes (drama_id, episode_number, title, description, video_url, duration_seconds, is_free, coin_cost, sort_order) VALUES
(1, 1, '第1集', '初次相遇', 'https://example.com/videos/drama1_ep1.mp4', 180, TRUE, 0, 1),
(1, 2, '第2集', '意外同居', 'https://example.com/videos/drama1_ep2.mp4', 180, TRUE, 0, 2),
(1, 3, '第3集', '误会重重', 'https://example.com/videos/drama1_ep3.mp4', 180, FALSE, 10, 3),
(1, 4, '第4集', '真相大白', 'https://example.com/videos/drama1_ep4.mp4', 180, FALSE, 10, 4),
(1, 5, '第5集', '甜蜜日常', 'https://example.com/videos/drama1_ep5.mp4', 180, FALSE, 10, 5),
(1, 6, '第6集', '危机降临', 'https://example.com/videos/drama1_ep6.mp4', 180, FALSE, 10, 6),
(1, 7, '第7集', '携手共渡', 'https://example.com/videos/drama1_ep7.mp4', 180, FALSE, 10, 7),
(1, 8, '第8集', '幸福时光', 'https://example.com/videos/drama1_ep8.mp4', 180, FALSE, 10, 8),
(1, 9, '第9集', '意外惊喜', 'https://example.com/videos/drama1_ep9.mp4', 180, FALSE, 10, 9),
(1, 10, '第10集', '完美结局', 'https://example.com/videos/drama1_ep10.mp4', 180, FALSE, 10, 10),
(2, 1, '第1集', '重生归来', 'https://example.com/videos/drama2_ep1.mp4', 180, TRUE, 0, 1),
(2, 2, '第2集', '复仇开始', 'https://example.com/videos/drama2_ep2.mp4', 180, TRUE, 0, 2),
(2, 3, '第3集', '虐渣打脸', 'https://example.com/videos/drama2_ep3.mp4', 180, FALSE, 10, 3),
(2, 4, '第4集', '身份曝光', 'https://example.com/videos/drama2_ep4.mp4', 180, FALSE, 10, 4),
(2, 5, '第5集', '女王崛起', 'https://example.com/videos/drama2_ep5.mp4', 180, FALSE, 10, 5),
(2, 6, '第6集', '商业帝国', 'https://example.com/videos/drama2_ep6.mp4', 180, FALSE, 10, 6),
(2, 7, '第7集', '爱情萌芽', 'https://example.com/videos/drama2_ep7.mp4', 180, FALSE, 10, 7),
(2, 8, '第8集', '危机四伏', 'https://example.com/videos/drama2_ep8.mp4', 180, FALSE, 10, 8),
(2, 9, '第9集', '终极对决', 'https://example.com/videos/drama2_ep9.mp4', 180, FALSE, 10, 9),
(2, 10, '第10集', '大结局', 'https://example.com/videos/drama2_ep10.mp4', 180, FALSE, 10, 10);
