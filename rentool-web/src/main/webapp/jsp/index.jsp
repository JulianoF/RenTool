<%@ page language="java" contentType="text/html"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

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
    <br>
    <br>
    <br>

<div class="container col-xxl-8 px-4 py-5">
    <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
      <div class="col-10 col-sm-8 col-lg-6">
        <img src="imgs/toolsLots.jpg" class="d-block mx-lg-auto img-fluid" alt="Bootstrap Themes" width="700" height="500" loading="lazy">
      </div>
      <div class="col-lg-6">
        <h1 class="display-5 fw-bold lh-1 mb-3">RenTool</h1>
        <p class="lead">Aiming to be the Number One tool rental service around. With RenTool, make some extra cash or get that last minute tool you know you will only use once.</p>
        <div class="d-grid gap-2 d-md-flex justify-content-md-start">
        <% if (session != null && session.getAttribute("email") != null) { %>
           <button type="button" class="btn btn-primary btn-lg px-4 me-md-2" onclick="gotoListing()">Create a Listing</button>
        <% } else { %>
          <button type="button" class="btn btn-primary btn-lg px-4 me-md-2" onclick="gotoLogin()">Login</button>
          <button type="button" class="btn btn-outline-secondary btn-lg px-4" onclick="gotoCreation()">Sign Up</button>
        <% } %>
        </div>
      </div>
    </div>
  </div>

    <br>
    <br>
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
    <script>
        function gotoListing(){
            window.location.href = "createListing.jsp";
        }
        function gotoLogin(){
            window.location.href = "login.jsp";
        }
        function gotoCreation(){
            window.location.href = "accCreation.jsp";
        }
    </script>
</body>
</html> 
