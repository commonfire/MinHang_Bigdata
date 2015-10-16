<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<table>
	<tr>
		<td valign="baseline" nowrap>第<%=intPage%>页&nbsp; 共<%=intPageCount%>页&nbsp;共<%=intRowCount%>条&nbsp;</td>
		<%if(intPageCount>1) {%>
		<td valign="baseline" nowrap><a href="#" onClick="GoTo('<%=page_url%>','<%=1%>')">首页</a></td>
		<td valign="baseline" nowrap><a href="#" onClick="GoTo('<%=page_url%>','<%=intPage-1%>')">上一页</a></td>
		<td valign="baseline" nowrap><a href="#" onClick="GoTo('<%=page_url%>','<%=intPage+1>intPageCount?intPageCount:intPage+1%>')">下一页</a></td>
		<td valign="baseline" nowrap><a href="#" onClick="GoTo('<%=page_url%>','<%=intPageCount%>')">尾页</a></td>
		<td valign="baseline" nowrap>跳到<input type="text" name="page" size="4" style="font-size:12px" value="<%=intPage%>">&nbsp;页<input type="button" name="btnGO" size="4" value="GO" onClick="javascript:GoTo('<%=page_url%>');" style="border:1 solid;background-color:#e0f0ff"></td>
		<%}%>
	</tr>
</table>