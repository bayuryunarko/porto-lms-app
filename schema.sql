-- ========================================================
-- 1. SCHEMA UNTUK AUTH SERVICE (Database: auth_db)
-- ========================================================
\c auth_db;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'siswa'
);

-- Membuat Index untuk mempercepat pencarian login
CREATE INDEX ix_users_id ON users (id);
CREATE INDEX ix_users_username ON users (username);


-- ========================================================
-- 2. SCHEMA UNTUK CONTENT SERVICE (Database: content_db)
-- ========================================================
\c content_db;

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX ix_courses_id ON courses (id);

CREATE TABLE materials (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    course_id INTEGER NOT NULL REFERENCES courses(id) ON DELETE CASCADE
);
CREATE INDEX ix_materials_id ON materials (id);


-- ========================================================
-- 3. SCHEMA UNTUK ASSESSMENT SERVICE (Database: assessment_db)
-- ========================================================
\c assessment_db;

CREATE TABLE quiz_sets (
    id SERIAL PRIMARY KEY,
    title VARCHAR,
    course_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX ix_quiz_sets_id ON quiz_sets (id);
CREATE INDEX ix_quiz_sets_title ON quiz_sets (title);

CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    quiz_set_id INTEGER REFERENCES quiz_sets(id) ON DELETE CASCADE,
    no_soal INTEGER,
    topic VARCHAR,
    kategori VARCHAR,
    question TEXT,
    options JSON,
    answer VARCHAR,
    explanation TEXT
);
CREATE INDEX ix_questions_id ON questions (id);

CREATE TABLE scores (
    id SERIAL PRIMARY KEY,
    username VARCHAR,
    quiz_title VARCHAR,
    score FLOAT,
    correct_count INTEGER,
    total_questions INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX ix_scores_id ON scores (id);
CREATE INDEX ix_scores_username ON scores (username);