package kr.or.hku.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.hku.admin.service.LecAplyAdminService;
import kr.or.hku.admin.vo.LectureBasicVO;
import kr.or.hku.admin.vo.LectureProgramVO;
import kr.or.hku.common.service.CommonService;
import kr.or.hku.common.vo.CommonVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/hku/admin")
@Slf4j
public class LecAplyAdminController {

	@Autowired
	private LecAplyAdminService lecApAdminService;
	
	@Autowired
	private CommonService commonService;
	
	@GetMapping("/lecaplylist")
	public String showLectAplyList(Model model) {
		List<Map<String, Object>> lecApList = lecApAdminService.getLecApList();
		List<CommonVO> commonData = commonService.getAllCommonData();
		model.addAttribute("lecApList", lecApList);
		model.addAttribute("commonData", commonData);
		
		log.info("맵리스트 정보  " +lecApList.toString());
		
		return "admin/lecaplylist";
	}
	
	@ResponseBody
	@GetMapping("/lecaplylist/{lecApNo}")
	public Map<String, Object> getLecturePlan(@PathVariable("lecApNo") int lecApNo) {
		log.info("강의계획서 보기 =>  " + lecApNo);
		// 리턴 할 맵객체 생성
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		LectureBasicVO basicVO = lecApAdminService.getLecBasicOne(lecApNo);
		LectureProgramVO lectureProgramVO = lecApAdminService.getLecProgam(lecApNo);
		
		
		dataMap.put("lecBasic", basicVO);
		dataMap.put("lecProgram", lectureProgramVO);
		return dataMap;
	}
}
