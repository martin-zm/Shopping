package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import util.DBHelper;

/**
 * Created by Administrator on 2017/4/5 0005.
 */
@WebServlet(name = "RegisterActionServlet")
public class RegisterActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String regUserName = request.getParameter("regUserName");
        String regPassword = request.getParameter("regPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        System.out.println(regUserName);
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
            String sql = "SELECT * FROM users WHERE USERNAME = ?";
            //实例化预编译语句
            stmt = con.prepareStatement(sql);
            //设置参数
            stmt.setString(1, regUserName);
            //执行查询
            rs = stmt.executeQuery();
            //判断结果集是否有记录，并将指针向后移动一位
            if (!rs.next()) {
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
        if (isValide == true) {
            System.out.println("注册成功！请登录");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            System.out.println("用户名已经存在！");
            response.sendRedirect(request.getContextPath() + "/register.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
