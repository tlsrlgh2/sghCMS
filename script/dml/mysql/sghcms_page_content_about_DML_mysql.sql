-- =====================================================================
-- 청년공간(소개) 페이지 콘텐츠 HTML
--   대상 테이블 : SGH_PAGE_CONTENT
--   대상 키     : about_intro / about_facility / about_org / about_location
--   비고        : 화면은 ${content.contentHtml} 를 그대로 렌더링하며,
--                 OWASP 새니타이저가 class 속성을 제거하므로 인라인 style 만 사용.
--                 브랜드 컬러 : #6658d9(purple) / #493cae(dark) / #eeeaff(soft)
--                              #ff6f61(coral) / #39c6a6(mint) / #4189e8(blue)
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. 공간 소개 (about_intro)
-- ---------------------------------------------------------------------
UPDATE SGH_PAGE_CONTENT SET CONTENT_HTML = '
<div style="background:#6658d9;border-radius:18px;padding:52px 44px;color:#ffffff;margin-bottom:40px;">
  <p style="margin:0 0 10px;font-size:13px;letter-spacing:3px;font-weight:700;color:#d9d4ff;">SGH YOUTH SPACE</p>
  <h2 style="margin:0 0 16px;font-size:34px;font-weight:800;color:#ffffff;line-height:1.3;">청년의 오늘과 내일이<br>함께 머무는 공간</h2>
  <p style="margin:0;font-size:17px;line-height:1.8;color:#eeeaff;max-width:640px;">SGH 청년공간은 일과 배움, 쉼이 자연스럽게 이어지는 청년 복합문화공간입니다. 누구나 부담 없이 머물고, 연결되고, 성장할 수 있도록 언제나 열려 있습니다.</p>
</div>

<h3 style="font-size:22px;font-weight:800;color:#222233;margin:8px 0 20px;padding-left:14px;border-left:5px solid #6658d9;">우리가 추구하는 가치</h3>
<table style="width:100%;border-collapse:collapse;table-layout:fixed;margin-bottom:8px;">
  <tr>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="background:#f7f7fb;border:1px solid #e7e7ef;border-radius:16px;padding:28px 24px;height:100%;">
        <div style="font-size:30px;">🤝</div>
        <h4 style="margin:14px 0 8px;font-size:18px;font-weight:800;color:#222233;">연결</h4>
        <p style="margin:0;font-size:15px;line-height:1.7;color:#646477;">비슷한 고민을 가진 청년들이 만나 서로의 가능성을 발견하고 함께 나아갑니다.</p>
      </div>
    </td>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="background:#f7f7fb;border:1px solid #e7e7ef;border-radius:16px;padding:28px 24px;height:100%;">
        <div style="font-size:30px;">🌱</div>
        <h4 style="margin:14px 0 8px;font-size:18px;font-weight:800;color:#222233;">성장</h4>
        <p style="margin:0;font-size:15px;line-height:1.7;color:#646477;">교육, 멘토링, 커뮤니티 프로그램을 통해 한 걸음 더 나은 내일을 준비합니다.</p>
      </div>
    </td>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="background:#f7f7fb;border:1px solid #e7e7ef;border-radius:16px;padding:28px 24px;height:100%;">
        <div style="font-size:30px;">🚀</div>
        <h4 style="margin:14px 0 8px;font-size:18px;font-weight:800;color:#222233;">도전</h4>
        <p style="margin:0;font-size:15px;line-height:1.7;color:#646477;">아이디어를 마음껏 실험하고 실현할 수 있도록 공간과 자원을 지원합니다.</p>
      </div>
    </td>
  </tr>
</table>

