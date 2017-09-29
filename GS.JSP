<%@ page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>

<div class="taxallwrap">
	<div class="two-tabs tc clearfix">
	    <a href="/index.yeoncheon?menuCd=DOM_000000104011002001">세입현황</a>
	    <a href="/index.yeoncheon?menuCd=DOM_000000104011002002" class="active">세출현황</a>
	</div>
	<div class="tab-content">
		<div class="incon-tab clearfix tc">
		    <a href="/index.yeoncheon?menuCd=DOM_000000104011002002" class="active">세출현황(통계목별)</a>
		    <a href="/index.yeoncheon?menuCd=DOM_000000104011002003">세출현황(세부사업별)</a>
		</div>
		<div class="incon-tab-con">
			<div class="taxwid2">
				<div class="taxscroll2">
				    <div class="taxtabwrap active">
				        <table class="result-table tc">
				            <caption>세출 통계목별 현황표</caption>
				            <colgroup>
				                <col width="5.09%;"/>
				                <col width="7.09%;"/>
				                <col width="7.09%;"/>
				                <col width="26.09%;"/>
				                <col width="8.09%;"/>
				                <col width="8.09%;"/>
				                <col width="8.09%;"/>
				                <col width="8.09%;"/>
				                <col width="8.09%;"/>
				                <col width="8.09%;"/>
				                <col width="6.09%;"/>
				            </colgroup>
				            <thead>
					            <tr>
					                <th scope="col">회계년도</th>
					                <th scope="col">회계구분</th>
					                <th scope="col">부서명</th>
					                <th scope="col">세부사업명</th>
					                <th scope="col" colspan="2">통계목</th>
					                <th scope="col">지출액</th>
					                <th scope="col">지급일자</th>
					                <th scope="col">사업시작일자</th>
					                <th scope="col">사업종료일자</th>
					                <th scope="col">관서명</th>
					            </tr>
				            </thead>
				            <tbody>
								<%
									String DB_URL = "j";
									String DB_USER = "";
									String DB_PASSWORD= "";
									Connection conn = null;
									Statement stmt = null;
									PreparedStatement pstmt = null;
									ResultSet rs = null;
									ResultSet rs2 = null;

									try {
										Class.forName("oracle.jdbc.driver.OracleDriver");
										conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
										String PageNum_temp = request.getParameter("PageNum"); //PageNum_temp 문자열 생성해서 PageNum 파라미터값 받음
										if (PageNum_temp == null)
											PageNum_temp = "1"; //만약 값이 NULL값이면 초기값을 1페이지로 세팅
										int PageNum = Integer.parseInt(PageNum_temp); //그 값을 PageNum에 대입
										int PagePerNum = 10; //페이지당 게시물 갯수 
										int totalData = 0; //전체 행의 갯수

										stmt = conn.createStatement();
										String sql = "SELECT * FROM( SELECT ROWNUM AS RNUM, Z.* FROM( SELECT DISTINCT FIS_YEAR,FIS_FG_NM,DEPT_NM,DBIZ_NM,TE_MNG_MOK_CD,TE_MNG_MOK_NM,EXPD_RESOL_AMT,PAY_CMD_YMD,BIZ_START_YMD,BIZ_END_YMD,GOV_OFFICE_CD FROM V_FIOS_TCM_TEMNGMOKEXPDDESC ORDER BY FIS_YEAR DESC )Z WHERE ROWNUM <="+(((PageNum - 1) * PagePerNum)+10)+")WHERE RNUM >= "+(((PageNum - 1) * PagePerNum)+1)+"";

										String total = "select count(A.FIS_FG_NM) cnt from (SELECT DISTINCT FIS_YEAR,FIS_FG_NM,DEPT_NM,DBIZ_NM,TE_MNG_MOK_CD,TE_MNG_MOK_NM,EXPD_RESOL_AMT,PAY_CMD_YMD,BIZ_START_YMD,BIZ_END_YMD,GOV_OFFICE_CD FROM V_FIOS_TCM_TEMNGMOKEXPDDESC) A"; //전체 행의 갯수 구하는 쿼리문

										if (conn == null)
											throw new Exception("데이터베이스 연결 실패");
										// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)	
										pstmt = conn.prepareStatement(sql);
										rs = pstmt.executeQuery();	
										rs2 = stmt.executeQuery(total);


										if (rs2.next()) { //Data의 총합구하는 식
											totalData = rs2.getInt(1);
										}

										%>
										<p class="total-num">총 <strong><%=totalData%></strong>건이 있습니다.</p>
										<%

										while (rs.next()) {
											String FIS_YEAR = rs.getString(2);
											String FIS_FG_NM = rs.getString(3);
											String DEPT_NM = rs.getString(4);
											String DBIZ_NM = rs.getString(5);
											String TE_MNG_MOK_CD = rs.getString(6);
											String TE_MNG_MOK_NM = rs.getString(7);
											String EXPD_RESOL_AMT = rs.getString(8);
											String PAY_CMD_YMD = rs.getString(9);
											String BIZ_START_YMD = rs.getString(10);
											String BIZ_END_YMD = rs.getString(11);
											String GOV_OFFICE_NM = rs.getString(12);

											out.println("<tr>");
											out.println("<td>" + FIS_YEAR + "</td>");
											out.println("<td>" + FIS_FG_NM + "</td>");
											out.println("<td>" + DEPT_NM + "</td>");
											out.println("<td>" + DBIZ_NM + "</td>");
											out.println("<td>" + TE_MNG_MOK_CD + "</td>");
											out.println("<td>" + TE_MNG_MOK_NM + "</td>");
											DecimalFormat df = new DecimalFormat("#,###");
											out.println("<td>" + df.format(EXPD_RESOL_AMT) + "</td>");
											out.println("<td>" + PAY_CMD_YMD + "</td>");
											out.println("<td>" + BIZ_START_YMD + "</td>");
											out.println("<td>" + BIZ_END_YMD + "</td>");
											out.println("<td>" + GOV_OFFICE_NM + "</td>");
											out.println("</tr>");
										}


										pstmt.close();
										conn.close();
										


									
								%>
				            </tbody>
				        </table>
				    </div>
				</div>
			</div>
			<div class="page-num-area tc taxpager">	
				<%
					int PageBlock = 10; //페이징 블럭 갯수 (10개씩)
					int pageCount = totalData / PagePerNum + (totalData % PagePerNum == 0 ? 0 : 1); //페이징 개수 전체 카운트
					int startPage = (PageBlock * ((PageNum - 1) / PageBlock)) + 1; //시작페이지
					int endPage = startPage + (PageBlock - 1); //끝페이지

					if (pageCount < endPage)
						endPage = pageCount; //마지막 페이지가 전체 페이징 개수 보다 크면 값을 같게 한다.

					if (PageNum > PageBlock) {
				%>
						<a href="/index.yeoncheon?menuCd=DOM_000000104011002002&PageNum=<%=1%>" class="page-first">&lt;&lt;<span class="screen_out">처음으로</span></a>
						<a href="/index.yeoncheon?menuCd=DOM_000000104011002002&PageNum=<%=startPage >= 2 ? (startPage - 1) : startPage%>" class="page-prev">&lt;<span class="screen_out">이전</span></a>
				<%
					}
				%>
					<ul>
				<%
					
						for (int i = startPage; i <= endPage; i++) { //현재 페이지이면 링크 없애는 기능
							if (PageNum == i) { //시작페이지가 현재 페이지와 같으면 
				%>
								<li class="active page-num" title="현재페이지"><%=i%></li>
				<%
							}else {
				%>
								<li class="page-num"><a href="/index.yeoncheon?menuCd=DOM_000000104011002002&PageNum=<%=i%>"><%=i%></a></li>
				<%
							}
						}
				%>
					</ul>
				<%
						
					if (endPage < pageCount) { //마지막 페이지보다 전체 페이징 개수가 크면
				%>
						<a href="/index.yeoncheon?menuCd=DOM_000000104011002002&PageNum=<%=startPage + PageBlock%>" class="page-next"><span class="screen_out">다음</span>&gt;</a>
						<a href="/index.yeoncheon?menuCd=DOM_000000104011002002&PageNum=<%=pageCount%>" class="page-end"><span class="screen_out">마지막으로</span>&gt;&gt;</a>
				<%
					}
				%>
			</div>
		</div>
	</div>
</div>
<%
	}finally {
		try {
			pstmt.close();
		} catch (Exception ignored) {
			ignored.printStackTrace();
		}

		try {
			conn.close();
		} catch (Exception ignored) {
			ignored.printStackTrace();
		}
	}
%>