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
<%@ page import="java.net.URLEncoder" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
    String loginUser = request.getParameter("loginUser");
    String loginPassword = request.getParameter("loginPassword");

    //创建一个数据库连接
    Connection con = null;
    //创建预编译语句对象
    PreparedStatement stmt = null;
    //创建一个结果集对象
    ResultSet rs = null;
    //标记是否注册成功
    boolean isValide = false;

    try {
        //获取连接
        con = DBHelper.getConnection();
        if (con != null) {
            System.out.println("数据库连接成功");
        }
        //预编译语句，"?"代表参数
        String sql = "SELECT * FROM users WHERE USERNAME=? AND PASSWORD=?";
        stmt = con.prepareStatement(sql);
        //设置参数
        stmt.setString(1, loginUser);
        //实例化预编译语句
        stmt.setString(2, loginPassword);
        //执行查询
        rs = stmt.executeQuery();
        //判断结果集是否有记录，并将指针向后移动一位
        if (rs.next()) {
            isValide = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        //释放数据集对象
        if (rs != null) {
            try {
                rs.close();
                rs = null;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        //释放语句对象
        if (stmt != null) {
            try {
                stmt.close();
                stmt = null;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    //设置Cookies
    request.setCharacterEncoding("utf-8");
    //首先判断用户是否选择了记住登录状态
    String[] isUseCookies = request.getParameterValues("isUseCookie");
    if (isUseCookies != null && isUseCookies.length > 0) {
        //把用户名和密码保存在Cookie对象里面
        String userName = URLEncoder.encode(request.getParameter("loginUser"), "utf-8");
        String userPassword = URLEncoder.encode(request.getParameter("loginPassword"), "utf-8");
        Cookie userNameCookie = new Cookie("loginUser", userName);
        Cookie userPasswordCookie = new Cookie("loginPassword", userPassword);
        userNameCookie.setMaxAge(864000);
        userPasswordCookie.setMaxAge(864000);
        response.addCookie(userNameCookie);
        response.addCookie(userPasswordCookie);
    } else {
        Cookie[] cookies = request.getCookies();
        if (cookies != null && cookies.length > 0) {
            for (Cookie c : cookies) {
                if (c.getName().equals("loginUser") || c.getName().equals("loginPassword")) {
                    c.setMaxAge(0);
                    response.addCookie(c);
                }
            }
        }
    }

    if (isValide == true) {
        System.out.println("登录成功！");
        response.sendRedirect("products_list.jsp");
    } else {
        System.out.println("用户不存在");
        response.sendRedirect("login.jsp");
    }
%>

