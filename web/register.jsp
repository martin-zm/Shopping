<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/29 0029
  Time: 上午 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>register</title>
    <base href="<%=basePath%>">
    <link type="text/css" href="css/register.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/register.js"></script>

</head>
<body>
    <div id="register">
      <h1>注册</h1>
      <form name="regform" action="servlet/RegisterActionServlet" method="post" onsubmit="return checkUser()">
        <input type="text" required= "requied" placeholder="用户名" name="regUserName" />
        <input type="password" required= "requied" placeholder="密码" name="regPassword" />
        <input type="password" required= "requied" placeholder="确认密码" name="confirmPassword" />
        <input class="registerbutton" type="submit" value="注册" />
      </form>
    </div>
</body>
</html>
