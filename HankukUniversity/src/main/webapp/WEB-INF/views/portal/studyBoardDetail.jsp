<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
</style>

<div class="container-fluid mt-3">
    <div class="row" style="background: white; padding: 10px; height: 847px;">
    	<div class="col-xl-12 mb-3">
            <h2><c:out value="${studyBoard.stboTitle }"/></h2>
            <input type="hidden" name="stboNo" id="stboNo" value="<c:out value="${studyBoard.stboNo }"/>">
        </div>
        <hr>
        <div class="col-xl-12 mb-3">
            <div class="row" style="font-size: 18px; display: flex; flex-direction: column;">
                <div class="col-xl-4 mb-1" style="width: 100%; display: flex; justify-content: space-between;">
                    <p>● 스터디명 : <c:out value="${studyBoard.studyName }"/></p>
                </div>
               <div class="col-xl-4 mb-1" style="width: 94%; display: flex; justify-content: space-between;">
                    <p>● 스터디장 : <c:out value="${studyBoard.stboWriter }"/></p>
                    <p>● 등록일 : <c:out value="${studyBoard.stboRegdate }"/></p>
                    <p>● 조회수 : <c:out value="${studyBoard.stboReadCnt }"/></p>
                </div>
<!--                 <div class="col-xl-4 mb-1" style="width: 20%;"> -->
<!--                 </div> -->
<!--                 <div class="col-xl-4 mb-1" style="width: 20%;"> -->
<!--                 </div> -->
            </div>
        </div>
        <hr>
    	<div class="col-xl-12 mb-3" style="height: 570px; overflow: auto;">
           ${studyBoard.stboContent }
        </div>
        <hr>
    	<div class="col-xl-12 mb-3">
    		<c:forEach items="" var="file">
    			<div class="mailbox-attachment-info">
<%-- 					<a href="/download${file.filePath}" download="${file.fileOrgnlFileNm}" class="mailbox-attachment-name fileDown"> --%>
<%-- 						<i class="fas fa-paperclip"></i> &nbsp;${file.fileOrgnlFileNm} &nbsp;[${file.fileSize}] --%>
<!-- 					</a> -->
				</div>
    		</c:forEach>
        </div>
        <div class="col-xl-12" style="position: relative;">
                <div class="col-xl-12" style="position: absolute; top:0; top: -39px; right: -619px;">
                    <button class="btn btn-primary" id="listBtn" style="margin: 5px;">목록</button>
                    <c:choose>
	                	<c:when test="${studyBoard.stdNo eq stdNo }">
		                    <button class="btn btn-primary" id="" style="margin: 5px; background: #0070c0; border-color: #0070c0;" onclick="openModal()">수정</button>
		                    <button class="btn btn-primary" id="delBtn" style="margin: 5px; background: #ff4343; border-color: #ff4343;" onclick="delBoard()">삭제</button>          	
	                	</c:when>
	                	<c:otherwise>
	                		<c:if test="${studyBoard.studyCpcy gt studyBoard.count}">				        	
			                	<button type="button" class="btn btn-primary" style="margin: 5px; background: #0070c0; border-color: #0070c0;" data-bs-toggle="modal" data-bs-target="#basicModal">가입신청</button>
					        </c:if>
					        <c:if test="${studyBoard.studyCpcy le studyBoard.count}">
					            <button type="button" class="btn btn-primary">모집완료</button>
					        </c:if>       	
	                	</c:otherwise>
	                </c:choose>     
               </div>
            
        </div>
    </div>
    
    <div class="modal fade" id="basicModal" style="display: none;" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">스터디 가입신청</h5> 
	                <button type="button" class="btn-close" data-bs-dismiss="modal">
	                </button>
	            </div>
	            <div class="modal-body">
	            	<form action="" name="frm3">
	            		<input type="hidden" name="studyNo" id="studyNo3" value="${studyBoard.studyNo }">
	            		<input type="hidden" name="stdNo" id="stdNo" value="${studyBoard.stdNo }">
	            		<div class="mb-3">
							<label class="col-lg-4 col-form-label" for="validationCustom04">
								자기소개 <span class="text-danger"></span>
							</label>
							<textarea name="joinReason" id="joinReason" class="form-control h-50" id="validationCustom04" rows="3"required></textarea>
							<div class="invalid-feedback">
							</div>
						</div>
	            	</form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" id="join-close" class="btn btn-danger light" data-bs-dismiss="modal">닫기</button>
	                <c:choose>
					    <c:when test="${studyBoard.stdNo eq stdNo}">
					    	
					    </c:when>
					    <c:otherwise>
					        <c:if test="${studyBoard.studyCpcy gt studyBoard.count}">				        	
					            <button type="button" class="btn btn-primary" onclick="intoStudy()">가입신청</button>
					        </c:if>
					        <c:if test="${studyBoard.studyCpcy le studyBoard.count}">
					            <button type="button" class="btn btn-primary">모집완료</button>
					        </c:if>
					    </c:otherwise>
					</c:choose>	     					               
            	</div>
	        </div>
	    </div>
	</div>
	
	<div class="modal fade bd-example-modal-lg" tabindex="-1" style="display: none;" aria-hidden="true" id="detailModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" style="font-weight: bold;">게시판 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal">
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="" name="">
				<div class="basic-form" id="regDiv">
					<div class="form-validation">
						<form class="needs-validation" id="frm2" name="frm2" enctype="multipart/form-data" method="post">
							<input type="hidden" name="stboNo" id="stboNo2" >
							<div class="mb-3">
								<label class="col-lg-4 col-form-label" for="validationCustom01">
									제목 <span class="text-danger"></span>
								</label>
								<input type="text" name="stboTitle" id="stboTitle2" value="${studyBoard.stboTitle }" class="form-control" id="validationCustom01" required>
							</div>
							<div class="mb-3">
								<label class="col-lg-4 col-form-label" for="validationCustom04">
									작성자 <span class="text-danger"></span>
								</label>
								<input  name="stboWriter" id="stboWriter2" class="form-control" id="validationCustom01" value="${studyBoard.stboWriter }" readonly="readonly" required>
							</div>
							<div class="mb-3">
								<label class="col-lg-4 col-form-label" for="validationCustom04">
									내용 <span class="text-danger"></span>
								</label>
								<textarea name="stboContent" id="stboContent2" class="form-control h-50" id="validationCustom04" rows="6"required>${studyBoard.stboContent }</textarea>
								<div class="invalid-feedback">
								</div>
							</div>
							<!-- 파일 이미지  -->
							<div class="row previewFile"></div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer" id="btnDiv">
				<button type="button" class="btn btn-danger light" data-bs-dismiss="modal" id="closeBtn">닫기</button>
				<button type="button" class="btn btn-primary" onclick="modifyStudyBoard()" id="btn2">수정</button>
				<button type="button" class="btn btn-primary" onclick="delBoard()" id="btn3">삭제</button>
			</div>
		</div>
	</div>
