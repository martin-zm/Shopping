<%@ page import="dao.ItemsDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Items" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/31 0031
  Time: 上午 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>products_list</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link href="css/products_list.css" rel="stylesheet" type="text/css">
</head>
<body>
    <h1>商品列表</h1>
    <hr />

    <table width="750" height="60" cellpadding="0" cellspacing="0" border="0" align="center">
        <tr>
            <td>
               <!-- 商品循环开始 -->
                <%
                    ItemsDao itemsDao = new ItemsDao();
                    ArrayList<Items> list = itemsDao.getAllItems();
                    if (list != null && list.size() > 0) {
                        for(Items item : list) {
                %>
                <div>
                   <dl>
                       <dt>
                           <a href="products_details.jsp?id=<%=item.getId()%>">
                               <img src="images/<%=item.getPicture()%>" width="120" height="90" border="1"/>
                           </a>
                       </dt>
                       <dd class="dd_name"><%=item.getName()%></dd>
                       <dd class="dd_city">产地:<%=item.getCity() %>&nbsp;&nbsp;价格:¥<%=item.getPrice()%></dd>
                   </dl>
                </div>
                <%
                        }
                    }
                %>
            </td>
        </tr>
    </table>
</body>
</html>
