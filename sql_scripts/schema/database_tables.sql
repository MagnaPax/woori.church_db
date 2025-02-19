-- This file contains SQL statements to create the necessary


-- /////////////////////////////
-- 사용자
-- /////////////////////////////

-- 아이디, 비밀번호, 이메일, 사용자권한
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT CHECK(role IN ('admin', 'member')) DEFAULT 'member'
);


-- ///////////////////////////// 
-- 교회소개
-- /////////////////////////////

-- 환영합니다
CREATE TABLE IF NOT EXISTS church_introduction (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    welcome_message TEXT NOT NULL
);

-- 섬기는 사람들
CREATE TABLE IF NOT EXISTS leaders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    position TEXT NOT NULL,
    biography TEXT
);

-- 교회 발자취
CREATE TABLE IF NOT EXISTS church_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT NOT NULL
);


-- 교회위치 (본관, 주차장 등)
CREATE TABLE IF NOT EXISTS church_location (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    naver_api TEXT,
    kakao_api TEXT,
    google_api TEXT
);

-- 새가족 안내
CREATE TABLE IF NOT EXISTS newcomers_topics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL
);



-- /////////////////////////////
-- 예배안내
-- /////////////////////////////


-- 주일, 수요예배 등
CREATE TABLE IF NOT EXISTS services (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    schedule TEXT NOT NULL,
    location TEXT NOT NULL
);



-- /////////////////////////////
-- 말씀과 찬양
-- /////////////////////////////

-- 설교 영상
CREATE TABLE IF NOT EXISTS sermon_videos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    video_url TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT
);


-- 실시간 예배
CREATE TABLE IF NOT EXISTS realtime_service_broadcasting (
    video_url TEXT PRIMARY KEY
);


-- 그 외 영상들(특강 등)
CREATE TABLE IF NOT EXISTS special_service_videos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    video_url TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT
);


-- ///////////////////////////// 
-- 교회소식
-- /////////////////////////////

-- 공지사항
CREATE TABLE IF NOT EXISTS announcements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    date_posted DATE NOT NULL
);

-- 특별 이벤트들
CREATE TABLE IF NOT EXISTS events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    date_time DATETIME NOT NULL,
    location TEXT NOT NULL
);

-- 달력
CREATE TABLE IF NOT EXISTS calendar (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY(event_id) REFERENCES events(id)
);

-- 주보
CREATE TABLE IF NOT EXISTS newsletters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    issue_date DATE NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    archive_link TEXT
);


-- /////////////////////////////
-- 미디어
-- /////////////////////////////

-- 사진 갤러리
CREATE TABLE IF NOT EXISTS photos_gallery (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    image_path TEXT NOT NULL,
    caption TEXT
);

-- 영상
CREATE TABLE IF NOT EXISTS videos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    video_url TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT
);