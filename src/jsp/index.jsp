<%@ page language="java" contentType="text/html"%>

<!DOCTYPE html>
<html>
<body>
 
    <% out.print(2*5); %> 
    <% out.print("Hello from JSP TEST1.0"); %> 

    <form action="dbCon" method="post">
 
    <table>
 
    <tr>
 
    <td>Name:</td> 
    <td><input type="text" name="userName"></td>
 
    </tr>
 
    <tr>
 
    <td>Password:</td>
    <td><input type="password" name="userPassword"></td>
    </tr>
    
    </table>
 
    <input type="submit" value="Login">
    </form>
</body>
</html> 