</div>

</div>
<script>
function clearInputFields() {   
    document.getElementById("stboTitle2").value = "";
    document.getElementById("stboWriter2").value = "";
    document.getElementById("stboContent2").value = "";
}

function openModal() {
    $('#detailModal').modal('show');
}
function closeModal() {
    var closeBtn = document.getElementById("closeBtn");
    closeBtn.click();
    clearInputFields();
}

function closeModal2() {
    var delBtn = document.getElementById("delBtn");
    delBtn.click();
    clearInputFields();
}

var listBtn = document.querySelector('#listBtn');

listBtn.addEventListener('click', ()=>{
    location.href = "/hku/student/studyBoard";
});
    
function intoStudy(){
	var aModal = $("#basicModal");
	
	var modalForm = document.forms.frm3;
	
	var studyNo = modalForm.studyNo3.value;
	var joinReason = modalForm.joinReason.value;
	
	var stdNo = modalForm.stdNo.value;
	var sessStdNo = ${sessionScope.std.stdNo};
	
	if(stdNo == sessStdNo){
		swal({
			title: "본인의 스터디에는 가입신청 할 수 없습니다.", 
			icon: "error"
		});
		return false;
	}

	var data = {
		"studyNo": studyNo,
		"joinReason": joinReason,
		"stdNo":"${studyBoard.stdNo}"
		}
	
	console.log("글쓴이 체크",data)
	let xhr = new XMLHttpRequest();
	xhr.open("POST","/hku/student/intoStudy",true);
	xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			if(xhr.responseText === "SUCCESS"){
				console.log("");
				document.getElementById("join-close").click();
				 swal({
						title: "가입신청이 완료되었습니다.", 
						icon: "success"
					});
			} else if(xhr.responseText === "FAILED"){
				swal({
        			title: "이미 가입된 스터디 입니다!", 
        			icon: "error"
        		});
			}
			boardList();
			closeModal2();
		}
	}
	xhr.send(JSON.stringify(data));
}

function delBoard() {
    var stboNo = document.getElementById("stboNo").value;
	console.log("stdNo",stboNo);
    var stboNo = {
        "stboNo": stboNo
    };

    $.ajax({
        type: "POST",
        data: stboNo,
        url: "/hku/student/deleteStudyBoard",
        beforeSend : function(xhr){xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); },
        dataType: "json",
        success: function(res) {
            console.log("res: ", res);
	            if(res>0){
	            	swal({
						title: "삭제되었습니다.", 
						icon: "success"
					});
	            }else{
	            	swal({
	        			title: "삭제실패!", 
	        			icon: "error"
	        		});
	            }
	            location.href = "/hku/student/studyBoard";
	       	}
        
    });
}

function modifyStudyBoard(){
	var dModal = $("#detailModal");
	
	var modalForm = document.forms.frm2;
	
	var stboTitle = modalForm.stboTitle2.value;
	var stboContent = modalForm.stboContent2.value;
	var stboNo = document.getElementById("stboNo").value;

	var data = {
		"stboTitle": stboTitle,
		"stboContent": stboContent,
		"stboNo": stboNo
		}

	let xhr = new XMLHttpRequest();
	xhr.open("POST","/hku/student/modifyStudyBoard",true);
	xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			if(xhr.responseText === "SUCCESS"){
				console.log("");
				 swal({
						title: "게시글 수정이 완료되었습니다.", 
						icon: "success"
					});
			} else if(xhr.responseText === "FAILED"){
				swal({
        			title: "게시글 수정에 실패하였습니다!", 
        			icon: "error"
        		});
			}
	   		closeModal();
		}
	}
	xhr.send(JSON.stringify(data));
	location.href = "/hku/student/studyBoard";
}


</script>



