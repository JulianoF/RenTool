import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class dbConnector {

    public static Connection getConnection() throws SQLException {
        try {
            Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/rentoolDB");
			
			return ds.getConnection();
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection error: " + e.getMessage());
        }
    }


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