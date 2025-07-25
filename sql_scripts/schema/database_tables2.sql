-- SQLite는 기본적으로 외부 키(Foreign Key) 제약 조건을 강제하지 않습니다.
-- 데이터 무결성을 위해 DB에 연결할 때마다 아래 명령어를 실행하여 외부 키 제약 조건을 활성화해야 합니다.
-- PRAGMA foreign_keys = ON;

-- =================================================================
-- 1. 교회 기본 정보 (site_options)
-- 인사말, 신앙고백, 예배 시간, 전화번호 등 자주 바뀌지 않는 '정적 정보'를 관리합니다.
-- 'option_name'에 정보의 종류(예: 'greeting_message'), 'option_value'에 실제 내용을 저장합니다.
-- =================================================================
CREATE TABLE site_options (
    option_id INTEGER PRIMARY KEY AUTOINCREMENT,
    option_name TEXT NOT NULL UNIQUE, -- '인사말', '예배시간안내', '교회전화번호' 등
    option_value TEXT NOT NULL,
    description TEXT, -- 부가 설명
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- =================================================================
-- 2. 사역자 소개 (staff)
-- '교회소개 > 사역자소개' 메뉴의 데이터를 관리합니다.
-- =================================================================
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    staff_name TEXT NOT NULL,
    position TEXT, -- '담임목사', '교육전도사' 등 직분
    ministry_area TEXT, -- '담당구역'에 해당
    photo_url TEXT, -- 사역자 사진 이미지 경로
    bio TEXT, -- 간단한 소개글
    display_order INTEGER DEFAULT 0 -- 표시 순서
);

-- =================================================================
-- 3. 문의사항 (inquiries)
-- 'Contact Us > 문의 사항' 폼을 통해 접수된 내용을 저장합니다.
-- =================================================================
CREATE TABLE inquiries (
    inquiry_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sender_name TEXT NOT NULL,
    sender_email TEXT NOT NULL,
    message TEXT NOT NULL,
    is_read INTEGER DEFAULT 0, -- 0: 읽지 않음, 1: 읽음
    submitted_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- =================================================================
-- 4. 사역 부서 (ministry_departments)
-- '사역' 메뉴의 '주일학교', '중고등부' 등 각 부서 정보를 관리합니다.
-- =================================================================
CREATE TABLE ministry_departments (
    department_id INTEGER PRIMARY KEY AUTOINCREMENT,
    department_name TEXT NOT NULL UNIQUE, -- '주일학교', '중고등부' 등
    description TEXT, -- 부서 소개
    leader_id INTEGER, -- 담당 사역자 ID
    FOREIGN KEY (leader_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

-- =================================================================
-- 5. 영상 자료 (videos)
-- '예배 영상', '찬양 영상' 등 유튜브 링크를 포함한 모든 영상들을 관리합니다.
-- 'category'로 영상 종류를 구분합니다.
-- =================================================================
CREATE TABLE videos (
    video_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category TEXT NOT NULL, -- '예배 영상', '찬양 영상' 등
    title TEXT NOT NULL,
    video_url TEXT NOT NULL, -- 유튜브 링크
    speaker_name TEXT, -- 설교자/인도자 이름
    video_date TEXT, -- 영상 날짜 (예: 설교 날짜)
    description TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- =================================================================
-- 6. 교회 소식 (news)
-- 'Resources > 교회소식' 메뉴의 게시물을 관리합니다.
-- =================================================================
CREATE TABLE news (
    news_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    author_id INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    view_count INTEGER DEFAULT 0,
    FOREIGN KEY (author_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

-- =================================================================
-- 7. 자료실 파일 (resource_files)
-- '주보', '성경 통독 표' 등 파일로 업로드되는 자료들을 관리합니다.
-- =================================================================
CREATE TABLE resource_files (
    file_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category TEXT NOT NULL, -- '주보', '성경통독표' 등
    title TEXT NOT NULL,
    file_url TEXT NOT NULL, -- 업로드된 파일의 경로 (PDF 등)
    issue_date TEXT, -- 주보 발행일 등
    description TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- =================================================================
-- 8. 교인/사이트 회원 (users)
-- 기부금 영수증 신청 등 회원 기반 서비스를 위한 사용자 정보입니다.
-- =================================================================
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL, -- 실제 서비스 시에는 암호화하여 저장해야 합니다.
    real_name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone_number TEXT
);

-- =================================================================
-- 9. 기부금/헌금 내역 (donations)
-- 'Resources > 기부금 영수증' 발급의 기반이 되는 데이터를 관리합니다.
-- =================================================================
CREATE TABLE donations (
    donation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER, -- 헌금한 교인 ID
    donor_name TEXT, -- 비회원일 경우 이름
    amount REAL NOT NULL,
    donation_date TEXT NOT NULL,
    donation_type TEXT, -- '주일헌금', '십일조', '감사헌금' 등
    note TEXT, -- 비고
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);