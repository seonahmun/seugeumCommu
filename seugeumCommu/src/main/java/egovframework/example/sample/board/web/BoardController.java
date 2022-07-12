package egovframework.example.sample.board.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.sample.board.service.BoardService;
import egovframework.example.sample.board.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "boardService")
	private BoardService boardService;

	@RequestMapping(value = "/mainList.do")
	public String list2(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request
		) throws Exception {
		
		boardVO.setGroupId(request.getSession().getAttribute("groupId").toString()); // 로그인 시 세션으로 그룹아이디값 가져오기 
		
		String boardId = "B01"; // 공지사항 
		boardVO.setBoardId(boardId);
		List<?> list = boardService.selectBoardMain(boardVO);
		model.addAttribute("resultList1", list);
		
		String boardId2 = "B02"; // 자유게시판 
		boardVO.setBoardId(boardId2);
		List<?> list2 = boardService.selectBoardMain2(boardVO);
		model.addAttribute("resultList2", list2);
		
		// 사용자그룹에 따라 자유게시판 이름이 다르게 표시
		String freeBoardName="";
		if(request.getSession().getAttribute("groupId").equals("U01")){
			freeBoardName += "교수익명톡톡";
		} else if(request.getSession().getAttribute("groupId").equals("U02")) {
			freeBoardName += "학생익명톡톡";
		}
		model.addAttribute("freeBoardName", freeBoardName);
		
		return "/board/mainList";
		
	}

	@RequestMapping(value = "/noticeList.do")
	public String list(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request)
			throws Exception {
		
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo(); 
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());  
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());  
		paginationInfo.setPageSize(boardVO.getPageSize()); 
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		String boardId = "B01"; // 추후에 SELECT해서 VALUE 공지사항, 자유게시판에 따라 지정
		boardVO.setBoardId(boardId);
		request.getSession().setAttribute("boardId", boardId);

		List<?> list = boardService.selectBoardList(boardVO);

		model.addAttribute("resultList", list);

		int totCnt = boardService.selectBoardListTotCnt(boardVO);
		
		paginationInfo.setTotalRecordCount(totCnt);  
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 사용자그룹에 따라 자유게시판 이름이 다르게 표시
		String freeBoardName="";
		if(request.getSession().getAttribute("groupId").equals("U01")){
			freeBoardName += "교수익명톡톡";
		} else if(request.getSession().getAttribute("groupId").equals("U02")) {
			freeBoardName += "학생익명톡톡";
		}
		model.addAttribute("freeBoardName", freeBoardName);

		return "/board/noticeList";
	}
	
	@RequestMapping(value = "/noticeMgmt.do", method = RequestMethod.GET)
	public String noticeMgmt(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request)
			throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		System.out.println("Today" + strToday);

		System.out.println(boardVO.getIdx());
		boardVO.setIndate(strToday);
		
		String mgmtMode = "";
		if(boardVO.getIdx() != null) {
			boardVO = boardService.selectBoard(boardVO);
			mgmtMode = "수정";
		} else {
			mgmtMode = "등록";
		}
		
		// 사용자그룹에 따라 자유게시판 이름이 다르게 표시
		String freeBoardName="";
		if(request.getSession().getAttribute("groupId").equals("U01")){
			freeBoardName += "교수익명톡톡";
		} else if(request.getSession().getAttribute("groupId").equals("U02")) {
			freeBoardName += "학생익명톡톡";
		}
		
		model.addAttribute("boardVO", boardVO); 
		model.addAttribute("mgmtMode", mgmtMode);
		model.addAttribute("freeBoardName", freeBoardName);
		
		return "/board/noticeMgmt";
	}

	@RequestMapping(value = "/noticeMgmt.do", method = RequestMethod.POST)
	public String noticeMgmt2(@ModelAttribute("boardVO") BoardVO boardVO, @RequestParam("mode") String mode, ModelMap model) throws Exception {

		if ("add".equals(mode)) {
			boardService.insertBoard(boardVO);
		} else if ("modify".equals(mode)) {
			boardService.updateBoard(boardVO);
		} else if ("del".equals(mode)) {
			boardService.deleteBoard(boardVO);
		}

		return "redirect:/noticeList.do";
	}

	@RequestMapping(value = "/noticeView.do")
	public String noticeView(@ModelAttribute("boardVO") BoardVO boardVO, 
			ModelMap model, HttpServletRequest request) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();  
		String strToday = sdf.format(c1.getTime());  
		System.out.println("Today" + strToday);

		boardService.updateBoardCount(boardVO);
		
	    //게시판 구분을 위한 보드보 저장
	    String boardId = "B01";
	    boardVO.setBoardId(boardId);
	    request.getSession().setAttribute("boardId", boardId);
		
		boardVO = boardService.selectBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("strToday", strToday);
		
		List<?> list = boardService.selectReplyList(boardVO);
		// resultlist에 list를 넣음  
		model.addAttribute("resultList", list);
		
		// 사용자그룹에 따라 자유게시판 이름이 다르게 표시
		String freeBoardName="";
		if(request.getSession().getAttribute("groupId").equals("U01")){
			freeBoardName += "교수익명톡톡";
		} else if(request.getSession().getAttribute("groupId").equals("U02")) {
			freeBoardName += "학생익명톡톡";
		}
		model.addAttribute("freeBoardName", freeBoardName);

		
		return "/board/noticeView";
	}

	@RequestMapping(value = "/reply.do", method=RequestMethod.POST)
	public String reply(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
		boardService.insertReply(boardVO);
		return "redirect:/noticeView.do?idx=" + boardVO.getIdx();
	}
	
	// ------------------------ 선아님 ----------------------------
	
	@RequestMapping(value = "/freeBoardList.do")
	public String freeBoardList2(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception {
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));
		
		// pageing setting
		// pageinationInfo에 필수 정보를 넣어 준다.
		PaginationInfo paginationInfo = new PaginationInfo();   
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());  //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());   //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(boardVO.getPageSize());  //페이징 리스트의 사이즈
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex()); //처음 인덱스
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex()); //마지막 인덱스
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		//게시판 구분을 위한 보드보 저장
	    String boardId = "B02";
	    boardVO.setBoardId(boardId); 
	    request.getSession().setAttribute("boardId", boardId);
		
	    //자유게시판 그룹 세션에서 불러오기
  		boardVO.setGroupId(request.getSession().getAttribute("groupId").toString());
  		boardVO.setWriter(request.getSession().getAttribute("id").toString());
		
  		//List import시 java.util 라이브러리 사용
		List<?>list = boardService.selectBoardList2(boardVO);
		model.addAttribute("resultList",list);
		
		int totCnt = boardService.selectBoardListTotCnt(boardVO);
		paginationInfo.setTotalRecordCount(totCnt);  
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 사용자그룹에 따라 자유게시판 이름이 다르게 표시
		String freeBoardName="";
		if(request.getSession().getAttribute("groupId").equals("U01")){
			freeBoardName += "교수익명톡톡";
		} else if(request.getSession().getAttribute("groupId").equals("U02")) {
			freeBoardName += "학생익명톡톡";
		}
		model.addAttribute("freeBoardName", freeBoardName);
  		
		return "/board/freeBoardList";
	}

	@RequestMapping(value = "/freeBoardMgmt.do", method = RequestMethod.GET)
	public String freeBoardMgmt(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model,
        HttpServletRequest request) throws Exception {
		
		//날짜의 특정 문자열 포맷을 얻고 싶을 때 사용하는 클래스
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		//날짜와 시간에 관한 데이터를 손쉽게 처리할 수 있도록 한다.
		Calendar c1 = Calendar.getInstance();
		
	    String strToday = sdf.format(c1.getTime());
	    System.out.println("Today"+strToday);

	    boardVO.setIndate(strToday);
	    boardVO.setWriter(request.getSession().getAttribute("id").toString());
	    boardVO.setGroupId(request.getSession().getAttribute("groupId").toString());
    
		//서버에서 가져오기
		String mgmtMode = "";
	    if(boardVO.getIdx() != null) {
	    	boardVO = boardService.selectBoard(boardVO);
	    	mgmtMode = "수정"; 
	    } else {
	    	mgmtMode = "등록";
	    }
	    
		// 사용자그룹에 따라 자유게시판 이름이 다르게 표시
		String freeBoardName="";
		if(request.getSession().getAttribute("groupId").equals("U01")){
			freeBoardName += "교수익명톡톡";
		} else if(request.getSession().getAttribute("groupId").equals("U02")) {
			freeBoardName += "학생익명톡톡";
		}
		
		//서버에서 가져온 값을 화면에 맵핑
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("mgmtMode", mgmtMode);
		model.addAttribute("freeBoardName", freeBoardName);
	
		return "/board/freeBoardMgmt";
	}
	
	@RequestMapping(value = "/freeBoardMgmt.do", method = RequestMethod.POST)
	public String freeBoardMgmt2(@ModelAttribute("boardVO") BoardVO boardVO,
		@RequestParam("mode")String mode, ModelMap model) throws Exception {
		
		if ("add".equals(mode)) {
			boardService.insertBoard(boardVO);
		} else if ("modify".equals(mode)) {
			boardService.updateBoard(boardVO);
		} else if ("del".equals(mode)) {
			boardService.deleteBoard(boardVO);
		}
			
		return "redirect:/freeBoardList.do";
	}

	@RequestMapping(value = "/freeBoardView.do")
	public String freeBoardView(@ModelAttribute("boardVO") BoardVO boardVO,
        ModelMap model, HttpServletRequest request) throws Exception {
			
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        System.out.println("Today"+strToday);
        model.addAttribute("strToday", strToday);
	 
        boardService.updateBoardCount(boardVO);
	    
	    //게시판 구분을 위한 보드보 저장
	    String boardId = "B02";
	    boardVO.setBoardId(boardId);
	    request.getSession().setAttribute("boardId", boardId);
	    
		boardVO.setGroupId(request.getSession().getAttribute("groupId").toString());
		boardVO.setWriter(request.getSession().getAttribute("id").toString());
		
	    boardVO = boardService.selectBoard(boardVO);
	    model.addAttribute("boardVO", boardVO);
	    	    
	    List<?>list = boardService.selectReplyList(boardVO);
	    model.addAttribute("resultList",list);
	    
		// 사용자그룹에 따라 자유게시판 이름이 다르게 표시
		String freeBoardName="";
		if(request.getSession().getAttribute("groupId").equals("U01")){
			freeBoardName += "교수익명톡톡";
		} else if(request.getSession().getAttribute("groupId").equals("U02")) {
			freeBoardName += "학생익명톡톡";
		}
		model.addAttribute("freeBoardName", freeBoardName);
	    
		return "/board/freeBoardView";
	}
	
	@RequestMapping(value ="/freeBoardReply.do", method = RequestMethod.POST)
	public String freeBoardReply(@ModelAttribute("boardVO")BoardVO boardVO,
		ModelMap model, HttpServletRequest request) throws Exception {
		
		boardVO.setWriter(request.getSession().getAttribute("id").toString());
		
		boardService.insertReply(boardVO);
		
        //redirect 시 idx 초기화되므로 다시 가져오기
        //리다이렉트(Redirect)는 서버는 클라이언트의 요청에 대해 특정 URL로 다시 지시할 수 있다.
        return "redirect:/freeBoardView.do?idx="+ boardVO.getIdx();
	}
	
	
}
