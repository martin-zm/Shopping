<%@ page import="dao.ItemsDao" %>
<%@ page import="entity.Items" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/10 0010
  Time: 上午 10:04
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
    <title>products_details</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <script type="text/javascript" src="js/js_frame/lhgcore.js"></script>
    <script type="text/javascript" src="js/js_frame/lhgdialog.js"></script>
    <link href="css/products_details.css" rel="stylesheet" type="text/css">
    <script type="text/javascript">
        function selflog_show(id) {
            var num = document.getElementById("number").value;
            J.dialog.get({id: 'haoyue_creat', title: '购物成功', width: 600, height: 400,
                link: '<%=path%>/servlet/CartServlet?id=' + id + '&num=' + num + '&action=add', cover:true});
        }
        function add() {
            var num = parseInt(document.getElementById("number").value);
            if (num < 100) {
                document.getElementById("number").value = ++num;
            }
        }
        function sub() {
            var num = parseInt(document.getElementById("number").value);
            if (num > 1) {
                document.getElementById("number").value = --num;
            }
        }
    </script>
</head>
<body>
    <h1>商品详情</h1>
    <a href="login.jsp">首页</a> >>> <a href="products_list.jsp">商品列表</a>
    <hr>
    <table align="center" width="750" height="60" cellspacing="0" cellpadding="0" border="0">
       <tr>
           <!-- 商品详情 -->
           <%
               ItemsDao itemDao = new ItemsDao();
               Items item = itemDao.getItemsById(Integer.parseInt(request.getParameter("id")));
               if(item != null) {
           %>
           <td width="70%" valign="top">
               <table>
                   <tr>
                       <td rowspan="5"><img src="images/<%=item.getPicture()%>" width="200" height="160"/></td>
                   </tr>
                   <tr>
                       <td><B><%=item.getName()%></B></td>
                   </tr>
                   <tr>
                       <td>产地：<%=item.getCity()%></td>
                   </tr>
                   <tr>
                       <td>价格： <%=item.getPrice()%>¥</td>
                   </tr>
                   <tr>
                       <td>购买数量：
                           <span id="sub" onclick="sub();">-</span>
                           <input type="text" id="number" name="number" value="1" size="2"/>
                           <span id="add" onclick="add();">+</span>
                       </td>
                   </tr>
               </table>
               <div id="cart">
                   <img src="images/buy_now.png">
                   <a href="javascript:selflog_show(<%=item.getId()%>)">
                       <img src="images/in_cart.png">
                   </a>
                   <a href="servlet/CartServlet?action=show">
                       <img src="images/view_cart.jpg">
                   </a>
               </div>
           </td>
           <%
               }
           %>
           <%
               String list = "";
               //从客户端获得Cookies集合
               Cookie[] cookies = request.getCookies();
               //遍历这个Cookies集合
               if(cookies != null && cookies.length > 0) {
                   for(Cookie c : cookies) {
                       if(c.getName().equals("ListViewCookie")) {
                           list = c.getValue();
                       }
                   }
               }

               list += request.getParameter("id") + ",";
               String[] arr = list.split(",");
               //如果浏览记录超过1000条，清零
               if(arr != null && arr.length > 0) {
                   if (arr.length >= 1000) {
                       list = "";
                   }
               }
                   Cookie cookie = new Cookie("ListViewCookie", list);
                   //若不设置Cookie生命周期，则直到浏览器关闭时，Cookie被删除
                   response.addCookie(cookie);
           %>
           <!-- 浏览过的商品 -->
           <td width="30%" bgcolor="#EEE" align="center">
               <br>
               <b>您浏览过的商品</b><br>
               <!-- 循环开始 -->
               <%
                   ArrayList<Items> itemsList = itemDao.getViewList(list);
                   if(itemsList != null && itemsList.size() > 0) {
                       System.out.println("itemsList.size()" + itemsList.size());
                       for(Items i : itemsList) {
               %>
                    <div>
                        <dl>
                            <dt>
                                <a href="products_details.jsp?id=<%=i.getId() %>">
                                    <img src="images/<%=i.getPicture() %>" width="120" height="90" border="1"/>
                                </a>
                            </dt>
                            <dd class="dd_name"><%=i.getName() %></dd>
                            <dd class="dd_city">产地：<%=i.getCity() %>&nbsp;&nbsp;价格：<%=i.getPrice()%>¥</dd>
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
