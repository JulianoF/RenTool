import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;
import java.net.*;
import javax.naming.*;

import org.json.JSONArray;
import org.json.JSONObject;


public class creationServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String email = request.getParameter("email");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String password = request.getParameter("password");
        String country = request.getParameter("country");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String postal = request.getParameter("postal");
        

        String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?address="
        + URLEncoder.encode(postal + ", " + province + ", " + country, "UTF-8")
        + "&key=";
        try {
            Context ctx = new InitialContext();
            apiUrl += ((String) ctx.lookup("java:/comp/env/googleMapsApiKey"));
        } catch (NamingException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }

        // Make the API request
        URL url = new URL(apiUrl);
        HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
        urlConnection.setRequestMethod("GET");

        // Read the response
        BufferedReader reader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
        StringBuilder urlResponse = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            urlResponse.append(line);
        }
        reader.close();
        urlConnection.disconnect();
        double latitude =44.0;
        double longitude =-79.0;
        // Parse the JSON response to extract latitude and longitude
        JSONObject jsonResponse = new JSONObject(urlResponse.toString());
        JSONArray results = jsonResponse.getJSONArray("results");
        if (results.length() > 0) {
            JSONObject location = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("location");
            latitude = location.getDouble("lat");
            longitude = location.getDouble("lng");
        }
        
        try {
            Context ctx = new InitialContext();
            Connection connection = dbConnector.getConnection();


            String sql = "INSERT INTO users (Email, FirstName, LastName, Password, Country, Province, City, PostalCode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, email);
                pstmt.setString(2, fname);
                pstmt.setString(3, lname);
                pstmt.setString(4, password);
                pstmt.setString(5, country);
                pstmt.setString(6, province);
                pstmt.setString(7, city);
                pstmt.setString(8, postal);

                // Execute the query
                int rowsAffected = pstmt.executeUpdate();
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int userID = generatedKeys.getInt(1);
        
                        // Insert location
                        String insertLocationQuery = "INSERT INTO location (UserID_Location, latitude, longitude) VALUES (?, ?, ?)";
                        try (PreparedStatement locationStatement = connection.prepareStatement(insertLocationQuery)) {
                            locationStatement.setInt(1, userID);
                            locationStatement.setDouble(2, latitude);
                            locationStatement.setDouble(3, longitude);
                            locationStatement.executeUpdate();
                        }
                    }
                }

                if (rowsAffected > 0) {
                    response.sendRedirect("login.jsp");
                } else {
                    response.sendRedirect("accCreation.jsp");
                }

                 // Close the connection using the DatabaseHandler method
                dbConnector.closeConnection(connection);
            }
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
        pw.close();// closing the stream
    }
}
