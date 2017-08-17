package servlet;

import dao.ItemsDao;
import entity.Cart;
import entity.Items;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2017/4/12 0012.
 */
@WebServlet(name = "CartServlet")
public class CartServlet extends HttpServlet {

    private String action; //表示购物车的动作， add, show, delete
    private ItemsDao idao = new ItemsDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
//      PrintWriter out = response.getWriter();
        if (request.getParameter("action") != null) {
            action = request.getParameter("action");
            //如果是添加商品进购物车
            if (action.equals("add")) {
                if (addToCart(request, response)) {
                    request.getRequestDispatcher("/success.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/failure.jsp").forward(request, response);
                }
            }
            //如果是显示购物车
            if (action.equals("show")) {
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
            }
            //如果是执行删除购物车中的商品
            if(action.equals("delete")) {
               if (deleteFromCart(request, response)) {
                   request.getRequestDispatcher("/cart.jsp").forward(request, response);
               } else {
                   request.getRequestDispatcher("/cart.jsp").forward(request, response);
               }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    //添加商品进购物车的方法
    private boolean addToCart(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String number = request.getParameter("num");
        Items item = idao.getItemsById(Integer.parseInt(id));

        //是否是第一次给购物车添加商品，要给session中创建一个新的购物车对象
        if (request.getSession().getAttribute("cart") == null) {
            Cart cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart.addGoodsInCart(item, Integer.parseInt(number))) {
            return true;
        } else {
            return false;
        }
    }

    //从购物车删除商品
    private boolean deleteFromCart(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        Cart cart = (Cart)request.getSession().getAttribute("cart");
        Items item = idao.getItemsById(Integer.parseInt(id));
        if(cart.removeGoodsFromCart(item)) {
            return true;
        } else {
            return false;
        }
    }
}
