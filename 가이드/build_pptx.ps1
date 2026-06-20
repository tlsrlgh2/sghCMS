# 사용자 메뉴관리 사용 가이드 PPTX 생성기 (외부 라이브러리 없이 OOXML 직접 생성)
# 실행: pwsh -File build_pptx.ps1
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$guideDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pptxPath = Join-Path $guideDir '사용자메뉴관리_사용가이드.pptx'
$utf8 = New-Object System.Text.UTF8Encoding($false)

function XmlEsc([string]$s) {
    if ($null -eq $s) { return '' }
    return $s.Replace('&','&amp;').Replace('<','&lt;').Replace('>','&gt;').Replace('"','&quot;')
}

# ----------------------- 슬라이드 콘텐츠 -----------------------
$slides = @(
  @{ Title='사용자 메뉴관리 사용 가이드'; Bullets=@(
     @{T='SGH 청년공간 CMS'; L=0},
     @{T='사용자(프론트) 페이지 메뉴를 관리자 화면에서 직접 관리'; L=0},
     @{T='하드코딩 메뉴 → DB 기반 메뉴 관리로 전환'; L=0}) },
  @{ Title='1. 개요'; Bullets=@(
     @{T='기존: 상단 메뉴(GNB)가 JSP에 하드코딩되어 수정 시 재배포 필요'; L=0},
     @{T='변경: 관리자 화면에서 메뉴 추가·수정·삭제'; L=0},
     @{T='각 메뉴를 콘텐츠 페이지 또는 게시판과 연결'; L=0},
     @{T='메뉴 먼저 생성 후 콘텐츠/게시판은 나중에 연결 가능'; L=1},
     @{T='등록 메뉴는 사용자 페이지에 자동 반영(미등록 시 기존 메뉴 유지)'; L=0}) },
  @{ Title='2. 전체 구조'; Bullets=@(
     @{T='관리자: 사용자 메뉴관리 화면에서 등록/수정/삭제'; L=0},
     @{T='저장소: SGH_USER_MENU 전용 테이블'; L=0},
     @{T='MENU_TYPE = FOLDER / CONTENT / BOARD'; L=1},
     @{T='URL_PATH = /user/page/{경로}.do (의미있는 URL)'; L=1},
     @{T='LINKED_KEY = 콘텐츠키 또는 게시판ID'; L=1},
     @{T='사용자: 상단 메뉴 자동 구성 → 유형에 따라 콘텐츠 렌더 또는 게시판 이동'; L=0}) },
  @{ Title='3. 사전 준비 (최초 1회)'; Bullets=@(
     @{T='테이블 생성: script/ddl/mysql/sghcms_user_menu_DDL_mysql.sql'; L=0},
     @{T='관리자 메뉴 등록: script/dml/mysql/sghcms_user_menu_DML_mysql.sql'; L=0},
     @{T='애플리케이션 재기동'; L=0},
     @{T='좌측 메뉴 콘텐츠/게시판 ▸ 사용자 메뉴관리 노출 확인'; L=0}) },
  @{ Title='4. 관리자 화면 진입'; Bullets=@(
     @{T='관리자 로그인 → 콘텐츠/게시판 ▸ 사용자 메뉴관리'; L=0},
     @{T='직접 URL: /admin/content/userMenu/list.do'; L=0},
     @{T='좌측 = 등록된 메뉴 목록 / 우측 = 등록·수정 폼'; L=0}) },
  @{ Title='5. 메뉴 추가하기'; Bullets=@(
     @{T='메뉴 이름: 사용자에게 보일 이름 (예: 청년정책)'; L=0},
     @{T='메뉴 유형: 폴더 / 콘텐츠 페이지 / 게시판'; L=0},
     @{T='상위 메뉴: 최상위 또는 특정 폴더 하위'; L=0},
     @{T='URL 경로: 콘텐츠·게시판은 필수 (영소문자·숫자·하이픈)'; L=0},
     @{T='정렬 순서 / 노출 여부 설정 후 저장'; L=0},
     @{T='폴더 유형은 URL·연결 입력이 숨겨짐(그룹용)'; L=1}) },
  @{ Title='6. 콘텐츠 페이지 작성'; Bullets=@(
     @{T='유형 = 콘텐츠 페이지 선택 후 저장 (콘텐츠가 메뉴에 자동 연결)'; L=0},
     @{T='목록에서 [콘텐츠 편집] 버튼 클릭'; L=0},
     @{T='CKEditor로 본문 작성·수정 후 저장'; L=0},
     @{T='페이지 키를 직접 입력할 필요 없음(menu_{id} 자동 부여)'; L=1},
     @{T='메뉴 삭제 시 연결된 콘텐츠도 함께 삭제됨'; L=0}) },
  @{ Title='7. 게시판 연결'; Bullets=@(
     @{T='유형 = 게시판 선택'; L=0},
     @{T='연결 게시판 드롭다운에서 선택(게시판 관리에서 미리 생성)'; L=0},
     @{T='사용자가 클릭 시 해당 게시판 목록으로 이동'; L=0}) },
  @{ Title='8. 사용자 화면 확인'; Bullets=@(
     @{T='등록·노출 메뉴는 상단 메뉴에 자동 표시'; L=0},
     @{T='접근 URL: /user/page/{URL경로}.do (예: /user/page/policy.do)'; L=0},
     @{T='폴더 메뉴는 드롭다운, 하위 메뉴는 링크로 표시'; L=0}) },
  @{ Title='9. 보안 및 주의사항'; Bullets=@(
     @{T='URL 경로: 영소문자·숫자·하이픈만 허용(경로 변조·스크립트 차단)'; L=0},
     @{T='게시판 ID: 영문·숫자·언더스코어만 허용 후 인코딩(리다이렉트 인젝션 차단)'; L=0},
     @{T='콘텐츠 HTML: 저장 시 OWASP 새니타이저로 정제'; L=0},
     @{T='URL 중복 불가, 자기 자신·순환 상위 지정 차단'; L=0},
     @{T='하위 메뉴 있는 폴더는 삭제 불가(하위 정리 후 삭제)'; L=0},
     @{T='모든 DB 접근은 MyBatis 파라미터 바인딩으로 SQL 인젝션 방지'; L=0}) },
  @{ Title='10. 자주 묻는 질문'; Bullets=@(
     @{T='Q. 메뉴가 사용자 화면에 안 보여요'; L=0},
     @{T='A. 노출 여부/연결/URL 경로 설정 확인. 폴더는 하위 메뉴 필요'; L=1},
     @{T='Q. 기존 하드코딩 메뉴는?'; L=0},
     @{T='A. 등록 메뉴가 없으면 정적 메뉴로 폴백, 등록 시 DB 메뉴 우선'; L=1},
     @{T='Q. URL을 바꾸면 기존 링크는?'; L=0},
     @{T='A. 이전 경로 접근은 메인으로 리다이렉트됨'; L=1}) }
)

