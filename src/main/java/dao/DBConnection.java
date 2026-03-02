package dao;
import java.sql.*;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String host     = getEnv("MYSQLHOST",     "localhost");
            String port     = getEnv("MYSQLPORT",     "3306");
            String database = getEnv("MYSQLDATABASE", "jee_blog");
            String user     = getEnv("MYSQLUSER",     "root");
            String password = getEnv("MYSQLPASSWORD", "");
            String url = "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true";
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver introuvable", e);
        }
    }
    private static String getEnv(String key, String def) {
        String v = System.getenv(key);
        return (v != null && !v.isEmpty()) ? v : def;
    }
}