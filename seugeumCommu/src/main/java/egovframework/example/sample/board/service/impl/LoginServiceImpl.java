/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.board.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.sample.board.service.BoardVO;
import egovframework.example.sample.board.service.LoginService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : EgovSampleServiceImpl.java
 * @Description : Sample Business Implement Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Service("loginService")
public class LoginServiceImpl extends EgovAbstractServiceImpl implements LoginService {

	private static final Logger LOGGER = LoggerFactory.getLogger(LoginServiceImpl.class);

	// TODO mybatis 사용
    @Resource(name="loginMapper")
	private LoginMapper loginDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	/**
	 * 글을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SampleVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	
	public List selectLoginCheck(BoardVO searchVO) {
		return loginDAO.selectLoginCheck(searchVO);
	}
	
	// -------------------- 성구님 -------------------- 
	
	//select로 id, name, birth 확인하기
	@Override
	public String selectCjoin(BoardVO searchVO) {
		// TODO Auto-generated method stub
		return loginDAO.selectCjoin(searchVO);
	}
	
	//회원가입시버튼 눌를시 회원정보 확인 후 맞으면 인설트하기
	@Override
	public void insertJoin(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		loginDAO.insertJoin(vo);
	}
	
	@Override
	public int selectMemberIdCheck(String id) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.selectMemberIdCheck(id);
	}
	
	@Override
	public int selectMemberNicCheck(String nickname) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.selectMemberNicCheck(nickname);
	}
	
	@Override
	public List selectInnCheck(BoardVO searchVO) {
		return loginDAO.selectInnCheck(searchVO);
	}
	
	@Override
	public String selectjCheck(String id) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.selectjCheck(id);
	}
	
	// -------------------- 승수님 -------------------- 
	/**
	 * 학번을 조회한다.
	 * @param vo - 조회할 정보가 담긴 BoardVO
	 * @return 조회한 학번
	 * @exception Exception
	 */
	public String selectID(BoardVO searchVO) {
		return loginDAO.selectID(searchVO);
	}
	
	/**
	 * 비밀번호 조회한다.
	 * @param vo - 조회할 정보가 담긴 BoardVO
	 * @return 조회한 학번
	 * @exception Exception
	 */
	public String selectPW(BoardVO searchVO) {
		return loginDAO.selectPW(searchVO);
	}
	
	/**
	 * 비밀번호 수정한다.
	 * @param vo - 수정할 정보가 담긴 SampleVO
	 * @return void형
	 * @exception Exception
	 */
	public void updatePw(BoardVO vo) throws Exception {
		loginDAO.updatePw(vo);
	}

}
