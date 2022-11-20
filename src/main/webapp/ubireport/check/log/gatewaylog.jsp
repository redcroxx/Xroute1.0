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
            String filenm = logPath + "/ubigateway.log" + result[i];
            File logfile = new File(filenm);
            if(logfile.exists()) {
                BufferedReader br = new BufferedReader(new FileReader(logfile));
                ArrayList errlist = new ArrayList();
                while((readStr = br.readLine()) != null) {
                    int idx1 = readStr.indexOf("[");
                    int idx2 = readStr.indexOf("]");
                    String info = "";
                    String servletnm = "";
                    String dt = "";
                    if( idx1 >=0) {
                        info = readStr.substring(idx1+1,idx2);
                        if(info.length() == 1 ) {
                            if(info.equals("E")) {
                                readStr = readStr.substring(idx2 + 1);
                                idx1 = readStr.indexOf("[");
                                idx2 = readStr.indexOf("]");
                                servletnm = readStr.substring(idx1+1,idx2);
                                readStr = readStr.substring(idx2+1);
                                idx1 = readStr.indexOf("[");
                                idx2 = readStr.indexOf("]");
                                dt = readStr.substring(idx1+1,idx2);

                                errlist.add(dt);
                            }
                        }
                    }
                }
                // 중복 날짜 시간제거
                ArrayList newlist = new ArrayList();
                for(int j = 0 ; j < errlist.size() ; j++) {
                    if( ! newlist.contains(errlist.get(j).toString()) ) {
                        newlist.add(errlist.get(j));
                    }
                }
                int totalcnt = newlist.size();
                if(result[i].equals("")) {
                    rtnStr.append(nowdt + "^t" + totalcnt +"^t^n");
                } else {
                    rtnStr.append(result[i].substring(1) + "^t" + totalcnt +"^t^n");
                }
                br.close();
            } else {
                if(result[i].equals("")) {
                    rtnStr.append(nowdt + "^t0^t^n");
                } else {
                    rtnStr.append(result[i].substring(1) + "^t0^t^n");
                }
            }
        }
        out.print(rtnStr.toString());
    }
    catch (Exception ex)
    {
        ex.printStackTrace();
    }
%>

