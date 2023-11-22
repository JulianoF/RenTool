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


<div class="container mt-5 mb-5">
    <div class="d-flex justify-content-center row">
        <div class="col-md-10">

<!-- USE FOR LOOPS TO REPEAT THE LAYOUT BELOW FOR EACH LISTING-->
            <div class="row p-2 bg-white border rounded">
                <div class="col-md-3 mt-1"><img class="img-fluid img-responsive rounded product-image" src="https://i.imgur.com/QpjAiHq.jpg"></div>
                <div class="col-md-6 mt-1">
                    <h5>LISTING 1 NAME</h5>
                    <div class="d-flex flex-row">
                        <div class="ratings mr-2"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div><span>Info Here</span>
                    </div>
                    <div class="mt-1 mb-1 spec-1"><span>INFO HERE <br></span></div>
                    <div class="mt-1 mb-1 spec-1"><span>INFO HERE <br></span></div>
                    <p class="text-justify text-truncate para mb-0">INJECT LISTING DESCRIPTION HERE</p>
                </div>
                <div class="align-items-center align-content-center col-md-3 border-left mt-1">
                    <div class="d-flex flex-row align-items-center">
                        <h4 class="mr-1">$PRICE.PRICE</h4>
                    </div>
                    <h6 class="text-success">Close By</h6>
                    <div class="d-flex flex-column mt-4"><button class="btn btn-primary btn-sm" type="button" onclick="gotoDetails()">Details</button>
                    <button class="btn btn-outline-primary btn-sm mt-2" type="button">Add to Cart</button></div>
                </div>
            </div>
<!-- USE FOR LOOPS TO REPEAT THE LAYOUT ABOVE FOR EACH LISTING-->

<% session.getAttribute("resultMessage"); %>

        </div>
    </div>
</div>


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
        function gotoDetails(){
            window.location.href = "/RenTool/jsp/listingDetails.jsp";
        }
    </script>

</body>
</html> 
