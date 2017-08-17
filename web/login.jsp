<%@ page import="java.net.URLDecoder" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/26 0026
  Time: 上午 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="utf-8">
    <!-- page title -->
    <title>login</title>
    <base href="<%=basePath%>">
    <!-- end of page title -->
    <!-- libraries -->
    <link type="text/css" href="css/login.css" rel="stylesheet"/>
    <!-- end of libraries -->

    <script type="text/javascript">
        function reloadCode(){
            var time = new Date().getTime();
            document.getElementById("imageCode").src="servlet/ImageServlet?d="+time;
        }
    </script>
</head>
<body>
<div id="login">
    <h1>登录</h1>
    <%
        request.setCharacterEncoding("utf-8");
        String userName = "";
        String userPassword = "";
        Cookie[] cookies = request.getCookies();
        if(cookies != null && cookies.length > 0) {
            for(Cookie c : cookies) {
                if(c.getName().equals("loginUser")) {
                    userName = URLDecoder.decode(c.getValue(), "utf-8");
                }
                if(c.getName().equals("loginPassword")) {
                    userPassword = URLDecoder.decode(c.getValue(), "utf-8");
                }
            }
        }
    %>
    <form action="servlet/LoginActionServlet"  method="post">
        <input type="text" required="required" placeholder="用 户 名" name="loginUser" value="<%=userName%>" id="input1"/>
        <input type="password" required="required" placeholder="密 码" name="loginPassword" value="<%=userPassword%>" id="input2"/>
        <div id="checkCode">
            <input type="text" required="required" placeholder="验 证 码" name="checkCode" id="input3"/>
            &nbsp;&nbsp;&nbsp;
            <image alt="验证码" id="imageCode" src="servlet/ImageServlet"/>
            <div id="changeCheckCode">
                <a href="javascript: reloadCode();" style="color: #f9fff3;">看不清</a>
            </div>
        </div>
        <button class="loginbutton" type="submit">登录</button>
        <div id="checkdiv">
            <label for="check">记住我</label>
            <input type="checkbox" id="check" checked="checked" name="isUseCookie"/>
        </div>
        <div id="register">
            <a href="register.jsp" style="color: #f9fff3;">注册</a>
        </div>
    </form>
</div>
</body>
</html>