# ----------------------- 파트 빌더 -----------------------
$work = Join-Path ([System.IO.Path]::GetTempPath()) ("pptx_" + [guid]::NewGuid().ToString("N"))
$null = New-Item -ItemType Directory -Path $work
foreach ($d in @('_rels','ppt','ppt\_rels','ppt\slides','ppt\slides\_rels','ppt\slideLayouts','ppt\slideLayouts\_rels','ppt\slideMasters','ppt\slideMasters\_rels','ppt\theme')) {
    $null = New-Item -ItemType Directory -Path (Join-Path $work $d) -Force
}
function WritePart($rel, $content) {
    $p = Join-Path $work $rel
    [System.IO.File]::WriteAllText($p, $content, $utf8)
}

# 슬라이드 본문 문단 생성
function BodyParas($bullets) {
    $sb = New-Object System.Text.StringBuilder
    foreach ($b in $bullets) {
        $lvl = [int]$b.L
        $txt = XmlEsc([string]$b.T)
        [void]$sb.Append("<a:p><a:pPr lvl=""$lvl""/><a:r><a:rPr lang=""ko-KR"" dirty=""0""/><a:t>$txt</a:t></a:r></a:p>")
    }
    return $sb.ToString()
}

$slideTpl = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"><p:cSld><p:spTree><p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr><p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr><p:sp><p:nvSpPr><p:cNvPr id="2" name="Title 1"/><p:cNvSpPr><a:spLocks noGrp="1"/></p:cNvSpPr><p:nvPr><p:ph type="title"/></p:nvPr></p:nvSpPr><p:spPr><a:xfrm><a:off x="838200" y="365125"/><a:ext cx="10515600" cy="1325563"/></a:xfrm></p:spPr><p:txBody><a:bodyPr/><a:lstStyle/><a:p><a:r><a:rPr lang="ko-KR" dirty="0"/><a:t>##TITLE##</a:t></a:r></a:p></p:txBody></p:sp><p:sp><p:nvSpPr><p:cNvPr id="3" name="Content 2"/><p:cNvSpPr><a:spLocks noGrp="1"/></p:cNvSpPr><p:nvPr><p:ph idx="1"/></p:nvPr></p:nvSpPr><p:spPr><a:xfrm><a:off x="838200" y="1825625"/><a:ext cx="10515600" cy="4351338"/></a:xfrm></p:spPr><p:txBody><a:bodyPr/><a:lstStyle/>##BODY##</p:txBody></p:sp></p:spTree></p:cSld></p:sld>
'@

