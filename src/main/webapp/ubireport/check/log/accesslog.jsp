<%@ page contentType="text/html; charset=euc-kr" %><%@ page import="java.net.*,java.util.*,java.io.*,java.text.SimpleDateFormat" %><%
    String from_dt = request.getParameter("from_dt");
    String to_dt = request.getParameter("to_dt");
    StringBuffer rtnStr = new StringBuffer();
    String logPath = "/user/tomcat/webapps/demo2/ubireport/logs/";
    String readStr = "";
    try
    {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date now = new Date();
        String nowdt = dateFormat.format(now);
        
        if(from_dt == null) {
            from_dt = nowdt;
        }
        if(to_dt == null) {
            to_dt = nowdt;
        }

        Calendar calDiff = Calendar.getInstance();
        calDiff.setTime(dateFormat.parse(from_dt));

        //두 날자 사이의 일수
        int iDTCnt = (int)((dateFormat.parse(to_dt).getTime() - dateFormat.parse(from_dt).getTime()) / 1000 / 60 / 60 / 24);

        // 시작일부터
        calDiff.add(Calendar.DATE, -1);

        // 데이터 저장
        ArrayList list = new ArrayList();

        for (int i = 0; i <= iDTCnt; i++) {
            calDiff.add(Calendar.DATE, 1);
            if(nowdt.equals(dateFormat.format(calDiff.getTime()))) {
                list.add("");
            } else {
                list.add("." + dateFormat.format(calDiff.getTime()));
            }
        }
        
        String[] result = new String[list.size()];
        list.toArray(result);
        for(int i = 0; i < result.length; i++) {
            String filenm = logPath + "/ubiaccess.log" + result[i];
            File logfile = new File(filenm);
            int totalcnt = 0;
            
            if(logfile.exists()) {
                BufferedReader br = new BufferedReader(new FileReader(logfile));
                while((readStr = br.readLine()) != null) {
                    totalcnt += 1;
                }
                br.close();
            }

            if(result[i].equals("")) {
                rtnStr.append(nowdt + "^t" + totalcnt +"^t^n");
            } else {
                rtnStr.append(result[i].substring(1) + "^t" + totalcnt +"^t^n");
            }
            //out.print(result[i].substring(1));
        }
        out.print(rtnStr.toString());
    }
    catch (Exception ex)
    {
        ex.printStackTrace();
    }
%>