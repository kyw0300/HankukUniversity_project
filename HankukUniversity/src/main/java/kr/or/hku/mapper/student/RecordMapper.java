package kr.or.hku.mapper.student;

import kr.or.hku.vo.StudentVO;

public interface RecordMapper {
	
	// 현재 로그인한 학생 학적정보 조회
	public StudentVO recordInfo(String stdNo);
}