<h3 style="font-size:22px;font-weight:800;color:#222233;margin:40px 0 20px;padding-left:14px;border-left:5px solid #6658d9;">이용 안내</h3>
<table style="width:100%;border-collapse:collapse;border:1px solid #e7e7ef;border-radius:12px;overflow:hidden;font-size:15px;">
  <tr>
    <th style="width:150px;text-align:left;background:#f7f7fb;color:#493cae;font-weight:700;padding:16px 20px;border-bottom:1px solid #e7e7ef;">운영 시간</th>
    <td style="padding:16px 20px;border-bottom:1px solid #e7e7ef;color:#646477;">평일 09:00 ~ 21:00 / 토요일 10:00 ~ 18:00</td>
  </tr>
  <tr>
    <th style="text-align:left;background:#f7f7fb;color:#493cae;font-weight:700;padding:16px 20px;border-bottom:1px solid #e7e7ef;">휴관일</th>
    <td style="padding:16px 20px;border-bottom:1px solid #e7e7ef;color:#646477;">매주 일요일 및 법정 공휴일</td>
  </tr>
  <tr>
    <th style="text-align:left;background:#f7f7fb;color:#493cae;font-weight:700;padding:16px 20px;border-bottom:1px solid #e7e7ef;">이용 대상</th>
    <td style="padding:16px 20px;border-bottom:1px solid #e7e7ef;color:#646477;">만 19세 ~ 39세 청년 누구나</td>
  </tr>
  <tr>
    <th style="text-align:left;background:#f7f7fb;color:#493cae;font-weight:700;padding:16px 20px;">이용 요금</th>
    <td style="padding:16px 20px;color:#646477;">무료 (일부 대관 시설 제외)</td>
  </tr>
</table>

<div style="background:#eeeaff;border-radius:14px;padding:22px 26px;margin-top:28px;">
  <p style="margin:0;color:#493cae;font-weight:700;font-size:15px;line-height:1.6;">📍 회원가입 후 누구나 무료로 이용할 수 있습니다. 처음 방문하셨다면 1층 안내데스크에서 이용 안내를 받아보세요.</p>
</div>
' WHERE PAGE_KEY = 'about_intro';


-- ---------------------------------------------------------------------
-- 2. 시설 안내 (about_facility)
-- ---------------------------------------------------------------------
UPDATE SGH_PAGE_CONTENT SET CONTENT_HTML = '
<div style="background:#39c6a6;border-radius:18px;padding:52px 44px;color:#ffffff;margin-bottom:40px;">
  <p style="margin:0 0 10px;font-size:13px;letter-spacing:3px;font-weight:700;color:#dffaf2;">FACILITY</p>
  <h2 style="margin:0 0 16px;font-size:34px;font-weight:800;color:#ffffff;line-height:1.3;">목적에 꼭 맞는<br>다양한 공간</h2>
  <p style="margin:0;font-size:17px;line-height:1.8;color:#e6fbf5;max-width:640px;">집중해서 일할 공간부터 함께 모여 이야기할 공간까지, 청년의 하루를 위한 시설을 갖추고 있습니다.</p>
</div>

<h3 style="font-size:22px;font-weight:800;color:#222233;margin:8px 0 20px;padding-left:14px;border-left:5px solid #39c6a6;">주요 시설</h3>
<table style="width:100%;border-collapse:collapse;table-layout:fixed;">
  <tr>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 22px;height:100%;">
        <div style="font-size:28px;">☕</div>
        <h4 style="margin:12px 0 8px;font-size:17px;font-weight:800;color:#222233;">공유 라운지</h4>
        <p style="margin:0 0 10px;font-size:14px;line-height:1.7;color:#646477;">자유롭게 머물며 작업하고 교류할 수 있는 개방형 휴게 공간.</p>
        <span style="display:inline-block;background:#eeeaff;color:#493cae;font-size:12px;font-weight:700;padding:4px 10px;border-radius:20px;">수용 40석</span>
      </div>
    </td>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 22px;height:100%;">
        <div style="font-size:28px;">📚</div>
        <h4 style="margin:12px 0 8px;font-size:17px;font-weight:800;color:#222233;">집중 스터디룸</h4>
        <p style="margin:0 0 10px;font-size:14px;line-height:1.7;color:#646477;">시험, 자격증, 취업 준비를 위한 1인 집중 좌석 공간.</p>
        <span style="display:inline-block;background:#eeeaff;color:#493cae;font-size:12px;font-weight:700;padding:4px 10px;border-radius:20px;">24석 · 예약제</span>
      </div>
    </td>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 22px;height:100%;">
        <div style="font-size:28px;">🗣️</div>
        <h4 style="margin:12px 0 8px;font-size:17px;font-weight:800;color:#222233;">세미나실</h4>
        <p style="margin:0 0 10px;font-size:14px;line-height:1.7;color:#646477;">스터디 모임, 소규모 강연, 워크숍을 위한 회의 공간.</p>
        <span style="display:inline-block;background:#eeeaff;color:#493cae;font-size:12px;font-weight:700;padding:4px 10px;border-radius:20px;">최대 20인</span>
      </div>
    </td>
  </tr>
  <tr>
    <td style="vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 22px;height:100%;">
        <div style="font-size:28px;">🎬</div>
        <h4 style="margin:12px 0 8px;font-size:17px;font-weight:800;color:#222233;">미디어 스튜디오</h4>
        <p style="margin:0 0 10px;font-size:14px;line-height:1.7;color:#646477;">영상·사진 촬영과 편집, 1인 미디어 제작을 위한 장비 공간.</p>
        <span style="display:inline-block;background:#eeeaff;color:#493cae;font-size:12px;font-weight:700;padding:4px 10px;border-radius:20px;">예약제</span>
      </div>
    </td>
    <td style="vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 22px;height:100%;">
        <div style="font-size:28px;">🛠️</div>
        <h4 style="margin:12px 0 8px;font-size:17px;font-weight:800;color:#222233;">메이커 스페이스</h4>
        <p style="margin:0 0 10px;font-size:14px;line-height:1.7;color:#646477;">3D 프린터, 공구 등 시제품 제작을 지원하는 창작 공간.</p>
        <span style="display:inline-block;background:#eeeaff;color:#493cae;font-size:12px;font-weight:700;padding:4px 10px;border-radius:20px;">교육 후 이용</span>
      </div>
    </td>
    <td style="vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 22px;height:100%;">
        <div style="font-size:28px;">🍱</div>
        <h4 style="margin:12px 0 8px;font-size:17px;font-weight:800;color:#222233;">카페테리아</h4>
        <p style="margin:0 0 10px;font-size:14px;line-height:1.7;color:#646477;">간단한 식사와 음료를 즐기며 쉬어갈 수 있는 휴식 공간.</p>
        <span style="display:inline-block;background:#eeeaff;color:#493cae;font-size:12px;font-weight:700;padding:4px 10px;border-radius:20px;">상시 개방</span>
      </div>
    </td>
  </tr>
