INSERT INTO SGH_PAGE_CONTENT (PAGE_KEY, PAGE_TITLE, CONTENT_HTML, UPDUSR) VALUES
    ('about_intro',    '공간 소개',   '<p>공간 소개 내용을 입력하세요.</p>', 'admin'),
    ('about_facility', '시설 안내',   '<p>시설 안내 내용을 입력하세요.</p>', 'admin'),
    ('about_org',      '운영 조직',   '<p>운영 조직 내용을 입력하세요.</p>', 'admin'),
    ('about_location', '오시는 길',   '<p>오시는 길 내용을 입력하세요.</p>', 'admin'),
    ('space_guide',    '대관 안내',   '<p>대관 안내 내용을 입력하세요.</p>', 'admin'),
    ('support_policy', '청년정책',    '<p>청년정책 내용을 입력하세요.</p>', 'admin'),
    ('support_job',    '일자리 정보', '<p>일자리 정보 내용을 입력하세요.</p>', 'admin'),
    ('support_counsel','청년 상담',   '<p>청년 상담 내용을 입력하세요.</p>', 'admin')
ON DUPLICATE KEY UPDATE PAGE_KEY = PAGE_KEY;
