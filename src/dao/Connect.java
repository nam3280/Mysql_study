package dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class Connect {
    private Connection connection = null;

    public boolean setConnection(Connection con) {
        try {
            Properties prop = new Properties();
            prop.load(new FileInputStream("/Users/nam-yunho/study/Board/src/db.properties"));

            String url = prop.getProperty("url");
            String id = prop.getProperty("id");
            String password = prop.getProperty("password");

            con = DriverManager.getConnection(url,id,password);
        } catch (SQLException | IOException e) {
            return false;
        }
        this.connection = con;
        return true;
    }

    public Connection getConnection(){
        return this.connection;
    }
}

