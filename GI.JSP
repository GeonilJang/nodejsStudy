<%@ page import="java.sql.*"%>

<div class="taxallwrap">
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
                            String DB_URL = "";
                            String DB_USER = "";
                            String DB_PASSWORD= "";
                            Connection conn;
                            Statement stmt = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            ResultSet rs2 = null;
                            try {
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                                //String PageNum_temp = request.getParameter("PageNum"); //PageNum_temp 문자열 생성해서 PageNum 파라미터값 받음
                               // if (PageNum_temp == null)
                                    //PageNum_temp = "1"; //만약 값이 NULL값이면 초기값을 1페이지로 세팅
                                //int PageNum = Integer.parseInt(PageNum_temp); //그 값을 PageNum에 대입
                                //int PagePerNum = 10; //페이지당 게시물 갯수 
                               // int totalData = 0; //전체 행의 갯수
                                stmt = conn.createStatement();  

                                String sql = "SELECT * FROM V_FIOS_TBM_TECURRAMT  WHERE ROWNUM <= 10";
                                <!--
                                String total = "SELECT COUNT(FIS_YEAR) FROM V_FIOS_TBM_TECURRAMT"; //전체 행의 갯수 구하는 쿼리문
                                -->
                                if (conn == null)
                                    throw new Exception("데이터베이스 연결 실패");
                                // DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)   
                                pstmt = conn.prepareStatement(sql);
                                stmt = 

                                rs = pstmt.executeQuery();  
                                <!--rs2 = stmt.executeQuery(total);
                                out.print(total);   -->
                                while (rs.next()) {
                                    String FIS_YEAR = rs.getString(1);
                                    String FIS_FG_NM = rs.getString(3);
                                    String DEPT_NM = rs.getString(5);
                                    String DBIZ_NM = rs.getString(9);
                                    String TE_MNG_MOK_CD = rs.getString(10);
                                    String TE_MNG_MOK_NM = rs.getString(11);
                                    String EXPD_RESOL_AMT = rs.getString(13);
                                    String PAY_CMD_YMD = rs.getString(14);
                                    String BIZ_START_YMD = rs.getString(20);
                                    String BIZ_END_YMD = rs.getString(21);
                                    String GOV_OFFICE_NM = rs.getString(22);

                                    out.println("<tr>");
                                    out.println("<td>" + FIS_YEAR + "</td>");
                                    out.println("<td>" + FIS_FG_NM + "</td>");
                                    out.println("<td>" + DEPT_NM + "</td>");
                                    out.println("<td>" + DBIZ_NM + "</td>");
                                    out.println("<td>" + TE_MNG_MOK_CD + "</td>");
                                    out.println("<td>" + TE_MNG_MOK_NM + "</td>");
                                    out.println("<td>" + EXPD_RESOL_AMT + "</td>");
                                    out.println("<td>" + PAY_CMD_YMD + "</td>");
                                    out.println("<td>" + BIZ_START_YMD + "</td>");
                                    out.println("<td>" + BIZ_END_YMD + "</td>");
                                    out.println("<td>" + GOV_OFFICE_NM + "</td>");
                                    out.println("</tr>");
                                }


                                pstmt.close();
                                <!--stmt.close();-->
                                conn.close();
                                


                            } catch(Exception e) {
                                out.println(e.getMessage());
                            }
                        %>


                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>