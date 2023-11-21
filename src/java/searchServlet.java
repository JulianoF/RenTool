import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class searchServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html");// setting the content type
        PrintWriter pw = res.getWriter();// get the stream to write the data

        String searchQuery = req.getParameter("searchField");

        // SQL CODE HERE
  
        req.setAttribute("resultMessage", searchQuery);

        RequestDispatcher dispatcher = req.getRequestDispatcher("searchResults.jsp");
        dispatcher.forward(req, res);

        pw.close();// closing the stream
    }
}