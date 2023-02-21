<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     


<%@page import="com.maumgagym.dto.CommentTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%
	String cmt_writer = (String)session.getAttribute( "nickname" );

	String id1 = null;
	if( session.getAttribute("id") != null ) {
		id1 = ( String ) session.getAttribute("id");
	}
	
	System.out.println(id1);

	BoardTO to = (BoardTO)request.getAttribute("bto");
	
	int seq = to.getSeq();
	String id = to.getId();
	System.out.println(to.getId());
	String subject = to.getTitle();
	String date = to.getWrite_date();
	String writer = to.getWriter();
	String content = to.getContent();
	
	System.out.println(id);
	
	
	//System.out.println( "제목 : " + subject );
	
  	// 댓글
	ArrayList<CommentTO> cmtList = (ArrayList)request.getAttribute( "commentList" );
  	
	//System.out.println( "댓글 리스트 : " + cmtList.size() );
 	
 	StringBuilder sbCmt = new StringBuilder();
 	int size = cmtList.size();
 		
 	for( CommentTO cmtto : cmtList ) {
 		
 		String nickname = cmtto.getNickname();
 		String writeDate = cmtto.getWrite_date();
 		String comment = cmtto.getContent();
 		
  		//System.out.println( "내용 : " + cmtto.getContent() );
		
  		sbCmt.append( "	 	<div class='d-flex justify-content-between mb-2'>");
		sbCmt.append( "  		<div class='d-flex flex-row align-items-center'>");
		sbCmt.append( "    			<span class='small mb-0 ms-2 fs-6 fw-bold' id='writer'><i class='material-icons'></i>&nbsp;" + nickname +"</span> <span class='text-end'></span>");
		sbCmt.append( "	  		</div>");
		sbCmt.append( "	  		<div class='d-flex flex-row align-items-center'>");
		sbCmt.append( "	    		<small>&nbsp;" + writeDate +"</small>");
	 	sbCmt.append( " 		</div>");
	 	sbCmt.append( "		</div>");
		
	 	sbCmt.append( "		<div class='d-flex justify-content-between mb-3'>");
 	 	sbCmt.append( "			<div class='d-flex flex-row align-items-center'>");
	 	sbCmt.append( "				<p class='small mb-0 ms-2'> " + comment +" </p>");
	 	sbCmt.append( "			</div>"); 
	 	sbCmt.append( "			<div class='d-flex flex-row align-items-center'>");
		sbCmt.append( "			</div>");
	 	sbCmt.append( "		</div>");
	 	sbCmt.append( "		<hr>");
 	}

%>

