package DBContext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;


public class DBContext {

    ResourceBundle resourceBundle = ResourceBundle.getBundle("db");
    private final String jdbcURL = resourceBundle.getString("url");
    private final String jdbcUsername = resourceBundle.getString("username");
    private final String jdbcPassword = resourceBundle.getString("password");

    public Connection getConnection(){
        Connection connection = null;
        try{
            Class.forName(resourceBundle.getString("driverName"));
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        }catch(SQLException | ClassNotFoundException e){
            e.printStackTrace();
        }
        return connection;

    }
}
