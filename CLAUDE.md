# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Run

```bash
# Build WAR (from SGHCMS/ directory)
mvn clean install

# Run with embedded Tomcat 11 on port 8080
mvn cargo:run

# Run tests (skipped by default in pom.xml)
mvn test -DskipTests=false
```

## Architecture

This is a **Korean eGovFramework (전자정부프레임워크) 5.0 CMS** built on Spring 6.2, Spring Security 6.5, MyBatis 3.5, and JSP/JSTL, packaged as a WAR for Tomcat 11.

### Layered Package Pattern

Every functional module under `egovframework.com` follows this strict 4-layer pattern:

```
egovframework.com.<module>.<submodule>/
  web/       – @Controller classes (URL handlers, return view names)
  service/   – Service interfaces (EgovXxxService) + VO/domain objects
  service/impl/ – @Service implementations (EgovXxxServiceImpl) + @Repository DAO classes
```

Views live at `src/main/webapp/WEB-INF/jsp/egovframework/com/.../*.jsp` mirroring the Java package path.

SQL mappers live at `src/main/resources/egovframework/mapper/com/.../*_${Globals.DbType}.xml` — one file per supported DB dialect (mysql, oracle, maria, postgres, cubrid, tibero, altibase, goldilocks).

### Key Modules

| Package segment | Purpose |
|---|---|
| `cmm` | Common base classes (`EgovComAbstractController`, `EgovComAbstractDAO`), filters (XSS/HTMLTag), exception handling, file upload |
| `uat` | Authentication: login (`uat.uia`), login policy (`uat.uap`), SSO (`uat.sso`) |
| `sym` | System management: menus, codes, web/system logs |
| `sec` | Security: role management, authority groups, role-resource mapping |
| `cop` | Community/bulletin boards, templates, site management |
| `uss` | User services: member management, polls, notifications, web editor |
| `ssi` | System integration: inter-system connection messages |
| `sts` | Statistics: BBS, connection, screen, user, report stats |
| `utl` | Utilities: system monitoring (DB/HTTP/file/network/process), PDF conversion, XML tools |

### Spring Configuration Files

- **Root context**: `src/main/resources/egovframework/spring/com/context-*.xml` — all beans except Controllers
  - `context-datasource.xml` — DB connection pool using Spring profiles matching `Globals.DbType`
  - `context-mapper.xml` — MyBatis `SqlSessionFactoryBean`, loads `*_${Globals.DbType}.xml` mappers
  - `context-common.xml` — component scan (Services/Repositories), i18n, multipart resolver
  - `context-transaction.xml` — transaction manager
  - `spring/com/idgn/context-idgn-*.xml` — ID sequence generators per entity
- **Web/MVC context**: `src/main/webapp/WEB-INF/config/egovframework/springmvc/egov-com-servlet.xml` — component scan (Controllers only), view resolvers, interceptors
- **Bootstrap**: `EgovWebApplicationInitializer` (implements `WebApplicationInitializer`) replaces web.xml; registers all servlet filters, the DispatcherServlet, and the root context

### Configuration

`src/main/resources/egovframework/egovProps/globals.properties` is the central config file:

- `Globals.DbType` — selects active DB dialect (`mysql`, `oracle`, `maria`, `postgres`, etc.). Must match a Spring profile in `context-datasource.xml` and a SQL mapper suffix.
- `Globals.Auth` — authentication mode: `dummy` (no auth), `session` (session-based), `security` (Spring Security).
- `Globals.fileStorePath` — file upload root directory.
- `Globals.fileUpload.*` — upload size limits (default 100 MB).
- `Globals.login.Lock` / `Globals.login.LockCount` — login lockout settings.

### Database Access Pattern

All DAOs extend `EgovComAbstractDAO` (which wraps `SqlSessionTemplate`). SQL is never inline — it always references a statement ID in the corresponding `*_mysql.xml` (or other dialect) mapper file. When adding a new query, create/update the mapper XML for every supported dialect.

### Security

Spring Security filter chain is wired through `EgovLoginConfig` and activated only when `Globals.Auth=security`. Login/logout are bridged to Spring Security via `EgovSpringSecurityLoginFilter` / `EgovSpringSecurityLogoutFilter` before `springSecurityFilterChain`. Encrypted DB passwords use Jasypt; the resolver bean is `egovPasswordResolver`.

### ID Generation

Entity IDs use eGovFramework's UUIDIdGnrService or TableIdGnrService, configured per-entity in `spring/com/idgn/context-idgn-*.xml`. Never manually construct entity IDs — call the injected ID generator service.

## Custom Development Convention

eGovFramework 기본 패키지(`egovframework.com.*`)는 수정하지 않는다. 모든 커스텀 코드는 `sghcms` 루트 패키지 아래에 생성한다.

### 패키지 구조

```
sghcms.<module>.<submodule>/
  web/          – @Controller
  service/      – 서비스 인터페이스 + VO
  service/impl/ – @Service 구현체 + @Repository DAO
```

### 리소스 경로

| 리소스 | 경로 |
|---|---|
| JSP 뷰 | `src/main/webapp/WEB-INF/jsp/sghcms/<module>/` |
| MyBatis 매퍼 | `src/main/resources/sghcms/mapper/<module>/*_mysql.xml` (사용 DB 방언만 작성 가능) |
| Spring 설정 | `src/main/resources/sghcms/spring/context-*.xml` |

### 네이밍

eGovFramework의 `Egov` 접두사를 사용하지 않는다. 클래스명은 기능을 직접 표현한다 (예: `ContentController`, `ContentService`, `ContentServiceImpl`, `ContentDAO`, `ContentVO`).
