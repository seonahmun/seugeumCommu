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
package egovframework.example.sample.board.service;

import java.util.List;

/**
 * @Class Name : EgovSampleService.java
 * @Description : EgovSampleService Class
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
public interface LoginService {

	List selectLoginCheck(BoardVO vo);
	
	// -------------------- 성구님 -------------------------
	
	//select로 id, name, birth 확인하기
	String selectCjoin(BoardVO vo);
	
	//회원가입시버튼 눌를시 회원정보 확인 후 맞으면 인설트하기
	void insertJoin(BoardVO vo) throws Exception;
	
	public int selectMemberIdCheck(String id) throws Exception;
	
	public int selectMemberNicCheck(String nickname) throws Exception;
	
	List selectInnCheck(BoardVO vo);
	
	public String selectjCheck(String id) throws Exception;
	
	// -------------------- 승수님 -------------------------
	/**
	 * 학번을 조회한다.
	 * @param vo - 조회할 정보가 담긴 BoardVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	String selectID(BoardVO vo); 
	
	/**
	 * 비밀번호 조회한다.
	 * @param vo - 조회할 정보가 담긴 BoardVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	String selectPW(BoardVO vo); 
	
	/**
	 * 비밀번호 수정한다.
	 * @param vo - 수정할 정보가 담긴 BoardVO
	 * @return void형
	 * @exception Exception
	 */
	void updatePw(BoardVO vo) throws Exception;

}
