# SGHCMS

CMS 개발 프로젝트 (eGovFramework 5.0.0 기반)

---

## 기술 스택

| 구분 | 기술 |
|------|------|
| 프레임워크 | eGovFramework 5.0.0 (Spring 6.x) |
| Jakarta EE | Jakarta EE 9+ (jakarta.* 네임스페이스) |
| DB | MySQL 8.0 |
| 레이아웃 | SiteMesh 3 |
| 어드민 UI | CoreUI Free Bootstrap Admin Template v5.5.0 |
| 빌드 | Maven |

---

## 주요 기술 결정 사항

### 1. 레이아웃 프레임워크: Tiles → SiteMesh 3 채택

**이유:**
Apache Tiles는 Spring 5.3 이후 Spring Framework 공식 지원이 중단되었으며,
이 프로젝트가 사용하는 **Spring 6 (Jakarta EE)** 환경에서는 `TilesConfigurer`가
완전히 제거되어 동작하지 않는다.

SiteMesh 3은 Tiles와 동일한 레이아웃 분리 기능을 제공하면서 Jakarta EE를 완벽 지원한다.

**레이아웃 구조:**
```
/admin/**  →  어드민 레이아웃 (CoreUI 기반 사이드바 + 헤더)
/user/**   →  사용자 레이아웃 (일반 사용자 화면)
```

---

### 2. 어드민 UI: CoreUI Free Bootstrap Admin Template v5.5.0 채택

**이유:**
- 무료 오픈소스 (MIT 라이선스)
- Bootstrap 5 기반으로 반응형 지원
- 사이드바, 헤더, 카드, 테이블 등 어드민에 필요한 컴포넌트 내장
- 별도 빌드 없이 dist 파일 그대로 사용 가능

**파일 위치:** `src/main/webapp/coreui/`

---

### 3. DB 패스워드 암호화: eGovFramework Crypto 컴포넌트 사용

**이유:**
KISA 보안 검증 요건에 따라 `globals.properties`에 DB 패스워드를 평문으로
저장하는 것이 금지되어 있다. eGovFramework에서 제공하는 `egovframe-rte-fdl-crypto`
라이브러리(ARIA 알고리즘 + SHA-256 키 해시)를 사용하여 암호화한다.

- 암호화 설정: `egovframework/egovProps/conf/egov-crypto-config.properties`
- 알고리즘 키: `algorithmKey = egovframe` (운영 환경에서는 반드시 변경할 것)

---

### 4. MySQL lower_case_table_names=1 설정

**이유:**
eGovFramework DDL 스크립트는 테이블명을 대문자(`COMTNEMPLYRSCRTYESTBS`)로 생성하나,
소스 코드 및 MyBatis 쿼리는 소문자(`comtnemplyrscrtyestbs`)로 참조한다.

Linux MySQL 서버는 기본적으로 테이블명 대소문자를 구분(`lower_case_table_names=0`)하므로
`Table doesn't exist` 오류가 발생한다.

MySQL 8.0에서는 초기화 이후 이 값을 변경할 수 없으므로,
**데이터 디렉토리 재초기화** 시점에 `lower_case_table_names=1`을 설정하였다.

- 설정 위치: `/etc/mysql/mysql.conf.d/mysqld.cnf`
- 설정값: `lower_case_table_names=1`

---

## DB 설정

- Host: `140.245.65.218:3306`
- Database: `egov`
- 설정 파일: `src/main/resources/egovframework/egovProps/globals.properties`

---

## 프로젝트 실행

1. MySQL `egov` DB에 DDL/DML 스크립트 실행
   - `script/ddl/mysql/com_DDL_mysql.sql`
   - `script/dml/mysql/com_DML_mysql.sql`

2. `globals.properties`에서 DB 접속 정보 확인

3. Tomcat 서버에서 실행
