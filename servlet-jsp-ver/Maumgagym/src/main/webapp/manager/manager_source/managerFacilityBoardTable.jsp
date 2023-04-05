<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.to.board.BoardDAO"%>    
<%
	
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardTO> facilityBoardLists = dao.facilityBoardList();
	
	int totalRecord = facilityBoardLists.size(); //총데이터갯수
	
	StringBuilder sbFacility = new StringBuilder();
			 
			 for( BoardTO to : facilityBoardLists){
				int seq = to.getSeq();
				String category = to.getCategory();
				String topic = to.getTopic();
				String title = to.getTitle();
				String name = to.getName();
				int write_seq = to.getWrite_seq();
				String date = to.getWrite_date();
				 
				sbFacility.append("<tr>");
				sbFacility.append("<td scope='row'>" + seq + "</td>");
				sbFacility.append("<td class='text-muted'>" + category + "</td>");
				sbFacility.append("<td>" + topic + "</td>");
				sbFacility.append("<td class='text-start fw-bold'>");
				sbFacility.append("<a href='viewPage.jsp?seq=" + seq + "'>" + title + "</a>&nbsp;"); 
				sbFacility.append("</td>");
				sbFacility.append("<td>" + name + "</td>");
				sbFacility.append("<td>" + date + "</td>");
				sbFacility.append("<td><a onclick=\"deleteboard('"+seq+"');\"><span class=\"badge bg-danger\">삭제</span></a></td>");
				sbFacility.append("</tr>");
			 }
%>    
<hr/>
<script type="text/javascript">
function deleteboard(deleteSeq) {
	alert(deleteSeq);
	
	//ajax 삭제 쿼리
}
</script>
		<div class="container mt-5">
			<div class="row">

            <div class="page-heading">
                <section class="section">
                    <div class="card">
                        <div class="card-header bg-white">
                          <h3>운동시설관리</h3>
                          <p class="text-subtitle text-muted">등록된 운동시설 게시글들을 통합하여 관리합니다.</p>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover" id="table1">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>카테고리</th>
                                        <th>토픽</th>
                                        <th>업체게시글</th>
                                        <th>업체명</th>
                                        <th>작성일</th>
                                        <th>기능</th>
                                    </tr>
                                </thead>
                                <%= sbFacility.toString() %>
                            </table>
                        </div>
                    </div>

                </section>
            </div>
         </div>
       </div>
