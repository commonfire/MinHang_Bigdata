package edu.bupt.jdbc;

import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class SQLHelper {
    // 定义要使用的变量
    private static Connection conn = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;
    private static CallableStatement cs = null;

//	static String drivername="oracle.jdbc.driver.OracleDriver";
//	static String url="jdbc:oracle:thin:@10.108.147.143:1521:orcl";
//	static String username= "bupt";      
//	static String password= "bupt";     
	static String drivername = null;
	static String url = null;
	static String username = null;
	static String password = null;


    public static Connection getConn() {
        return conn;
    }

    public static PreparedStatement getPs() {
        return ps;
    }

    public static ResultSet getRs() {
        return rs;
    }
   
    public static CallableStatement getCs() {
        return cs;
    }

    // 加载驱动，只需要一次
    static {
    	InputStream in = null;
        try {
        	Properties pro = new Properties();	
    		in = SQLHelper.class.getClassLoader().getResourceAsStream("config.properties");
    		pro.load(in);
    		url = pro.getProperty("url");
    		username = pro.getProperty("dbusername");
    		password = pro.getProperty("dbpassword");
    		drivername = pro.getProperty("drivername");
            Class.forName(drivername);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
        	try {
				in.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
    }

    // 得到连接
    public static Connection getConnection() {
        try {
            conn = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    // 执行多个update/delete/insert操作
    public static void executeUpdateMultiParams(String[] sql,String[][] parameters) {
        try {
            // 获得连接
            conn = getConnection();
            // 可能传多条sql语句
            conn.setAutoCommit(false);  //不设置为自动提交
            for (int i = 0; i < sql.length; i++) {
                if (parameters[i] != null) {
                    ps = conn.prepareStatement(sql[i]);
                    for (int j = 0; j < parameters[i].length; j++)
                        ps.setString(j + 1, parameters[i][j]);
                }
                ps.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                conn.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            throw new RuntimeException(e.getMessage());
        } finally {
            // 关闭资源
            close(rs, ps, conn);
        }
    }

    // 执行单个update/delete/insert操作
    // sql格式如:UPDATE tablename SET columnn = ? WHERE column = ?
    public static void executeUpdate(String sql, String[] parameters) {
        try {
            // 1.创建一个ps
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            // 给占位符？赋值
            if (parameters != null)
                for (int i = 0; i < parameters.length; i++) {
                    ps.setString(i + 1, parameters[i]);
                }
            // 执行
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();// 
            throw new RuntimeException(e.getMessage());
        } finally {
            // 关闭资源
            close(rs, ps, conn);
        }
    }
    
    // 执行单个update/delete/insert操作
    // sql格式如:UPDATE tablename SET columnn = ? WHERE column = ?
    public static void executeUpdate(String[] parameters,Connection conn,PreparedStatement ps) {
        try {
            // 给占位符？赋值
            if (parameters != null)
                for (int i = 0; i < parameters.length; i++) {
                    ps.setString(i + 1, parameters[i]);
                }
            // 执行
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();// 
            throw new RuntimeException(e.getMessage());
        } finally {
            // 关闭资源
        }
    }

    // 执行单个select操作
    public static ResultSet executeQuery(String sql, String[] parameters,Connection conn) throws SQLException {      
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            if (parameters != null) {
                for (int i = 0; i < parameters.length; i++) {
                    ps.setString(i + 1, parameters[i]);                  
                }
            }
            rs = ps.executeQuery();         
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage()); 
        } finally {
        	//此处不能在内部关闭 close(rs, ps, conn)，会报异常。由于已经关闭了，返回给外界的ResultSet无法调用。可以采用传入Connection对象，在外界关闭。也可以采用数据库连接池
        }
        return rs;
   }
    
    public static int executeQuery1(String sql,String[] parameters,Connection conn,String column) throws SQLException {      
        ResultSet rs = null;
        PreparedStatement ps = null;
        int result = 0;
        try {
        	ps = conn.prepareStatement(sql);
            if (parameters != null) {
                for (int i = 0; i < parameters.length; i++) {
                    ps.setString(i + 1, parameters[i]);                  
                }
            }
            rs = ps.executeQuery();  
            rs.next();
            result = rs.getInt(column);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage()); 
        } finally {
        	rs.close();
        	ps.close();
        }
        return result;
   }

    
    // 调用无返回值存储过程
    // 格式： call procedureName(parameters list)
    public static void callProc(String sql, String[] parameters) {
        try {
            conn = getConnection();
            cs = conn.prepareCall(sql);
            // 给？赋值
            if (parameters != null) {
                for (int i = 0; i < parameters.length; i++)
                    cs.setObject(i + 1, parameters[i]);
            }
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            // 关闭资源
            close(rs, cs, conn);
        }
    }

    // 调用带有输入参数且有返回值的存储过程
    public static CallableStatement callProcInput(String sql, String[] inparameters) {
        try {
            conn = getConnection();
            cs = conn.prepareCall(sql);
            if(inparameters!=null)
                for(int i=0;i<inparameters.length;i++)
                    cs.setObject(i+1, inparameters[i]);               
            cs.execute();
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally{
        }
        return cs;
    }
   
    // 调用有返回值的存储过程
    public static CallableStatement callProcOutput(String sql,Integer[] outparameters) {
        try {
            conn = getConnection();
            cs = conn.prepareCall(sql);                   
            //给out参数赋值
            if(outparameters!=null)
                for(int i=0;i<outparameters.length;i++)
                    cs.registerOutParameter(i+1, outparameters[i]);
            cs.execute();
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally{
        }
        return cs;
    }

   
    
    //关闭数据库连接，释放资源
    public static void close(ResultSet rs, Statement ps, Connection conn) {
        if (rs != null)
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        rs = null;
        if (ps != null)
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        ps = null;
        if (conn != null)
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        conn = null;
    }
    
    public static void main(String[] args) throws SQLException{
//    	 Connection conn = SQLHelper.getConnection();

    	
    }
}