package dao;

import entity.Items;
import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by Administrator on 2017/4/5 0005.
 */
//商品的业务逻辑类
public class ItemsDao {

    //获得所有的商品信息
    public ArrayList<Items> getAllItems() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Items>  list = new ArrayList<Items>();    //商品集合
        try {
            conn = DBHelper.getConnection();
            String sql = "SELECT * FROM items;";           //SQL语句
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Items item = new Items();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setCity(rs.getString("city"));
                item.setNumber(rs.getInt("number"));
                item.setPrice(rs.getInt("price"));
                item.setPicture(rs.getString("picture"));
                list.add(item);    //把一个商品加入集合
            }
            return list;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
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
            if(stmt != null) {
                try {
                    stmt.close();
                    stmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
    //根据商品编号获得商品信息
    public Items getItemsById(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.getConnection();
            String sql = "SELECT * FROM items WHERE id=?;";           //SQL语句
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Items item = new Items();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setCity(rs.getString("city"));
                item.setNumber(rs.getInt("number"));
                item.setPrice(rs.getInt("price"));
                item.setPicture(rs.getString("picture"));
                return item;
            } else {
                return null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
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
            if(stmt != null) {
                try {
                    stmt.close();
                    stmt = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    //获取最近浏览的前五条商品信息
    public ArrayList<Items> getViewList(String list) {
        System.out.println("list:" + list);
        ArrayList<Items> itemsList = new ArrayList<Items>();
        //每次返回前五条记录
        int iCount = 5;
        if(list != null && list.length() > 0) {
            String[] arr = list.split(",");
            System.out.println("arr.length=" + arr.length);
            //如果商品记录大于等于5条
            if(arr.length >= 5) {
                for(int i = arr.length - 1; i >= arr.length - iCount; i--) {
                    itemsList.add(getItemsById(Integer.parseInt(arr[i])));
                }
            } else {
                for(int i = arr.length - 1; i >= 0; i--) {
                    itemsList.add(getItemsById(Integer.parseInt(arr[i])));
                }
            }
            return itemsList;
        } else {
            return null;
        }
    }
}