</table>

<h3 style="font-size:22px;font-weight:800;color:#222233;margin:40px 0 20px;padding-left:14px;border-left:5px solid #39c6a6;">층별 안내</h3>
<table style="width:100%;border-collapse:collapse;border:1px solid #e7e7ef;border-radius:12px;overflow:hidden;font-size:15px;">
  <tr style="background:#f7f7fb;">
    <th style="width:90px;text-align:center;color:#493cae;font-weight:700;padding:14px 16px;border-bottom:1px solid #e7e7ef;">층</th>
    <th style="text-align:left;color:#493cae;font-weight:700;padding:14px 16px;border-bottom:1px solid #e7e7ef;">주요 시설</th>
  </tr>
  <tr>
    <td style="text-align:center;font-weight:800;color:#6658d9;padding:14px 16px;border-bottom:1px solid #e7e7ef;">1F</td>
    <td style="padding:14px 16px;border-bottom:1px solid #e7e7ef;color:#646477;">안내데스크 · 공유 라운지 · 카페테리아</td>
  </tr>
  <tr>
    <td style="text-align:center;font-weight:800;color:#6658d9;padding:14px 16px;border-bottom:1px solid #e7e7ef;">2F</td>
    <td style="padding:14px 16px;border-bottom:1px solid #e7e7ef;color:#646477;">집중 스터디룸 · 세미나실</td>
  </tr>
  <tr>
    <td style="text-align:center;font-weight:800;color:#6658d9;padding:14px 16px;border-bottom:1px solid #e7e7ef;">3F</td>
    <td style="padding:14px 16px;border-bottom:1px solid #e7e7ef;color:#646477;">미디어 스튜디오 · 메이커 스페이스</td>
  </tr>
  <tr>
    <td style="text-align:center;font-weight:800;color:#6658d9;padding:14px 16px;">4F</td>
    <td style="padding:14px 16px;color:#646477;">운영 사무실 · 청년 상담실</td>
  </tr>
</table>
' WHERE PAGE_KEY = 'about_facility';


-- ---------------------------------------------------------------------
-- 3. 운영 조직 (about_org)
-- ---------------------------------------------------------------------
UPDATE SGH_PAGE_CONTENT SET CONTENT_HTML = '
<div style="background:#4189e8;border-radius:18px;padding:52px 44px;color:#ffffff;margin-bottom:40px;">
  <p style="margin:0 0 10px;font-size:13px;letter-spacing:3px;font-weight:700;color:#d6e6fb;">ORGANIZATION</p>
  <h2 style="margin:0 0 16px;font-size:34px;font-weight:800;color:#ffffff;line-height:1.3;">청년을 위해<br>함께 일하는 사람들</h2>
  <p style="margin:0;font-size:17px;line-height:1.8;color:#e3eefc;max-width:640px;">각 분야의 전담 인력이 청년의 활동과 성장을 가까이에서 지원합니다.</p>
