<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%try{%>
<%if (((String)session.getAttribute("qx")).equals(null) || ((String)session.getAttribute("qx")).equals("")){%>
	<script  language=javascript>
		alert("登陆超时，请您重新登陆！");
		parent.window.location.href="default.jsp";
	</script>
<%}%>
<%}catch(Exception e){%>
	<script  language=javascript>
		alert("登陆超时，请您重新登陆！");
		parent.window.location.href="default.jsp";
	</script>
<%}%>