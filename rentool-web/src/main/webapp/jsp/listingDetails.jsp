<%@ page language="java" contentType="text/html"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
   <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>RenTool</title>
  </head>
  <link rel="stylesheet" type="text/css" href="/RenTool/css/bootstrap.css" />
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
           <a class="nav-link active" aria-current="page" href="/RenTool/jsp/index.jsp">Home</a>
         </li>
          <li class="nav-item">
            <a class="nav-link" href="/RenTool/jsp/profile.jsp">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/RenTool/jsp/createListing.jsp">Create Listing</a>
          </li>

          <% if (session != null && session.getAttribute("email") != null) { %>
            <li class="nav-item">
              <a class="nav-link" href="Logout">Logout</a>
            </li>
          <% } else { %>
            <li class="nav-item">
              <a class="nav-link" href="/RenTool/jsp/login.jsp">Login</a>
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

      <%
           byte[] imageData = (byte[]) session.getAttribute("ImageData");
           String itemName =  (String) session.getAttribute("ItemName");
           String condition = (String) session.getAttribute("Condition");
           String dateListed = (String) session.getAttribute("DateListed");
           String desc = (String) session.getAttribute("Desc");
           int rentalPrice = (int) session.getAttribute("RentalPrice");
           double longitude = (double) session.getAttribute("long");
           double latitude = (double) session.getAttribute("lat");
      %>

    <div class="container py-4">

    <div class="p-5 mb-4 bg-light border rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold"><% out.print(itemName);%></h1>
        <p class="col-md-8 fs-4">Price: $<% out.print(rentalPrice);%> </p>
        <p class="col-md-8 fs-4">Condition: <% out.print(condition);%></p>
        <p class="col-md-8 fs-4">Date Listed: <% out.print(dateListed);%> </p>
        <p class="col-md-8 fs-4">Description: <% out.print(desc);%> </p>
        <button class="btn btn-primary btn-lg" type="button">Order</button>
      </div>
    </div>

    <div class="row align-items-md-stretch">
      <div class="col-md-6">
        <div class="h-100 p-5 bg-light border rounded-3">
        <h4 class="display-6 fw-bold">Product Image</h4>
       <!-- Product Image -->
        <% if(imageData != null){
            String base64Image = Base64.getEncoder().encodeToString(imageData); %>
            <div class="col-md-4 mt-2"><img class="img-fluid " src="data:image/jpeg;base64, <%= base64Image %>"></div>
        <% }else{ %>
            <div class="col-md-4 mt-2"><img class="img-fluid " src="https://i.imgur.com/Ycfi8RS.png"></div>
        <% } %>
        </div>
      </div>
      <div class="col-md-6">
        <div class="h-100 p-5 bg-light border rounded-3">
        <h4 class="display-6 fw-bold">Product Location</h4>
            <iframe
            src="https://www.google.com/maps/embed/v1/place?key=&q=<%= latitude %>,<%= longitude %>&zoom=15" allowfullscreen
            width="100%"
            height="90%"
            style="border:0;"
            allowfullscreen=""
            loading="lazy">
          </iframe>
        </div>
      </div>
    </div>

  </div>
    <br>
    <br>

    <div class="container">
      <footer class="py-3 my-4">
        <ul class="nav justify-content-center border-bottom pb-3 mb-3">
          <li class="nav-item"><a href="/RenTool/jsp/index.jsp" class="nav-link px-2 text-muted">Home</a></li>
          <li class="nav-item"><a href="/RenTool/jsp/searchResults.jsp" class="nav-link px-2 text-muted">Search</a></li>
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
