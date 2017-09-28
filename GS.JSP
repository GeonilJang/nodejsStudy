<%@ page import="java.sql.*"%>

<div class="taxallwrap">
	<div class="two-tabs tc clearfix">
	    <a href="/index.yeoncheon?menuCd=DOM_000000103003008001">세입현황</a>
	    <a href="/index.yeoncheon?menuCd=DOM_000000103003008002" class="active">세출현황</a>
	</div>
<div class="tab-content">
    <div class="incon-tab clearfix tc">
        <a href="/index.yeoncheon?menuCd=DOM_000000103003008002">세출현황(통계목별)</a>
        <a href="/index.yeoncheon?menuCd=DOM_000000103003008003" class="active">세출현황(세부사업별)</a>
    </div>
    <div class="incon-tab-con">
        <div class="taxwid">
	        <div class="taxscroll">
	            <div class="taxtabwrap active">
	                <table class="result-table tc">
			       		<caption>세출 세부사업별 현황표</caption>
			            <colgroup>
			                <col width="4.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="8.25%;"/>
	                        <col width="16.25%;"/>
	                        <col width="4.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="4.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="6.25%;"/>
	                        <col width="3.25%;"/>
	                        <col width="3.25%;"/>
			            </colgroup>
			            <thead>
			            <tr>
			                <th scope="col">회계년도</th>
	                        <th scope="col">회계구분</th>
	                        <th scope="col">부서명</th>
	                        <th scope="col">세부사업명</th>
	                        <th scope="col">사업구분</th>
	                        <th scope="col">예산현액</th>
	                        <th scope="col">국비</th>
	                        <th scope="col">도비</th>
	                        <th scope="col">시군구비</th>
	                        <th scope="col">지출액</th>
	                        <th scope="col">사업시작일자</th>
	                        <th scope="col">사업종료일자</th>
	                        <th scope="col">편성액</th>
	                        <th scope="col">이월액</th>
	                        <th scope="col">변경<br/>금액</th>
	                        <th scope="col">수입<br/>대체<br/>경비</th>

			            </tr>
			            </thead>
			            <tbody>
							<%
							String DB_URL = "";
							String DB_USER = "";
							String DB_PASSWORD= "";
							Connection conn = null;
							Statement stmt = null;
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							ResultSet rs2 = null;

							try{
								int pageCnt = 0;
								Class.forName("oracle.jdbc.driver.OracleDriver");
								conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
								
								String PageNum_temp = request.getParameter("PageNum"); //PageNum_temp 문자열 생성해서 PageNum 파라미터값 받음
									if (PageNum_temp == null)PageNum_temp = "1"; //만약 값이 NULL값이면 초기값을 1페이지로 세팅
									int PageNum = Integer.parseInt(PageNum_temp); //그 값을 PageNum에 대입
									int PagePerNum = 10; //페이지당 게시물 갯수 
									int totalData = 0; //전체 행의 갯수
								
								stmt = conn.createStatement();
								String sql = "SELECT * FROM( SELECT ROWNUM AS RNUM, Z.* FROM( SELECT * FROM V_FIOS_TBM_TECURRAMT ORDER BY FIS_YEAR DESC )Z WHERE ROWNUM <="+(((PageNum - 1) * PagePerNum)+10)+")WHERE RNUM >= "+(((PageNum - 1) * PagePerNum)+1)+"";//String sql = "SELECT * FROM V_FIOS_TBM_TECURRAMT";
								String total = "select count(*) cnt from V_FIOS_TBM_TECURRAMT"; //전체 행의 갯수 구하는 쿼리문

									if(conn == null)throw new Exception("데이터베이스 연결 실패");// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)	
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();	
								rs2 = stmt.executeQuery(total);
									if (rs2.next())totalData = rs2.getInt(1);
	
								while (rs.next()) {
									String FIS_YEAR = rs.getString("FIS_YEAR");
									String FIS_FG_NM = rs.getString("FIS_FG_NM");
									String DEPT_NM = rs.getString("DEPT_NM");
									String DBIZ_NM = rs.getString("DBIZ_NM");
									String SUBSD_BGT_FG = rs.getString("SUBSD_BGT_FG");
									int BGT_CURR_AMT = rs.getInt("BGT_CURR_AMT");
									int NATN_CURR_AMT = rs.getInt("NATN_CURR_AMT");
									int SIDO_CURR_AMT = rs.getInt("SIDO_CURR_AMT");	
									int SIGUNGU_CURR_AMT = rs.getInt("SIGUNGU_CURR_AMT");	
									int EXPD_AMT = rs.getInt("EXPD_AMT");
									String BIZ_START_YMD = rs.getString("BIZ_START_YMD");
									String BIZ_END_YMD = rs.getString("BIZ_END_YMD");
									int COMPO_AMT = rs.getInt("COMPO_AMT");
									int FORWD_AMT = rs.getInt("FORWD_AMT");
									int CHNG_AMT = rs.getInt("CHNG_AMT");
									int ETC_AMT = rs.getInt("ETC_AMT");

									out.println("<tr>");
									out.println("<td>" + FIS_YEAR + "</td>");
									out.println("<td>" + FIS_FG_NM + "</td>");
									out.println("<td>" + DEPT_NM + "</td>");
									out.println("<td>" + DBIZ_NM + "</td>");
									out.println("<td>" + SUBSD_BGT_FG + "</td>");
									out.println("<td>" + BGT_CURR_AMT + "</td>");
									out.println("<td>" + NATN_CURR_AMT + "</td>");
									out.println("<td>" + SIDO_CURR_AMT + "</td>");
									out.println("<td>" + SIGUNGU_CURR_AMT + "</td>");
									out.println("<td>" + EXPD_AMT + "</td>");
									out.println("<td>" + BIZ_START_YMD + "</td>");
									out.println("<td>" + BIZ_END_YMD + "</td>");
									out.println("<td>" + COMPO_AMT + "</td>");
									out.println("<td>" + FORWD_AMT + "</td>");
									out.println("<td>" + CHNG_AMT + "</td>");
									out.println("<td>" + ETC_AMT + "</td>");
									out.println("</tr>");
									pageCnt++;
								}
								%>
									<p class="total-num">총 <strong><%=pageCnt%></strong>건이 있습니다.</p>
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
            %>

            <%
            if (pageCount < endPage)
            endPage = pageCount; //마지막 페이지가 전체 페이징 개수 보다 크면 값을 같게 한다.

            if (PageNum > PageBlock) {
            %>
            <a href="/index.yeoncheon?menuCd=DOM_000000104011002003&PageNum=<%=1%>" class="page-first">&lt;&lt;<span class="screen_out">처음으로</span></a>
            <a href="/index.yeoncheon?menuCd=DOM_000000104011002003&PageNum=<%=startPage >= 2 ? (startPage - 1) : startPage%>" class="page-prev">&lt;<span class="screen_out">이전</span></a>

            <%
            }
            %>

            <ul>
                <%
                for (int i = startPage; i <= endPage; i++) { //현재 페이지이면 링크 없애는 기능
                if (PageNum == i) { //시작페이지가 현재 페이지와 같으면
                %>
                <li class="active page-num" title="현재페이지"><%=i%></li>
                <!-- 링크를 없앤다. -->
                <%
                } else {
                %>
                <!-- 만악 다르면 -->
                <li class="page-num"><a href="/index.yeoncheon?menuCd=DOM_000000104011002003&PageNum=<%=i%>"><%=i%></a></li>
                <!-- 링크를 걸어준다. -->
                <%
                }
                }
                %>
            </ul>
            <%
            if (endPage < pageCount) { //마지막 페이지보다 전체 페이징 개수가 크면
            %>

            <a href="/index.yeoncheon?menuCd=DOM_000000104011002003&PageNum=<%=startPage + PageBlock%>" class="page-next"><span class="screen_out">다음</span>&gt;</a>
            <a href="/index.yeoncheon?menuCd=DOM_000000104011002003&PageNum=<%=pageCount%>" class="page-end"><span class="screen_out">마지막으로</span>&gt;&gt;</a>
            <%
            }
            %>
        </div>
	</div>
</div>
</div>

<%
	}catch(Exception e) {
		out.println(e.getMessage());
	}finally{
		
		try{
			if(conn != null)conn.close();
			if(stmt != null)stmt.close();
			if(pstmt != null)pstmt.close();
			if(rs != null)rs.close();
			if(rs2 != null)rs.close();

		}catch(Exception e2){
			out.println(e2.getMessage());	
		}
	}

%>