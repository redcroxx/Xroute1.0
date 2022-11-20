<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat, java.text.DateFormat" %>
<%
    String from_dt = request.getParameter("from_dt");
    String to_dt = request.getParameter("to_dt");
    String year = from_dt.substring(0,4);
    
    String month = from_dt.substring(5,7);
    
    String day = from_dt.substring(8,10);
    
    Calendar calendar = Calendar.getInstance();
    calendar.set(Integer.parseInt(year),Integer.parseInt(month)-1,Integer.parseInt(day));
    calendar.add(Calendar.DAY_OF_MONTH, -1);
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    String preto_dt = dateFormat.format(calendar.getTime());
    calendar.add(Calendar.MONTH, -1);
    calendar.add(Calendar.DAY_OF_MONTH, 1);
    String prefrom_dt = dateFormat.format(calendar.getTime());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>UbiReport Sample Code</title>
<script language='javascript'>
<!--

   function ObjResize() {
       var objwidth = (self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth);
       var objheight = (self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)- 75;
       document.getElementById("UbiViewer").width = objwidth;
       document.getElementById("UbiViewer").height = objheight;
   }

   function getArg() {

      var args = 'access#from_dt=<%=from_dt%>&to_dt=<%=to_dt%>#gateway#from_dt=<%=from_dt%>&to_dt=<%=to_dt%>#preaccess#from_dt=<%=prefrom_dt%>&to_dt=<%=preto_dt%>#pregateway#from_dt=<%=prefrom_dt%>&to_dt=<%=preto_dt%>#fr_dt#<%=from_dt%>#en_dt#<%=to_dt%>';
      return args;
   }
//-->
</script>
</head>
<body style='margin:0px' onresize="ObjResize()">

<script type="text/javascript">

var objwidth = (self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth);
var objheight = (self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight);

document.write("<object id='UbiViewer' classid='CLSID:256887A3-916F-4C82-86B3-F432BA83097B' width=" + objwidth + " height=" + objheight + ">");
document.write("     <param name='fileURL'        value='http://www.ubireport.com/demo2/ubireport/'>");
document.write("     <param name='servletRootURL' value='http://www.ubireport.com/demo2/ubireport/'>");
document.write("     <param name='servletURL1'    value='http://www.ubireport.com/demo2/UbiForm'>");
document.write("     <param name='servletURL2'    value='http://www.ubireport.com/demo2/UbiData'>");
document.write("     <param name='jrfFileDir'     value='/user/tomcat/webapps/demo2/ubireport/work/'>");
document.write("     <param name='jrfFileName'    value='checkReport.jrf'>");
document.write("     <param name='dataSource'     value=''>");
document.write("     <param name='execType'       value='TYPE4'>");
document.write("     <param name='margin'         value='true'>");
document.write("     <param name='scale'          value='100'>");
document.write("     <param name='progress'       value='true'>");
document.write("     <param name='toolbar'        value='true'>");
document.write("     <param name='fontRevision'   value='true'>");

document.write("     <param name='isDeflater'     value='true'>");
document.write("     <param name='isUnicode'      value='false'>");
document.write("     <param name='isBase64'       value='false'>");
document.write("     <param name='utfData'        value='true'>");
document.write("</object>");

</script>

</body>
</html>