package kr.or.hku.student.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.hku.student.vo.RecordVO;
import kr.or.hku.student.vo.StudentVO;
@Mapper
public interface RecordMapper {
	
	// 현재 로그인한 학생 학적정보 조회
	public StudentVO recordInfo(String stdNo);
	// 학적 변동기록
	public List<RecordVO> recordList(String stdNo);
	// 학적변동 신청내역
	public List<RecordVO> recordChanged(RecordVO recordVo);
}
