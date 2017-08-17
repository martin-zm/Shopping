<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/12 0012
  Time: 下午 8:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>failure</title>
    <base href="<%=basePath%>">
</head>
<body>
    <div align="center">
        <img src="images/add_cart_failure.jpg" align="middle"/>
    </div>
    <hr>

    <br>
    <br>
    <br>
</body>
</html>