</div>

<h3 style="font-size:22px;font-weight:800;color:#222233;margin:8px 0 24px;padding-left:14px;border-left:5px solid #4189e8;">조직도</h3>
<div style="text-align:center;margin-bottom:8px;">
  <div style="display:inline-block;background:#4189e8;color:#ffffff;font-weight:800;font-size:18px;padding:18px 48px;border-radius:14px;">센터장</div>
  <div style="color:#c2c2d0;font-size:22px;line-height:1;margin:6px 0;">│</div>
</div>
<table style="width:100%;border-collapse:collapse;table-layout:fixed;">
  <tr>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="border:2px solid #eeeaff;border-radius:16px;padding:24px 20px;text-align:center;">
        <h4 style="margin:0 0 6px;font-size:17px;font-weight:800;color:#493cae;">운영지원팀</h4>
        <p style="margin:0;font-size:14px;line-height:1.6;color:#646477;">시설 운영 · 회원 관리 · 예약</p>
      </div>
    </td>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="border:2px solid #eeeaff;border-radius:16px;padding:24px 20px;text-align:center;">
        <h4 style="margin:0 0 6px;font-size:17px;font-weight:800;color:#493cae;">프로그램팀</h4>
        <p style="margin:0;font-size:14px;line-height:1.6;color:#646477;">교육 · 커뮤니티 · 행사 기획</p>
      </div>
    </td>
    <td style="width:33.33%;vertical-align:top;padding:8px;">
      <div style="border:2px solid #eeeaff;border-radius:16px;padding:24px 20px;text-align:center;">
        <h4 style="margin:0 0 6px;font-size:17px;font-weight:800;color:#493cae;">청년지원팀</h4>
        <p style="margin:0;font-size:14px;line-height:1.6;color:#646477;">상담 · 정책 · 일자리 연계</p>
      </div>
    </td>
  </tr>
</table>

<h3 style="font-size:22px;font-weight:800;color:#222233;margin:40px 0 20px;padding-left:14px;border-left:5px solid #4189e8;">팀별 주요 업무</h3>
<table style="width:100%;border-collapse:collapse;border:1px solid #e7e7ef;border-radius:12px;overflow:hidden;font-size:15px;">
  <tr style="background:#f7f7fb;">
    <th style="width:160px;text-align:left;color:#493cae;font-weight:700;padding:14px 18px;border-bottom:1px solid #e7e7ef;">부서</th>
    <th style="text-align:left;color:#493cae;font-weight:700;padding:14px 18px;border-bottom:1px solid #e7e7ef;">담당 업무</th>
  </tr>
  <tr>
    <td style="font-weight:700;color:#222233;padding:14px 18px;border-bottom:1px solid #e7e7ef;">운영지원팀</td>
    <td style="padding:14px 18px;border-bottom:1px solid #e7e7ef;color:#646477;">공간·시설 운영, 회원 가입 및 관리, 시설 예약 접수</td>
  </tr>
  <tr>
    <td style="font-weight:700;color:#222233;padding:14px 18px;border-bottom:1px solid #e7e7ef;">프로그램팀</td>
    <td style="padding:14px 18px;border-bottom:1px solid #e7e7ef;color:#646477;">청년 교육·역량강화 프로그램, 커뮤니티 및 네트워킹 행사 운영</td>
  </tr>
  <tr>
    <td style="font-weight:700;color:#222233;padding:14px 18px;">청년지원팀</td>
    <td style="padding:14px 18px;color:#646477;">청년 상담, 정책 정보 제공, 일자리·진로 연계 지원</td>
  </tr>
</table>

<div style="background:#eeeaff;border-radius:14px;padding:22px 26px;margin-top:28px;">
  <p style="margin:0;color:#493cae;font-weight:700;font-size:15px;line-height:1.7;">📞 운영 관련 문의 : 02-000-0000 &nbsp;|&nbsp; ✉️ youth@sgh.or.kr</p>
</div>
' WHERE PAGE_KEY = 'about_org';