$slideRelTpl = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/></Relationships>
'@

for ($i = 0; $i -lt $slides.Count; $i++) {
    $n = $i + 1
    $title = XmlEsc([string]$slides[$i].Title)
    $body = BodyParas $slides[$i].Bullets
    $xml = $slideTpl.Replace('##TITLE##', $title).Replace('##BODY##', $body)
    WritePart "ppt\slides\slide$n.xml" $xml
    WritePart "ppt\slides\_rels\slide$n.xml.rels" $slideRelTpl
}

# presentation.xml
$sldIds = New-Object System.Text.StringBuilder
$presRels = New-Object System.Text.StringBuilder
[void]$presRels.Append('<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="slideMasters/slideMaster1.xml"/>')
for ($i = 0; $i -lt $slides.Count; $i++) {
    $n = $i + 1
    $rId = "rId" + ($n + 1)
    $sldId = 255 + $n
    [void]$sldIds.Append("<p:sldId id=""$sldId"" r:id=""$rId""/>")
    [void]$presRels.Append("<Relationship Id=""$rId"" Type=""http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide"" Target=""slides/slide$n.xml""/>")
}
$themeRId = "rId" + ($slides.Count + 2)
[void]$presRels.Append("<Relationship Id=""$themeRId"" Type=""http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"" Target=""theme/theme1.xml""/>")

$presentationXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:presentation xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"><p:sldMasterIdLst><p:sldMasterId id="2147483648" r:id="rId1"/></p:sldMasterIdLst><p:sldIdLst>$($sldIds.ToString())</p:sldIdLst><p:sldSz cx="12192000" cy="6858000"/><p:notesSz cx="6858000" cy="9144000"/></p:presentation>
"@
WritePart "ppt\presentation.xml" $presentationXml

$presRelsXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">$($presRels.ToString())</Relationships>
"@
WritePart "ppt\_rels\presentation.xml.rels" $presRelsXml

# 최상위 rels
WritePart "_rels\.rels" @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="ppt/presentation.xml"/></Relationships>
'@