<hr/>
	
	<br/><br/><br/>
	<div class="container px-3 px-lg-5">
			<p class="h2" style="font-weight: bold;"><%= subject %></p>
			<div class="text-end">
				<table class="text-end">
					<th>
					    <i class="bi-heart" style="font-size:30px; color: red; cursor: pointer;" id="heartimg"></i>
						<input type="hidden" name="board_seq" id="board_seq" value="<%= seq %>" />
						<input type="hidden" name="user" id="user" value="<%= id1 %>" />
					</th>
						<td>
						  <b>좋아요 <span id="likenumber"></span></b> 
						</td>
				</table>
			</div>
	</div>
	<div class="container px-3 px-lg-5">
			<!--게시판-->
			<div class="board_view">
				<table class="table text-start table-bordered">
				<tr>
					<th width="10%" class="text-bg-light p-3">제목</th>
					<td width="45%"><%= subject %></td>
				</tr>
				<tr>
					<th width="10%" class="text-bg-light p-3">등록일</th>
					<td width="55%"><%= date %></td>
				</tr>
				<tr>
					<th class="text-bg-light p-3">글쓴이</th>
					<td colspan="3"><%= writer %></td>
				</tr>
				<tr>
					<td colspan="4" height="320" valign="top" style="padding: 20px; line-height: 160%"><%= content %></td>
				</tr>
				<tr>
				<td colspan="4">
					<div class="card-header bg-light">
						<b><%=size %> 개의 댓글</b>&nbsp;<i class="fa-sharp fa-solid fa-comment"></i>
						<br/><br/>
		                  <div class="card-body">
							<%=sbCmt.toString() %> 
		                  </div>
					</div><br/>
					<div class="container">
						<ul class="list-group list-group-flush">
						    <li class="list-group-item">
						<!--<div class="row">
							<div class="col-md-4">
								<label for="replyId"><i class="fa-sharp fa-solid fa-user"></i></label>
								<input type="text" class="form-control" placeholder="Enter yourId" id="replyId">
							</div>
							<div class="col-md-4">
								<label for="replyPassword" class="ml-4"><i class="fa fa-unlock-alt"></i></label>
								<input type="password" class="form-control ml-2" placeholder="Enter password" id="replyPassword">
							</div> 
						    </div>-->
							<div class="text-end">
							<textarea class="form-control" id="comment" rows="3"></textarea>
							<button type="button" class="btn btn-dark mt-3" id="cmtbtn"><i class="fa-solid fa-floppy-disk"></i>&nbsp;댓글쓰기</button>
						    </div>
						    </li>
						</ul>
					</div>
				</td>
				</tr>
				</table>
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<input type="button" value="목록" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='/community/list'" />
				</div>
				<% if( id.equals(id1) ){ %>
					<div class="col-md-6 text-end">
						<input type="button" value="수정" class="btn btn-outline-primary" style="cursor: pointer;" onclick="location.href='/community/modify?seq=<%=seq %>'"/>
						<input type="button" value="삭제" class="btn btn-outline-danger" style="cursor: pointer;" onclick="location.href='/community/delete?seq=<%=seq %>'" />
					</div> 
			
				<% } else if ( id == null ) {%>
					<div class="col-md-6 text-end">
						<input type="button" value="수정" class="btn btn-outline-primary" style="cursor: pointer;" onclick="location.href='/community/modify?seq=<%=seq %>'"/>
						<input type="button" value="삭제" class="btn btn-outline-danger" style="cursor: pointer;" onclick="location.href='/community/delete?seq=<%=seq %>'" />
					</div>
				<% }%>
			</div>
			<!--//게시판-->
		
	
	<br/><br/><br/>
	</div>	
</div>
<script>
	$('#cmtbtn').click(function(){
			
			//JSON으로 변환할 파라미터 변수 선언
			const cmt_seq = <%=to.getSeq() %>
			const cmt_writer = <%= cmt_writer%>
			const cmt_content = $('#comment').val();
			//console.log( "cmt_seq : " + cmt_seq );
			//console.log( "cmt_writer : " + cmt_writer );
			//console.log( "cmt_content : " + cmt_content );
			
			if( cmt_writer == '' ){
				alert('로그인 후 이용해 주세요.');
				return;
			} else if( cmt_content == '' ) {
				alert('내용을 입력해 주세요.');
				return;
			}
			
			$.ajax({
				type: 'post',
				url: '/comment/write',
				data:
   					{
   						"cmt_seq": cmt_seq,
   						"cmt_writer": cmt_writer,
   						"cmt_content": cmt_content
   					},
   				success:function(data){
   					if(data == 1) {
   						console.log( "data : " + data );
   					}
   				}
			});
		});
</script>

<script>
	 $(document).ready(function (){
		
		let heart = 0;
		
		$('i').on('click',function(){
			
			let user = $('#user').val();
			//console.log(user, typeof user);
			let board_seq = $('#board_seq').val();
	
			if( user === 'null'){
				alert('로그인 후 이용해주세요.');
				return;
			}
			
			if(heart == 0){
				 $.ajax({
					 url: '/community/like',
					 type: 'post',
					 data :
						{
						 "user" : user,
						 "board_seq" : board_seq
						},
					success:function(result){
						if(result == 1){
							console.log('성공');
							$('#heartimg').attr('class','bi-heart-fill');
							document.getElementById('likenumber').innerHTML = +1;
						}
					},
					error : function (err) { // 실패하면 0
						console.log('실패');
					}
					 
				 	});
				 heart++;
			}
				 
			else if (heart == 1){
				 $.ajax({
					 url: '/community/dislike',
					 type: 'post',
					 data :
						{
						 "user" : user,
						 "board_seq" : board_seq
						},
					success:function(result){
						if(result == 1){
							$('#heartimg').attr('class','bi-heart');
							document.getElementById('likenumber').innerHTML = -1;
							
						}
					},
					error : function (err) { // 실패하면 0
						console.log('실패');
					}
					 
				 	});
				 heart--;
				 }
				 
			});
		
	 });
	</script>


