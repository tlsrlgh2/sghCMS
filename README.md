# SGHCMS

eGovFramework 5.0 기반 CMS 프로젝트 (Spring 6.2 / Jakarta EE / Tomcat 11)

URL: https://shingiho.duckdns.org/

---

## 기술 스택

| 구분 | 기술 |
|------|------|
| 프레임워크 | eGovFramework 5.0.0 (Spring 6.2) |
| 보안 | Spring Security 6.5 |
| ORM | MyBatis 3.5 |
| 뷰 | JSP / JSTL |
| Jakarta EE | Jakarta EE 9+ (`jakarta.*` 네임스페이스) |
| DB | MySQL 8.0 |
| 레이아웃 | SiteMesh 3 |
| 어드민 UI | CoreUI Free Bootstrap Admin Template v5.5.0 |
| 빌드 | Maven |

---

## 프로젝트 실행

```bash
# 빌드 (SGHCMS/ 디렉토리에서 실행)
mvn clean install

# 내장 Tomcat 11으로 실행 (포트 8080)
mvn cargo:run

# 테스트 실행 (pom.xml 기본값: skip)
mvn test -DskipTests=false

# 단일 테스트 클래스
mvn test -Dtest=ContentServiceTest -DskipTests=false
```

### DB 초기화

MySQL `egov` 데이터베이스에 아래 순서로 스크립트 실행:

```
script/ddl/mysql/com_DDL_mysql.sql
script/dml/mysql/com_DML_mysql.sql
```

### 주요 설정 파일

- DB 접속 / 인증 모드: `src/main/resources/egovframework/egovProps/globals.properties`
- DB Host: `140.245.65.218:3306` / Database: `egov`

---

## 구현된 sghcms 모듈

| 모듈 | 패키지 | 주요 클래스 |
|------|--------|------------|
| 어드민 대시보드 | `sghcms.admin` | `AdminDashboardController`, `AdminCmsController`, `AdminMenuService` |
| 페이지 콘텐츠 | `sghcms.content` | `AdminPageContentController`, `PageContentService`, `PageContentDAO` |
| 사용자 메뉴 | `sghcms.menu` | `AdminUserMenuController`, `UserMenuController`, `UserMenuService` |
| 게시판 설정 | `sghcms.board` | `BoardConfigService`, `UserBoardController`, `UserBoardService` |
| 사용자(프론트) | `sghcms.user` | `UserLoginController`, `UserJoinController`, `UserMypageController`, `UserFindAccountController` |
| 공통 유틸 | `sghcms.cmm` | `HtmlTagFilterDecoder` |

> `egovframework.com.*`은 수정하지 않는다. 모든 커스텀 코드는 `sghcms` 루트 패키지 아래에 생성한다.

---

## 아키텍처

### 레이어 패턴

```
sghcms.<module>/
  web/            – @Controller (URL 핸들러, 뷰 이름 반환)
  service/        – 서비스 인터페이스 + VO
  service/impl/   – @Service 구현체 + @Repository DAO
```

| 리소스 | 경로 |
|--------|------|
| JSP 뷰 | `src/main/webapp/WEB-INF/jsp/sghcms/<module>/` |
| MyBatis 매퍼 | `src/main/resources/sghcms/mapper/<module>/*_mysql.xml` |
| Spring 설정 | `src/main/resources/sghcms/spring/context-*.xml` |

### 레이아웃 (SiteMesh 3)

`WEB-INF/sitemesh3.xml`이 URL 경로를 데코레이터에 매핑한다.

| 경로 | 데코레이터 |
|------|-----------|
| `/admin/*` 및 eGov 어드민 경로 | `layout/admin/layout.jsp` (CoreUI 사이드바 + 헤더) |
| `/user/*` | `layout/user/layout.jsp` |
| `/uat/uia/*`, `/cmm/error/*`, 로그인·Ajax 경로 | 레이아웃 미적용 (`exclude`) |

### 인터셉터

| 인터셉터 | 대상 경로 | 역할 |
|---------|----------|------|
| `UserMenuInterceptor` | `/`, `/user/*` | DB 기반 GNB 메뉴 트리 주입 |
| `AdminMenuInterceptor` | `/admin/*`, eGov 어드민 경로 | 어드민 메뉴 트리 주입 / 활성 메뉴 세션 유지 |
| `BoardConfigInterceptor` | `/cop/bbs/*` | 게시판 확장 설정(`userWriteAt`, `ownPostOnlyAt`) 주입 |

---

## 주요 기술 결정 사항

### 레이아웃: Tiles → SiteMesh 3

Spring 6 (Jakarta EE) 환경에서 `TilesConfigurer`가 완전히 제거되어 동작하지 않는다. SiteMesh 3는 동일한 레이아웃 분리 기능을 제공하면서 Jakarta EE를 완벽 지원한다.

### 어드민 UI: CoreUI Free v5.5.0

- 무료 오픈소스 (MIT 라이선스), Bootstrap 5 기반 반응형 지원
- 별도 빌드 없이 dist 파일 그대로 사용 (`src/main/webapp/coreui/`)

### DB 패스워드 암호화

`globals.properties`에 DB 패스워드를 평문으로 저장하는 것은 KISA 보안 검증 요건 위반이다. eGovFramework의 `egovframe-rte-fdl-crypto` 라이브러리(ARIA + SHA-256)를 사용하여 암호화한다.

- 암호화 설정: `egovframework/egovProps/conf/egov-crypto-config.properties`
- 기본 알고리즘 키: `algorithmKey = egovframe` **(운영 환경에서는 반드시 변경할 것)**

### MySQL `lower_case_table_names=1`

eGovFramework DDL은 테이블명을 대문자로 생성하나 MyBatis 쿼리는 소문자로 참조한다. Linux MySQL 기본값(`lower_case_table_names=0`)에서는 `Table doesn't exist` 오류가 발생하므로 데이터 디렉토리 초기화 시점에 `lower_case_table_names=1`을 설정해야 한다.

- 설정 위치: `/etc/mysql/mysql.conf.d/mysqld.cnf`
- MySQL 8.0에서는 초기화 이후 이 값을 변경할 수 없음 (데이터 디렉토리 재초기화 필요)