# slideMaster
WritePart "ppt\slideMasters\slideMaster1.xml" @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:sldMaster xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"><p:cSld><p:bg><p:bgRef idx="1001"><a:schemeClr val="bg1"/></p:bgRef></p:bg><p:spTree><p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr><p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr><p:sp><p:nvSpPr><p:cNvPr id="2" name="Title Placeholder 1"/><p:cNvSpPr><a:spLocks noGrp="1"/></p:cNvSpPr><p:nvPr><p:ph type="title"/></p:nvPr></p:nvSpPr><p:spPr><a:xfrm><a:off x="838200" y="365125"/><a:ext cx="10515600" cy="1325563"/></a:xfrm></p:spPr><p:txBody><a:bodyPr/><a:lstStyle/><a:p><a:r><a:rPr lang="ko-KR"/><a:t>제목</a:t></a:r></a:p></p:txBody></p:sp><p:sp><p:nvSpPr><p:cNvPr id="3" name="Text Placeholder 2"/><p:cNvSpPr><a:spLocks noGrp="1"/></p:cNvSpPr><p:nvPr><p:ph type="body" idx="1"/></p:nvPr></p:nvSpPr><p:spPr><a:xfrm><a:off x="838200" y="1825625"/><a:ext cx="10515600" cy="4351338"/></a:xfrm></p:spPr><p:txBody><a:bodyPr/><a:lstStyle/><a:p><a:r><a:rPr lang="ko-KR"/><a:t>내용</a:t></a:r></a:p></p:txBody></p:sp></p:spTree></p:cSld><p:clrMap bg1="lt1" tx1="dk1" bg2="lt2" tx2="dk2" accent1="accent1" accent2="accent2" accent3="accent3" accent4="accent4" accent5="accent5" accent6="accent6" hlink="hlink" folHlink="folHlink"/><p:sldLayoutIdLst><p:sldLayoutId id="2147483649" r:id="rId1"/></p:sldLayoutIdLst><p:txStyles><p:titleStyle><a:lvl1pPr algn="l" defTabSz="914400"><a:defRPr sz="4000" kern="1200"><a:solidFill><a:schemeClr val="tx1"/></a:solidFill><a:latin typeface="+mj-lt"/></a:defRPr></a:lvl1pPr></p:titleStyle><p:bodyStyle><a:lvl1pPr marL="342900" indent="-342900" algn="l" defTabSz="914400"><a:buFont typeface="Arial"/><a:buChar char="&#8226;"/><a:defRPr sz="2400" kern="1200"><a:solidFill><a:schemeClr val="tx1"/></a:solidFill><a:latin typeface="+mn-lt"/></a:defRPr></a:lvl1pPr><a:lvl2pPr marL="742950" indent="-285750" algn="l" defTabSz="914400"><a:buFont typeface="Arial"/><a:buChar char="&#8211;"/><a:defRPr sz="2000" kern="1200"><a:solidFill><a:schemeClr val="tx1"/></a:solidFill><a:latin typeface="+mn-lt"/></a:defRPr></a:lvl2pPr></p:bodyStyle><p:otherStyle><a:lvl1pPr><a:defRPr sz="1800"/></a:lvl1pPr></p:otherStyle></p:txStyles></p:sldMaster>
'@

WritePart "ppt\slideMasters\_rels\slideMaster1.xml.rels" @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="../theme/theme1.xml"/></Relationships>
'@

