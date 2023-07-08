<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${commonData }" var="cmData">
	<c:if test="${cmData.comCdNm eq '학사'}">
		<c:set var="noticeClsf" value="${cmData.comCd}"/>
	</c:if>
</c:forEach>
<link rel="stylesheet" href="/css/admin/notice.css">
<div class="content-body">
	<div class="page-titles">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="javascript:void(0)">게시판관리</a></li>
			<li class="breadcrumb-item active"><a href="javascript:void(0)">학사공지 게시판</a></li>
		</ol>
    </div>
	<div class="container-fluid">
		<div class="card" id="card-title-1">
			<div class="card-header border-0 pb-0 ">
				<h5 class="card-title" style="font-weight: bold;">학사공지</h5>
			</div>
			<div class="card-body">
				<div class="basic-form">
					<form class="row g-3 custom-form" action="">
						<div class="col-md-2">
						   <select class="default-select form-control">
							  <option>== 선택 ==</option>
							  <option>제목</option>
							  <option>작성자</option>
						   </select>
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control input-default" placeholder="검색어를 입력해주세요">
						</div>
						<div class="col-auto">
							<button type="submit" class="btn btn-primary">검색</button>
						</div>
						<div class="col-auto">
							<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg">글쓰기</button>
						</div>	
					 </form>
				</div>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table id="example" class="display table" style="min-width: 845px">
						<thead>
							<tr>
								<th>#</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody id="noticeTbody">
						</tbody>
					</table>
				</div>
			</div>
			<div class="card-body">
				<nav>
					<ul class="pagination pagination-xs">
						<li class="page-item page-indicator">
							<a class="page-link" href="javascript:void(0)">
							<i class="la la-angle-left"></i></a>
						</li>
						<li class="page-item active"><a class="page-link" href="javascript:void(0)">1</a>
						</li>
						<li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
						<li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
						<li class="page-item"><a class="page-link" href="javascript:void(0)">4</a></li>
						<li class="page-item page-indicator">
							<a class="page-link" href="javascript:void(0)">
							<i class="la la-angle-right"></i></a>
						</li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	const myName = "${emp.empName}";
	var noticeClsf = "${noticeClsf}";
	var formData = new FormData();
	console.log(noticeClsf);
	$(function(){
		CKEDITOR.replace("noticeCn",{
			footnotesPrefix : "a"
// 			filebrowserUploadUrl : '/imageUpload.do?${_csrf.parameterName }=${_csrf.token}'
		});
		CKEDITOR.config.allowedContent = true;
		
		var sNoticeBtn = $('#sNoticeBtn');
		var noticeTtl = $('#noticeTtl');
		var noticeFrm = $('#noticeFrm');
		var noticeFile = $('#noticeFile');
		var addModal = $('#addModal');

		// 등록버튼
		sNoticeBtn.on('click',function(){
			// 등록 했을떄
			if(this.innerText == "등록"){
				let title = noticeTtl.val();
				let content = CKEDITOR.instances.noticeCn.getData();

				
				if(title == null || title == ""){
					alert("제목을 입력해주세요");
					return false;
				}
				
				if(content == null || content == ""){
					alert("내용을 입력해주세요");
					return false;
				}
// 				console.log(myName);
// 				var addData = {
// 					noticeTtl : title,
// 					noticeCn : content,
// 					noticeWrtrNm : myName
// 				};

				formData.append("noticeTtl", title);
				formData.append("noticeCn",content);
				formData.append("noticeWrtrNm", myName);
				formData.append("noticeClsf", noticeClsf);
				
				console.log(formData);
// 				return false;

				var xhr = new XMLHttpRequest();
				xhr.open("post", "/hankuk/admin/addNotice", true);
				xhr.onreadystatechange = function() {
					if(xhr.readyState == 4 && xhr.status == 200) {
						let res = xhr.responseText;
						console.log(res);
						// if (res === "success") {
						// 	alert("정상적으로 글이 등록 되었습니다.");	
						// }else{
						// 	alert("서버에러 다시 시도해주세요.");
						// }
						// addModal.modal('hide');
						// // 새로운 글추가 원래 이렇게 하면안됨 나중에 수정
						// noticeList();
					}
				};
				xhr.send(formData);
			}else if(this.innerText == "수정"){ // 수정 버튼 눌럿 을떄
				console.log("수정 버튼 클릭");
				$('#deleteBtn').text("취소");
				this.innerText = "저장";

				$('#detailDiv').css("display","none");
				$('#noticeFrm').css("display","block");
				$('#noticeTtl').val($("#detailTtl").html());
				CKEDITOR.instances.noticeCn.setData($("#detailCn").html());

			}else if(this.innerText == "저장"){
				console.log("저장 하기");
			}else{
				return false;
			}
		});
		
		// 삭제 & 취소 버튼
		$('#deleteBtn').on('click',function(){
			if(this.innerText == "삭제"){
				console.log("삭제 버튼 눌림");
			}else if(this.innerText == "취소"){
				console.log("취소 버튼 눌림");
				this.innerText = "삭제";
				$('#sNoticeBtn').text("수정");
				$('#detailDiv').css("display","block");
				$('#noticeFrm').css("display","none");
			}
		});
	});

	noticeList(); // 노티스 리스트 가져오기

	// 게시판 테이블
	const noticeTbody = document.querySelector("#noticeTbody");

	// 노티스 리스트 가져오기
	function noticeList(){
		var xhr = new XMLHttpRequest();
		xhr.open("get", "/hankuk/admin/noticeList", true);
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var noticeData = JSON.parse(xhr.responseText);
				var tblStr = ``
				for(let i=0; i<noticeData.length; i++){
					tblStr += `<tr class="noticeTr">
								 <td>\${noticeData[i].noticeNo}</td>
								 <td>\${noticeData[i].noticeTtl}</td>
								 <td>\${noticeData[i].noticeWrtrNm}</td>
								 <td>\${noticeData[i].noticeRegdate}</td>
								 <td>\${noticeData[i].noticeReadCnt}</td>
							   </tr>`
				}
				noticeTbody.innerHTML = tblStr;
			}
		};
		xhr.send();
	}
	
	// 상세보기
	$(function(){
		$(document).on('click',".noticeTr",function(){
			var addModal = $('#addModal');
			let noticeNo = $(this).children().eq(0).text();
			let noticeCnt = parseInt($(this).children().eq(4).text()) + 1;
			$(this).children().eq(4).text(noticeCnt)
// 			console.log(noticeNo);
			let data = {
				"noticeNo" : noticeNo
			};
			$.ajax({
				type: "get",
				url:"/hankuk/admin/getNoticeOne",
				contentType : "application/json;charset=UTF-8",
				data: data,
				dataType: "json",
				success : function(res){
					$('#sNoticeBtn').text("수정"); // 등록 버튼 수정으로 바꿈
					$('#noticeFrm').css('display', 'none'); // 등록폼 안보이게
					$('#detailDiv').css('display', 'block');// 상세div 보이게
					$('#deleteBtn').css('display', 'block');// 삭제 버튼 보이게
					addModal.modal('show'); // 모달창 등장
					
					// 데이터 삽입
					console.log(res);
					$('#detailTtl').html(res.noticeTtl);
					$('#detailRegDt').html(res.noticeRegdate);
					$('#detailWrtr').html(res.noticeWrtrNm);
					$('#detailCnt').html(res.noticeReadCnt);
					$('#detailCn').html(res.noticeCn);
				}
			});
		});

		// 파일 이벤트
		var noticeFile = document.querySelector('#noticeFile');
		// 파일 미리보기
		var previewFile = document.querySelector('.previewFile');

		// 파일 변경 했을떄
		noticeFile.addEventListener('change', function(e){
			let files = e.target.files;
			console.log(files);
			if(files.length == 0 || files == null){
				previewFile.innerHTML = "";
				return false;
			}
			
			for(let i=0; i<files.length; i++){
				formData.append("preivewFiles",files[i]);
			}
			var xhr = new XMLHttpRequest();
			xhr.open("post", "/common/file/upload", true); 
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					data = data.split(',');
					console.log(data);
					var str = "";
					for(let i=0; i<data.length; i++){
						if(checkImageType(data[i])){	// 이미지 면 이미지 태그를 이용하려 출력
							str += `<div>
										<a href='/common/file/displayFile?fileName=\${data[i]}'>
											<img src='/common/file/displayFile?fileName=\${getThumnailName(data[i])}'>
										</a>
										<span>X</span>
									</div>`;
						}else{
							str += `<div>
										<a href='/common/file/displayFile?fileName=\${data[i]}'>\${getOriginalName(data[i])}</a>
										<span>X</span>
									</div>`;
						}
						previewFile.innerHTML = str;
					}
				}
			}
			xhr.send(formData); 
		});
		
		// 파일 스판테그 x눌럿을때
		$(previewFile).on('click','span',function(){
// 			console.log(document.querySelector('#noticeFile'))
			$(this).parent("div").remove();
		});

		function getThumnailName(fileName) {
			var front = fileName.substr(0,12);	// /2023/06/07 폴더
			var end = fileName.substr(12);		// 뒤 파일명
			console.log("front : " + front);
			console.log("end : " + end);
			return front + "s_" + end;
		}
		
		function getOriginalName(fileName) {
			if(checkImageType(fileName)){
				return;
			}
			let idx = fileName.indexOf("_") + 1;
			return fileName.substr(idx);
		}
		
		
		// 이미지 파일인지 확인한다.
		function checkImageType(fileName) {
			var pattern = /jpg|gif|png|jpeg/;
			return fileName.match(pattern); // 패턴과 일치하면 true 
		}

		// 모달창 닫힐떄 이벤트
		$('#addModal').on('hidden.bs.modal', function(e){
			$(this).find('form')[0].reset();
			CKEDITOR.instances.noticeCn.setData("");
			$('#deleteBtn').css('display', 'none');
			$('#detailDiv').css('display', 'none');
			$('#noticeFrm').css('display', 'block');
			$('#sNoticeBtn').text("등록");
			$('#deleteBtn').text("삭제");
			$('#previewFile').html("");
		});
	});