-- ---------------------------------------------------------------------
-- 4. 오시는 길 (about_location)
-- ---------------------------------------------------------------------
UPDATE SGH_PAGE_CONTENT SET CONTENT_HTML = '
<div style="background:#ff6f61;border-radius:18px;padding:52px 44px;color:#ffffff;margin-bottom:40px;">
  <p style="margin:0 0 10px;font-size:13px;letter-spacing:3px;font-weight:700;color:#ffe2de;">LOCATION</p>
  <h2 style="margin:0 0 16px;font-size:34px;font-weight:800;color:#ffffff;line-height:1.3;">찾아오시는 길</h2>
  <p style="margin:0;font-size:17px;line-height:1.8;color:#ffe9e6;max-width:640px;">대중교통으로 편리하게 방문하실 수 있습니다. 아래 안내를 참고해 주세요.</p>
</div>

<table style="width:100%;border-collapse:collapse;border:1px solid #e7e7ef;border-radius:12px;overflow:hidden;font-size:15px;margin-bottom:28px;">
  <tr>
    <th style="width:120px;text-align:left;background:#f7f7fb;color:#c2392c;font-weight:700;padding:16px 20px;border-bottom:1px solid #e7e7ef;">주소</th>
    <td style="padding:16px 20px;border-bottom:1px solid #e7e7ef;color:#222233;font-weight:600;">서울특별시 ○○구 청년로 123, SGH 청년공간 (우 00000)</td>
  </tr>
  <tr>
    <th style="text-align:left;background:#f7f7fb;color:#c2392c;font-weight:700;padding:16px 20px;border-bottom:1px solid #e7e7ef;">전화</th>
    <td style="padding:16px 20px;border-bottom:1px solid #e7e7ef;color:#646477;">02-000-0000</td>
  </tr>
  <tr>
    <th style="text-align:left;background:#f7f7fb;color:#c2392c;font-weight:700;padding:16px 20px;">이메일</th>
    <td style="padding:16px 20px;color:#646477;">youth@sgh.or.kr</td>
  </tr>
</table>

<div style="border:1px dashed #d7d7e2;border-radius:16px;background:#f7f7fb;padding:56px 24px;text-align:center;margin-bottom:36px;">
  <div style="font-size:34px;">🗺️</div>
  <p style="margin:12px 0 4px;font-size:16px;font-weight:700;color:#222233;">지도 영역</p>
  <p style="margin:0;font-size:14px;color:#9999a8;">서울특별시 ○○구 청년로 123</p>
</div>

<h3 style="font-size:22px;font-weight:800;color:#222233;margin:8px 0 20px;padding-left:14px;border-left:5px solid #ff6f61;">대중교통 안내</h3>
<table style="width:100%;border-collapse:collapse;table-layout:fixed;margin-bottom:8px;">
  <tr>
    <td style="width:50%;vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 24px;height:100%;">
        <h4 style="margin:0 0 12px;font-size:17px;font-weight:800;color:#222233;">🚇 지하철</h4>
        <p style="margin:0 0 6px;font-size:15px;line-height:1.7;color:#646477;"><b style="color:#4189e8;">○호선 청년역</b> 2번 출구에서 도보 5분</p>
        <p style="margin:0;font-size:15px;line-height:1.7;color:#646477;"><b style="color:#39c6a6;">○호선 시청년역</b> 1번 출구에서 도보 8분</p>
      </div>
    </td>
    <td style="width:50%;vertical-align:top;padding:8px;">
      <div style="border:1px solid #e7e7ef;border-radius:16px;padding:26px 24px;height:100%;">
        <h4 style="margin:0 0 12px;font-size:17px;font-weight:800;color:#222233;">🚌 버스</h4>
        <p style="margin:0 0 6px;font-size:15px;line-height:1.7;color:#646477;"><b style="color:#4189e8;">간선</b> 100, 101, 102</p>
        <p style="margin:0;font-size:15px;line-height:1.7;color:#646477;"><b style="color:#39c6a6;">지선</b> 1000, 2000 &mdash; 청년공간 정류장 하차</p>
      </div>
    </td>
  </tr>
</table>

<div style="background:#fff4f2;border:1px solid #ffd9d3;border-radius:14px;padding:22px 26px;margin-top:20px;">
  <p style="margin:0;color:#c2392c;font-weight:700;font-size:15px;line-height:1.7;">🚗 자가용 이용 시 건물 지하 주차장을 이용하실 수 있으며, 공간이 협소하니 가급적 대중교통 이용을 권장합니다. (이용 회원 2시간 무료)</p>
</div>
' WHERE PAGE_KEY = 'about_location';