# slideLayout
WritePart "ppt\slideLayouts\slideLayout1.xml" @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:sldLayout xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" type="obj" preserve="1"><p:cSld name="Title and Content"><p:spTree><p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr><p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr><p:sp><p:nvSpPr><p:cNvPr id="2" name="Title 1"/><p:cNvSpPr><a:spLocks noGrp="1"/></p:cNvSpPr><p:nvPr><p:ph type="title"/></p:nvPr></p:nvSpPr><p:spPr/><p:txBody><a:bodyPr/><a:lstStyle/><a:p><a:endParaRPr lang="ko-KR"/></a:p></p:txBody></p:sp><p:sp><p:nvSpPr><p:cNvPr id="3" name="Content Placeholder 2"/><p:cNvSpPr><a:spLocks noGrp="1"/></p:cNvSpPr><p:nvPr><p:ph type="body" idx="1"/></p:nvPr></p:nvSpPr><p:spPr/><p:txBody><a:bodyPr/><a:lstStyle/><a:p><a:endParaRPr lang="ko-KR"/></a:p></p:txBody></p:sp></p:spTree></p:cSld><p:clrMapOvr><a:masterClrMapping/></p:clrMapOvr></p:sldLayout>
'@

WritePart "ppt\slideLayouts\_rels\slideLayout1.xml.rels" @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="../slideMasters/slideMaster1.xml"/></Relationships>
'@

# theme (표준 Office 테마)
WritePart "ppt\theme\theme1.xml" @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office Theme"><a:themeElements><a:clrScheme name="Office"><a:dk1><a:sysClr val="windowText" lastClr="000000"/></a:dk1><a:lt1><a:sysClr val="window" lastClr="FFFFFF"/></a:lt1><a:dk2><a:srgbClr val="44546A"/></a:dk2><a:lt2><a:srgbClr val="E7E6E6"/></a:lt2><a:accent1><a:srgbClr val="4472C4"/></a:accent1><a:accent2><a:srgbClr val="ED7D31"/></a:accent2><a:accent3><a:srgbClr val="A5A5A5"/></a:accent3><a:accent4><a:srgbClr val="FFC000"/></a:accent4><a:accent5><a:srgbClr val="5B9BD5"/></a:accent5><a:accent6><a:srgbClr val="70AD47"/></a:accent6><a:hlink><a:srgbClr val="0563C1"/></a:hlink><a:folHlink><a:srgbClr val="954F72"/></a:folHlink></a:clrScheme><a:fontScheme name="Office"><a:majorFont><a:latin typeface="Calibri Light"/><a:ea typeface=""/><a:cs typeface=""/></a:majorFont><a:minorFont><a:latin typeface="Calibri"/><a:ea typeface=""/><a:cs typeface=""/></a:minorFont></a:fontScheme><a:fmtScheme name="Office"><a:fillStyleLst><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:gradFill rotWithShape="1"><a:gsLst><a:gs pos="0"><a:schemeClr val="phClr"><a:lumMod val="110000"/><a:satMod val="105000"/><a:tint val="67000"/></a:schemeClr></a:gs><a:gs pos="50000"><a:schemeClr val="phClr"><a:lumMod val="105000"/><a:satMod val="103000"/><a:tint val="73000"/></a:schemeClr></a:gs><a:gs pos="100000"><a:schemeClr val="phClr"><a:lumMod val="105000"/><a:satMod val="109000"/><a:tint val="81000"/></a:schemeClr></a:gs></a:gsLst><a:lin ang="5400000" scaled="0"/></a:gradFill><a:gradFill rotWithShape="1"><a:gsLst><a:gs pos="0"><a:schemeClr val="phClr"><a:satMod val="103000"/><a:lumMod val="102000"/><a:tint val="94000"/></a:schemeClr></a:gs><a:gs pos="50000"><a:schemeClr val="phClr"><a:satMod val="110000"/><a:lumMod val="100000"/><a:shade val="100000"/></a:schemeClr></a:gs><a:gs pos="100000"><a:schemeClr val="phClr"><a:lumMod val="99000"/><a:satMod val="120000"/><a:shade val="78000"/></a:schemeClr></a:gs></a:gsLst><a:lin ang="5400000" scaled="0"/></a:gradFill></a:fillStyleLst><a:lnStyleLst><a:ln w="6350" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/><a:miter lim="800000"/></a:ln><a:ln w="12700" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/><a:miter lim="800000"/></a:ln><a:ln w="19050" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/><a:miter lim="800000"/></a:ln></a:lnStyleLst><a:effectStyleLst><a:effectStyle><a:effectLst/></a:effectStyle><a:effectStyle><a:effectLst/></a:effectStyle><a:effectStyle><a:effectLst><a:outerShdw blurRad="57150" dist="19050" dir="5400000" rotWithShape="0"><a:srgbClr val="000000"><a:alpha val="63000"/></a:srgbClr></a:outerShdw></a:effectLst></a:effectStyle></a:effectStyleLst><a:bgFillStyleLst><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"><a:tint val="95000"/><a:satMod val="170000"/></a:schemeClr></a:solidFill><a:gradFill rotWithShape="1"><a:gsLst><a:gs pos="0"><a:schemeClr val="phClr"><a:tint val="93000"/><a:satMod val="150000"/><a:shade val="98000"/><a:lumMod val="102000"/></a:schemeClr></a:gs><a:gs pos="50000"><a:schemeClr val="phClr"><a:tint val="98000"/><a:satMod val="130000"/><a:shade val="90000"/><a:lumMod val="103000"/></a:schemeClr></a:gs><a:gs pos="100000"><a:schemeClr val="phClr"><a:shade val="63000"/><a:satMod val="120000"/></a:schemeClr></a:gs></a:gsLst><a:lin ang="5400000" scaled="0"/></a:gradFill></a:bgFillStyleLst></a:fmtScheme></a:themeElements><a:objectDefaults/><a:extraClrSchemeLst/></a:theme>
'@

