<%@ page language="java" contentType="text/html"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

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
            <a class="nav-link" href="profile.jsp">Profile</a>
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

<div class="container mt-4">
    <h2>Product Listing Form</h2>
    <form action="MakeListing" method="POST">
      <div class="form-group">
        <label for="itemName">Item Name</label>
        <input type="text" class="form-control" name="itemName" placeholder="Enter item name" required>
      </div>
      <div class="form-group">
        <label for="itemCondition">Item Condition</label>
        <select class="form-control" name="itemCondition" required>
          <option value="New">New</option>
          <option value="Poor">Poor</option>
          <option value="Used">Used</option>
        </select>
      </div>
      <div class="form-group">
        <label for="description">Description</label>
        <textarea class="form-control" name="description" rows="3" placeholder="Enter description"></textarea>
      </div>
      <div class="form-group">
        <label for="rentalPrice">Rental Price</label>
        <input type="number" class="form-control" name="rentalPrice" placeholder="Enter rental price" required>
      </div>
      <div class="form-group">
        <label for="dateListed">Date Listed</label>
        <input type="date" class="form-control" name="dateListed" required>
      </div>
      <div class="form-group">
        <div class="form-check">
          <input type="checkbox" class="form-check-input" name="inUse">
          <label class="form-check-label" for="inUse">In Use</label>
        </div>
      </div>
      <br>
       <!-- Product Photo Upload -->
       <div class="form-group">
          <label for="productPhoto">Product Photo</label>
          <input type="file" class="form-control-file" id="productPhoto" name="productPhoto" accept="image/*">
       </div>
       <br>   
      <button type="submit" class="btn btn-primary">Create Listing</button>
    </form>
  </div>

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
