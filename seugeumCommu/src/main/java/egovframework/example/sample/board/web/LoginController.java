package egovframework.example.sample.board.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.board.service.BoardVO;
import egovframework.example.sample.board.service.LoginService;

@Controller
public class LoginController {

	@Resource(name = "loginService")
	private LoginService loginService;

	@RequestMapping(value = "/login.do")
	public String login(ModelMap model) throws Exception {
		return "/login/login";
	}

	@RequestMapping(value = "/userLogin.do", method = RequestMethod.POST)
	public String userLogin(@RequestParam("id") String id, @RequestParam("password") String password, ModelMap model,
			HttpServletRequest request) throws Exception {
		System.out.println("id:" + id);
		System.out.println("password:" + password);

		BoardVO boardVO = new BoardVO();
		boardVO.setId(id);
		boardVO.setPassword(password);

		List list = loginService.selectLoginCheck(boardVO);
		List<Map<String, Object>> listMap = list;
		System.out.println(listMap);

		if (list.isEmpty()) {

			model.addAttribute("msg", "사용자 정보가 올바르지 않습니다.");

			return "/login/login"; // 체크 필요

		} else {

			String name = listMap.get(0).get("name").toString();
			String nickname = listMap.get(0).get("nickname").toString();
			String groupId = listMap.get(0).get("groupid").toString();
			System.out.println(name + ", " + groupId);

			request.getSession().setAttribute("id", id);
			request.getSession().setAttribute("name", name);
			request.getSession().setAttribute("nickname", nickname);
			request.getSession().setAttribute("groupId", groupId);

			return "redirect:/mainList.do";
		}

	}

	@RequestMapping(value = "/userLogout.do")
	public String logout(ModelMap model, HttpServletRequest request) throws Exception {
		request.getSession().invalidate();
		return "redirect:/login.do";
	}

	// --------------------- 성구님 -------------------------
	@RequestMapping(value = "/join.do")
	public String join(ModelMap model) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		System.out.println("Today" + strToday);

		BoardVO boardVO = new BoardVO();
		boardVO.setIndate(strToday);
		model.addAttribute("boardVO", boardVO);

		return "/login/join";
	}

	@RequestMapping(value = "/joins.do", method = RequestMethod.POST)
	public String mainJoin(@ModelAttribute("boardVO") BoardVO boardVO, @RequestParam("id") String id,
			@RequestParam("name") String name, @RequestParam("birth") String birth, @RequestParam("nickname") String nickname, ModelMap model,
			HttpServletRequest request) throws Exception {

		List list = loginService.selectInnCheck(boardVO);
		List<Map<String, Object>> listMap = list;
		System.out.println(listMap);
		String namee = listMap.get(0).get("name").toString();
		String births = listMap.get(0).get("birth").toString();

		System.out.println(namee);
		System.out.println(births);
		String jCheck = loginService.selectjCheck(id);
		int nicc = loginService.selectMemberNicCheck(nickname);
		
		
		if (!name.equals(namee)) {
			model.addAttribute("msg", "사용자의 이름이 틀렸습니다.");

			return "/login/join";

		} else if (!birth.equals(births)) {

			model.addAttribute("msg", "사용자의 생년월일이 틀렸습니다.");

			return "/login/join";

		} else if (nicc == 1) {

	         model.addAttribute("msg", "중복된 닉네임입니다.");
	         
	         return "/login/join";
	         
	     } else if (jCheck == null) {
			System.out.println(namee + ", " + births);
			loginService.insertJoin(boardVO);
			model.addAttribute("msg", "가입을 환영 합니다 ^_^");
			return "/login/login";

		} else {
			model.addAttribute("msg", "이미 등록된 회원입니다.");
			return "login/join";
		}

	}
	
	@RequestMapping(value = "/idCheck.do",  method=RequestMethod.POST )
	@ResponseBody
	public String selectMemberIdCheck(String id) throws Exception {
		
		String message = "";
		
		int count = loginService.selectMemberIdCheck(id);
		System.out.println(count);
		if (count == 0) {
			message = "ok";
		}
		
		return message;
	}
	
	@RequestMapping(value = "/jCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public String selectjCheck(String id) throws Exception {
		
		String message = "";
		
		String pwd = loginService.selectjCheck(id);
		System.out.println(pwd);
		
		if ( pwd == null ) {
			message = "ok";
		}
		return message;
	}
	
	@RequestMapping(value = "/nicCheck.do",  method=RequestMethod.POST )
	@ResponseBody
	public String selectMembernicCheck(String nickname) throws Exception {
		
		String message = "";
		
		int count2 = loginService.selectMemberNicCheck(nickname);
		System.out.println(count2);
		if (count2 == 0) {
			message = "ok";
		}
		
		return message;
	}

	// --------------------- 승수님 -------------------------
	@RequestMapping(value = "/findId.do")
	public String findId(ModelMap model) throws Exception {
		return "/login/findId";
	}

	@RequestMapping(value = "/userFindId.do", method = RequestMethod.POST)
	public String userFindId(@RequestParam("name") String name, @RequestParam("birth") String birth, ModelMap model)
			throws Exception {
		System.out.println("name:" + name);
		System.out.println("birth:" + birth);

		BoardVO boardVO = new BoardVO();
		boardVO.setName(name);
		boardVO.setBirth(birth);

		String id = loginService.selectID(boardVO);
	      if(id == null) {
	         model.addAttribute("msg", "사용자정보가 올바르지 않습니다"); 
	      return "/login/findId";   
	      
	      }else {
	         System.out.println("학번"+ id);
	         model.addAttribute("id", id);    
	      }
	      return "/login/findId"; 
	}

	@RequestMapping(value = "/findPw.do")
	public String findPw(ModelMap model) throws Exception {
		return "/login/findPw";
	}

	// 확인필요 -> 비밀번호 이름 학번 조회시 없을 떄!
	@RequestMapping(value = "/userFindPw.do", method = RequestMethod.POST)
	public String userFindPw(@RequestParam("name") String name, @RequestParam("id") String id, ModelMap model)
			throws Exception {
		System.out.println("name:" + name);
		System.out.println("id:" + id);

		BoardVO boardVO = new BoardVO();
		boardVO.setName(name);
		boardVO.setId(id);

		String pw = loginService.selectPW(boardVO);
		
	      if(pw == null) {
	         model.addAttribute("msg", "사용자정보가 올바르지 않습니다"); 
	         
	         return "/login/findPw";   
	      
	      }else {
	         System.out.println("비밀번호" + pw); //이전 비밀번호 확인용
	         
	         model.addAttribute("msg", "비밀번호 수정페이지로 이동합니다"); 
	         model.addAttribute("id", id); 
	         
	         return "/login/changePw";
	      }
	}

	@RequestMapping(value = "/userChangePw.do")
	public String changePw(@RequestParam("password") String password,
			@RequestParam("changePwCheck") String changePwCheck, ModelMap model, HttpServletRequest request)
			throws Exception {

		String id = request.getParameter("id");
		System.out.println(id);

		String pw = request.getParameter("password");
		System.out.println(pw);

		String checkPw = request.getParameter("changePwCheck");
		System.out.println(checkPw);

		BoardVO boardVO = new BoardVO();
		boardVO.setId(id);
		boardVO.setPassword(checkPw);
		loginService.updatePw(boardVO);

		return "/login/login";
	}

}