<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/12 0012
  Time: 下午 5:11
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
    <title>cart</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
</head>
<body>
    <div align="center">
    <img src="images/add_cart_success.jpg"/>
    <hr>
    <%
        String id = request.getParameter("id");
        String num = request.getParameter("num");
    %>
            您成功购买了<%=num%>件商品编号为<%=id%>的商品&nbsp;&nbsp;&nbsp;&nbsp;
    <br>
    <br>
    <br>
    </div>
</body>
</html>
