<%@ page import="java.sql.*"%>
<!-- //<%@page import="java.text.DecimalFormat"%> -->
<div class="taxallwrap">
    <div class="two-tabs tc clearfix">
        <a href="/index.yeoncheon?menuCd=DOM_000000104011002001" class="active">세입현황</a>
        <a href="/index.yeoncheon?menuCd=DOM_000000104011002002">세출현황</a>
    </div>
    <div class="tab-content">
        <table class="result-table tc">
            <caption>세입현황 표</caption>
                <colgroup>
                    <col width="40%;"/>
                    <col width="20%;"/>
                    <col width="10%;"/>
                    <col width="10%;"/>
                    <col width="20%;"/>
                </colgroup>
            <thead>
            <tr>
                <th scope="col" rowspan="2">회계구분</th>
                <th scope="col" colspan="3">당일</th>
                <th scope="col">전일</th>
            </tr>
            <tr>
                <th scope="col">수입액</th>
                <th scope="col">과오납<br/>반납액</th>
                <th scope="col">경정액</th>
                <th scope="col">누계액</th>
            </tr>
            </thead>
            
            <tbody>
                <%  
                    // String DB_URL = "jdbc:oracle:thin:@27.101.126.181:34000:LFIS";
                    // String DB_USER = "lfopenapp";
                    // String DB_PASSWORD= "lfopenapp00";
                    
                    int total = 0;
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    
                    
                    try {
                    
                        String sql = "SELECT * FROM( SELECT ROWNUM AS RNUM, Z.* FROM( SELECT * FROM V_FIOS_TBM_REVDESC WHERE DEL_YN = 'Y' AND YMD = TO_CHAR(SYSDATE-1,'YYYYMMDD') )Z )";
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@27.101.126.181:34000:LFIS", "lfopenapp", "lfopenapp00");

                        if (conn == null)
                            throw new Exception("데이터베이스 연결 실패");
                        // DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                        out.println();

                        //객체의 값이 있으면 TRUE
                        while (rs.next()) {
                            String FIS_FG_NM = rs.getString("FIS_FG_NM");
                            int DAY_INC_AMT = rs.getInt("DAY_INC_AMT");
                            int DAY_EXC_RESTO_AMT = rs.getInt("DAY_EXC_RESTO_AMT");
                            int DAY_ACCT_RV_AMT = rs.getInt("DAY_ACCT_RV_AMT");
                            long ACCUM_AMT = rs.getLong("ACCUM_AMT");

                            out.println("<tr>");
                            out.println("<td>" + FIS_FG_NM + "</td>");
                            //DecimalFormat df = new DecimalFormat("#,###");
                            out.println("<td>" + DAY_INC_AMT + "</td>");
                            out.println("<td>" + DAY_EXC_RESTO_AMT + "</td>");
                            out.println("<td>" + DAY_ACCT_RV_AMT + "</td>");
                            out.println("<td>" + ACCUM_AMT + "</td>");
                            out.println("</tr>");
                            total++;
                        }
                    
                %>
            </tbody>
            <p class="total-num" style="padding-top:0;">총 <strong><%=total %></strong>건이 있습니다.</p>
        </table>
        
    </div>
    
</div>

                <%
                    } finally {
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