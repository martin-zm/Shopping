<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/29 0029
  Time: 上午 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBHelper" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"+request.getServerName() + ":"+request.getServerPort() + path + "/";
%>
<%
    String regUserName = request.getParameter("regUserName");
    String regPassword = request.getParameter("regPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    //创建一个数据库连接
    Connection con = null;
    //创建预编译语句对象
    PreparedStatement stmt = null;
    //创建一个结果集对象
    ResultSet rs = null;
    //标记是否注册成功
    boolean isValide = false;

    try{
        //获取连接
        con = DBHelper.getConnection();
        if(con != null) {
            System.out.println("数据库连接成功");
        }
        //预编译语句，"?"代表参数
        String sql = "SELECT * FROM users WHERE USERNAME = ?";
        //实例化预编译语句
        stmt = con.prepareStatement(sql);
        //设置参数
        stmt.setString(1, regUserName);
        //执行查询
        rs = stmt.executeQuery();
        //判断结果集是否有记录，并将指针向后移动一位
        if(!rs.next()) {
            sql = "INSERT INTO users(USERNAME,PASSWORD) VALUES(?,?)";
            stmt = con.prepareStatement(sql);
            stmt.setString(1, regUserName);
            stmt.setString(2, regPassword);
            stmt.executeUpdate();
            isValide = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        //释放数据集对象
        if (rs != null) {
            try{
                rs.close();
                rs = null;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        //释放语句对象
        if (stmt != null) {
            try{
                stmt.close();
                stmt = null;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    if(isValide == true) {
        System.out.println("注册成功！请登录");
        response.sendRedirect("login.jsp");
    } else {
        System.out.println("用户名已经存在！");
        response.sendRedirect("register.jsp");
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>注册成功！</h1>
</body>
</html>
