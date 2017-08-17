<%@ page import="entity.Cart" %>
<%@ page import="entity.Items" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/12 0012
  Time: 下午 8:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>购物车</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link type="text/css" rel="stylesheet" href="css/cart.css" />
    <script language="javascript">
        function delcfm() {
           if (!confirm("确认要删除？ ")) {
               window.event.returnValue = false;
           }
        }
    </script>
</head>
<body>
    <h1>我的购物车</h1>
    <a href="login.jsp">首页</a> >>> <a href="products_list.jsp">商品列表</a>
    <hr>
    <div id="shopping">
        <form >
            <table>
                <tr>
                    <th>商品名称</th>
                    <th>商品单价</th>
                    <th>商品价格</th>
                    <th>购买数量</th>
                    <th>操作</th>
                </tr>
                <%
                    //首先判断session中是否有购物车对象
                    if(request.getSession().getAttribute("cart") != null) {
                        Cart cart = (Cart)request.getSession().getAttribute("cart");
                        HashMap<Items, Integer> goods = cart.getGoods();
                        Set<Items> items = goods.keySet();
                        Iterator<Items> it = items.iterator();

                        while(it.hasNext()) {
                            Items i = it.next();
                %>
                <tr name="products" id="product_id_1">
                    <td class="thumb">
                        <img src="images/<%=i.getPicture()%>" />
                        <a href=""><%=i.getName()%></a>
                    </td>
                    <td class="number">
                        <%=i.getPrice()%>
                    </td>
                    <td class="price" id="price_id_1">
                        <%=i.getPrice() * goods.get(i)%>
                    </td>
                    <td class="number">
                        <span><%=goods.get(i)%></span>
                        <input type="hidden" value=""/>
                    </td>
                    <td class="delete">
                        <a href="servlet/CartServlet?action=delete&id=<%=i.getId()%>" onclick="delcfm();">删除</a>
                    </td>
                </tr>
                <%
                        }
                %>
            </table>
            <div class="total">
               <span id="total">
                   总计：<%=cart.getTotalPrice() %>¥
               </span>
            </div>
            <%
                }
            %>
            <div class="button"><input type="submit" value="提交"/></div>
        </form>
    </div>
</body>
</html>
