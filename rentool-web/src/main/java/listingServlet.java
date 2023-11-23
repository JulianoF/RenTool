import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;

import com.google.protobuf.Descriptors.Descriptor;

import java.sql.PreparedStatement;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;
import javax.naming.*;

public class listingServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html");// setting the content type
        PrintWriter pw = res.getWriter();// get the stream to write the data

        HttpSession session = req.getSession();

        InputStream inputStream = null; 
        Part filePart = req.getPart("productPhoto");

        if(filePart != null){
            inputStream = filePart.getInputStream();
        }

        int userID = (int) session.getAttribute("UserID");
        int itemID;
        String itemName = req.getParameter("itemName");
        String itemCondition = req.getParameter("itemCondition");
        String description = req.getParameter("description");
        String rentalPrice = req.getParameter("rentalPrice");
        String dateListed = req.getParameter("dateListed");
        String inUseS = req.getParameter("inUse");
        int inUse = 0;
        if(inUseS != null){
            if(inUseS.equals("on") ){
                inUse = 1;
            }     
        }

        try {
            Connection connection = dbConnector.getConnection();

            String sql = "INSERT INTO items (UserID, ItemName, ItemCondition,RentalPrice,Description,ProductImage) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt1 = connection.prepareStatement(sql)) {
                pstmt1.setInt(1, userID);
                pstmt1.setString(2, itemName);
                pstmt1.setString(3, itemCondition);
                pstmt1.setString(4, rentalPrice);
                pstmt1.setString(5, description);
                if (inputStream != null) {
                    // fetches input stream of the upload file for the blob column
                    pstmt1.setBlob(6, inputStream);
                }
                // Execute the query
                int rowsAffected = pstmt1.executeUpdate();

                if (rowsAffected <= 0) {
                    res.sendRedirect("createListing.jsp");
                }
            }

            String sql2 = "SELECT ItemID FROM items WHERE UserID =? AND ItemName=?";
            try (PreparedStatement pstmt2 = connection.prepareStatement(sql2)) {
                pstmt2.setInt(1, userID);
                pstmt2.setString(2, itemName);

                ResultSet resultSet = pstmt2.executeQuery();
                if(resultSet.next()){
                   itemID = resultSet.getInt("ItemID"); 
                }
                else{
                    itemID = -1;
                }
            }

            String sql3 = "INSERT INTO listing (ItemID,UserID_Listing,DateListed,InUse) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pstmt3 = connection.prepareStatement(sql3)) {
                pstmt3.setInt(1, itemID);
                pstmt3.setInt(2, userID);
                pstmt3.setString(3, dateListed);
                pstmt3.setInt(4, inUse);
                
                // Execute the query
                int rowsAffected = pstmt3.executeUpdate();

                if (rowsAffected > 0) {
                    res.sendRedirect("index.jsp");
                }else{
                    res.sendRedirect("createListing.jsp");
                }
            }
        // Close the connection using the DatabaseHandler method
        dbConnector.closeConnection(connection);
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }


        pw.close();// closing the stream
    }
}