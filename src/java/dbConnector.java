import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConnector {

    private static final String JDBC_URL = "jdbc:mysql://rentool_db:3306/rentool";
    private static final String USERNAME = "username";
    private static final String PASSWORD = "password";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection error: " + e.getMessage());
        }
    }

    // Optional: method to close the connection
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                // Handle or log the exception
                e.printStackTrace();
            }
        }
    }
}