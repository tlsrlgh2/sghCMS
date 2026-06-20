package sghcms.cmm;

/**
 * eGov 공통 {@code HTMLTagFilter} 가 모든 {@code *.do} 요청 파라미터에 적용하는
 * 문자 치환을 역변환한다.
 *
 * <p>해당 필터는 XSS 방지를 위해 {@code < > " ' ( )} 를 각각
 * {@code &lt; &gt; &quot; &apos; &#40; &#41;} 로 바꾼다(단 {@code &} 는 변환하지 않음,
 * 화이트리스트 {@code <p></p><br />} 제외). CKEditor 로 작성한 리치 HTML 본문은
 * 이 치환 때문에 태그가 그대로 노출되므로, 저장 직전에 원복한 뒤
 * OWASP HTML Sanitizer 로 정제해야 한다(보안 경계는 새니타이저가 담당).
 *
 * <p>주의: 본문(리치 텍스트) 필드에만 사용한다. 일반 입력 필드는 필터 인코딩과
 * 출력 측 {@code <c:out>} 이스케이프를 그대로 유지해야 한다.
 */
public final class HtmlTagFilterDecoder {

    private HtmlTagFilterDecoder() {
    }

    public static String decode(String value) {
        if (value == null || value.isEmpty()) {
            return value;
        }
        return value
                .replace("&lt;", "<")
                .replace("&gt;", ">")
                .replace("&quot;", "\"")
                .replace("&apos;", "'")
                .replace("&#40;", "(")
                .replace("&#41;", ")");
    }
}
