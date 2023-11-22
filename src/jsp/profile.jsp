<%@ page language="java" contentType="text/html"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
   <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>RenTool</title>
  </head>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<body>
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
   <div class="container-fluid">
     <a class="navbar-brand" href="#">RenTool</a>
     <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
       <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
           <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
         </li>
          <li class="nav-item">
            <form action="GotoProfile" method = "POST"> <button class="nav-link" type ="submit">Profile</button></form>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="createListing.jsp">Create Listing</a>
          </li>

          <% if (session != null && session.getAttribute("email") != null) { %>
            <li class="nav-item">
              <a class="nav-link" href="Logout">Logout</a>
            </li>
          <% } else { %>
            <li class="nav-item">
              <a class="nav-link" href="login.jsp">Login</a>
            </li>
          <% } %>

        </ul>
        <form class="d-flex w-25" role="search" action="MakeSearch" method="POST">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name = "searchField">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
      </div>
    </div>
  </nav>

    <br>
  <% if (session != null && session.getAttribute("email") != null) { %>
    <div class="container">
      <h1 class="my-5 display-4 fw-bold ls-tight"> Order History</h1>
        <div class="row">

<% int i = 0; 
   int j = 0; 
   if(request.getAttribute("howManyOrder") != null){ 
      j = (int) request.getAttribute("howManyOrder"); 
   } 
%>

        <% while( i < j){ 
          String itemName = (String) request.getAttribute("ItemName_"+i);
           String condition = (String) request.getAttribute("Cond_"+i);
           int rentalPrice = (int) request.getAttribute("RentPrice_"+i); %>
    <!-- Repeat this column structure for each order -->
    <div class="col-md-4 mb-4">
      <div class="card h-100">
        <div class="card-body">
          <h5 class="card-title">Order Name: <% out.print(itemName);%></h5>
          <p class="card-text">Price: $<% out.print(rentalPrice);%></p>
          <p class="card-text">Condition: <% out.print(condition);%></p>
        </div>
      </div>
    </div>
 
            <% i++; 
          } %>
  </div>
</div>
  <% } else { %>
        <h1 class="my-5 display-4 fw-bold ls-tight"> Please Login to View Profile</h1>
  <% } %>

    <br>
    <br>
    <br>
    <br>

    <div class="container">
      <footer class="py-3 my-4">
        <ul class="nav justify-content-center border-bottom pb-3 mb-3">
          <li class="nav-item"><a href="index.jsp" class="nav-link px-2 text-muted">Home</a></li>
          <li class="nav-item"><a href="searchResults.jsp" class="nav-link px-2 text-muted">Search</a></li>
          <% if (session != null && session.getAttribute("email") != null) { %>
              <li class="nav-item"><a href="Logout" class="nav-link px-2 text-muted">Logout</a></li>
          <% } else { %>
              <li class="nav-item"><a href="Logout" class="nav-link px-2 text-muted">Login</a></li>
          <% } %>
        </ul>
        <p class="text-center text-muted">2023 RenTool, Inc</p>
      </footer>
    </div>
</body>
</html>