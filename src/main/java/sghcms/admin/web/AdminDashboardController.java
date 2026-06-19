package sghcms.admin.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    @GetMapping("/dashboard.do")
    public String dashboard(ModelMap model) {

        // TODO: 서비스 연동으로 교체
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", 1284);
        stats.put("totalPosts", 347);
        stats.put("todayVisits", 2451);
        stats.put("newComments", 58);
        model.addAttribute("stats", stats);

        // TODO: 서비스 연동으로 교체
        List<Map<String, Object>> recentPosts = new ArrayList<>();
        recentPosts.add(createPost(1, "공지사항 제목 예시 1", "홍길동", "2026-06-19", "공지"));
        recentPosts.add(createPost(2, "자유게시판 글 예시 2", "김철수", "2026-06-18", "자유"));
        recentPosts.add(createPost(3, "FAQ 내용 예시 3", "이영희", "2026-06-17", "FAQ"));
        recentPosts.add(createPost(4, "공지사항 제목 예시 4", "박민수", "2026-06-16", "공지"));
        recentPosts.add(createPost(5, "자유게시판 글 예시 5", "최지원", "2026-06-15", "자유"));
        model.addAttribute("recentPosts", recentPosts);

        // TODO: 서비스 연동으로 교체
        List<Map<String, Object>> recentUsers = new ArrayList<>();
        recentUsers.add(createUser("hong123", "홍길동", "일반", "2026-06-19"));
        recentUsers.add(createUser("kim456", "김철수", "기업", "2026-06-18"));
        recentUsers.add(createUser("lee789", "이영희", "일반", "2026-06-17"));
        recentUsers.add(createUser("park000", "박민수", "업무", "2026-06-16"));
        model.addAttribute("recentUsers", recentUsers);

        return "admin/dashboard";
    }

    private Map<String, Object> createPost(int id, String title, String author, String date, String category) {
        Map<String, Object> post = new HashMap<>();
        post.put("id", id);
        post.put("title", title);
        post.put("author", author);
        post.put("date", date);
        post.put("category", category);
        return post;
    }

    private Map<String, Object> createUser(String userId, String userName, String userSe, String regDate) {
        Map<String, Object> user = new HashMap<>();
        user.put("userId", userId);
        user.put("userName", userName);
        user.put("userSe", userSe);
        user.put("regDate", regDate);
        return user;
    }
}