</script>
<!-- 게시판 등록&수정  모달창 -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" style="display: none;" aria-hidden="true" id="addModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" style="font-weight: bold;">학사공지 게시판</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal">
				</button>
			</div>
			<div class="modal-body">
				<div class="basic-form" id="regDiv">
					<div class="form-validation">
						<form class="needs-validation" id="noticeFrm">
							<div class="mb-3">
								<label class="col-lg-4 col-form-label" for="validationCustom01">
									제목 <span class="text-danger">*</span>
								</label>
								<input type="text" name="noticeTtl" id="noticeTtl" class="form-control" id="validationCustom01" placeholder="제목을 입력하세요." required>
								<div class="invalid-feedback">
									제목을 입력해주세요.
								</div>
							</div>
							<div class="mb-3">
								<label class="col-lg-4 col-form-label" for="validationCustom04">
									내용 <span class="text-danger">*</span>
								</label>
								<textarea name="noticeCn" id="noticeCn" class="form-control h-50" id="validationCustom04" rows="5" placeholder="내용을 입력하세요." required></textarea>
								<div class="invalid-feedback">
									내용을 입력해주세요.
								</div>
							</div>
							<div class="mb-3">
								<input class="form-control form-control-sm" id="noticeFile" type="file" multiple>
							</div>
							<!-- 파일 이미지  -->
							<div class="mb-3 previewFile"></div>
						</form>
					</div>
				</div>
				<div class="basic-form" id="detailDiv">
					<div class="mb-3">
						<h1 id="detailTtl">몰라?</h1>
					</div>
					<div class="mb-3 g-3 row detailInfo">
						<div class="col-auto">
							<label>● 등록일 : <span id="detailRegDt">1</span></label>
						</div>
						<div class="col-auto">
							<label>● 작성자 : <span id="detailWrtr">2</span></label>
						</div>
						<div class="col-auto">
							<label>● 조회수 : <span id="detailCnt">3</span></label>
						</div>	
					</div>
					<div class="mb-3" id="detailCn">
						내용
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger light" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-danger light" id="deleteBtn">삭제</button>
				<button type="button" class="btn btn-primary" id="sNoticeBtn">등록</button>
			</div>
		</div>
	</div>
</div>