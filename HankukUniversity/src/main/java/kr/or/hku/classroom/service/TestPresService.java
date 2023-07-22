package kr.or.hku.classroom.service;


import java.util.List;
import java.util.Map;

import kr.or.hku.ServiceResult;
import kr.or.hku.classroom.vo.StudentAnswerVO;
import kr.or.hku.classroom.vo.TestAnswerVO;
import kr.or.hku.classroom.vo.TestVO;

public interface TestPresService {
	public ServiceResult testInsert(TestVO test);
	public int testCheck(TestVO test);
	public TestVO testDetail(TestVO test);
	public TestVO timeChange(TestVO test);
	public ServiceResult testUpdate(TestVO testVO);
	public List<TestVO> getTestList(String stdNo);
	public List<TestAnswerVO> getAnswerList(TestVO test);
	public int getMaxCh(TestVO test);
	public int testTakeInsert(TestVO test);
	public void studentTestAnswerInsert(StudentAnswerVO sAnsVO);
	public int scoreUpdate(Map<String, Object> map);
	public int preTestCheck(Map<String, Object> map);
	public TestVO getTtNo(TestVO test);
	public List<StudentAnswerVO> getStuAnsList(int ttNo);
}
