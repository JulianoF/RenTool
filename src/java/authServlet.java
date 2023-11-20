import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class authServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");// setting the content type
        PrintWriter pw = response.getWriter();// get the stream to write the data

        // writing html in the stream
        pw.println("<html><body>");
        pw.println("Welcome to AUTH SERVLET");
        pw.println("</body></html>");

        String username = request.getParameter("emailInput");
        String password = request.getParameter("passwordInput");

        // Validate username and password (replace with your authentication logic)
        if ("user123@email.com".equals(username) && "password123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }

        pw.close();// closing the stream
    }
}