# [Content_Types].xml
$ctOverrides = New-Object System.Text.StringBuilder
[void]$ctOverrides.Append('<Override PartName="/ppt/presentation.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"/>')
[void]$ctOverrides.Append('<Override PartName="/ppt/slideMasters/slideMaster1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"/>')
[void]$ctOverrides.Append('<Override PartName="/ppt/slideLayouts/slideLayout1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"/>')
[void]$ctOverrides.Append('<Override PartName="/ppt/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>')
for ($i = 0; $i -lt $slides.Count; $i++) {
    $n = $i + 1
    [void]$ctOverrides.Append("<Override PartName=""/ppt/slides/slide$n.xml"" ContentType=""application/vnd.openxmlformats-officedocument.presentationml.slide+xml""/>")
}
$contentTypes = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/>$($ctOverrides.ToString())</Types>
"@
WritePart "[Content_Types].xml" $contentTypes

# ----------------------- 패키징 -----------------------
# 주의: .NET Framework(PS5.1)의 ZipFile.CreateFromDirectory 는 OPC 규격에 어긋나는
# 백슬래시(\) 구분자를 사용한다. PowerPoint 호환을 위해 ZipArchive 로 엔트리명을
# forward slash(/) 로 직접 지정해 패키징한다. ([Content_Types].xml 을 먼저 추가)
if (Test-Path $pptxPath) { Remove-Item $pptxPath -Force }
$fs = [System.IO.File]::Open($pptxPath, [System.IO.FileMode]::Create)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    $files = Get-ChildItem -Path $work -Recurse -File
    # [Content_Types].xml 이 가장 먼저 오도록 정렬
    $ordered = @($files | Where-Object { $_.Name -eq '[Content_Types].xml' }) +
               @($files | Where-Object { $_.Name -ne '[Content_Types].xml' })
    foreach ($f in $ordered) {
        $entryName = $f.FullName.Substring($work.Length + 1).Replace('\','/')
        $entry = $zip.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
        $es = $entry.Open()
        $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
        $es.Write($bytes, 0, $bytes.Length)
        $es.Dispose()
    }
} finally {
    $zip.Dispose()
    $fs.Dispose()
}
Remove-Item $work -Recurse -Force
Write-Output "생성 완료: $pptxPath ($($slides.Count) 슬라이드)"
