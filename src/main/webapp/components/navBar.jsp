<%@ page import="com.silvercare.model.ServiceCategory" %>
<%@ page import="com.silvercare.service.ServiceCategoryManager" %>
<style>
  .nav-item, .navbar-brand {
    padding-right: 20px;
  }
  .nav-link.active {
    font-weight: bold;
    color: #1d3142 !important;
  }
</style>
<nav class="navbar navbar-expand-lg" style="background-color: #e8e9ea">
  <div class="container-fluid mx-5">
    <a class="navbar-brand d-flex align-items-center" href="./index.jsp">
      <img src="./img/silvercare-logo.png" width="33px" height="33px" class="me-3">
      SilverCare
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">

        <li class="nav-item">
          <a class="nav-link <%= request.getRequestURI().endsWith("index.jsp") ? "active" : "" %>" href="./index.jsp">
            <i class="bi bi-house"></i>&ensp;&nbsp;Home
          </a>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle <%= (request.getRequestURI().endsWith("serviceCategories.jsp") || 
        		  request.getRequestURI().endsWith("services.jsp") ||
        		  request.getRequestURI().endsWith("serviceDetails.jsp")) ? "active" : "" %>" role="button" data-bs-toggle="dropdown">
            <i class="bi bi-postcard-heart"></i>&ensp;&nbsp;Care Services
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="./serviceCategories.jsp">All service categories</a></li>
            <li><hr class="dropdown-divider"></li>
            <!-- adds service category names to dropdown list -->
            <%
            	for(ServiceCategory serviceCategory : ServiceCategoryManager.getAllServiceCategories()) {
            		String name = serviceCategory.getName();
            		out.println("<li><a class=\"dropdown-item\" href=\"./services.jsp?category=" 
            	            + name + "\">" + name + "</a></li>");
            	}
            %>
          </ul>
        </li>

        <li class="nav-item">
          <a class="nav-link <%= request.getRequestURI().endsWith("newsUpdates.jsp") ? "active" : "" %>" href="./newsUpdates.jsp">
            <i class="bi bi-newspaper"></i>&ensp;&nbsp;News and Updates
          </a>
        </li>

      </ul>

      <div class="d-flex">
        <%
          String sessionDisplayName = (String) session.getAttribute("displayName");
          if(sessionDisplayName == null) {
            out.print("<a href='./login.jsp' class='btn btn-outline-success me-2'>Login</a>");
            out.print("<a href='./register.jsp' class='btn btn-primary'>Register</a>");
          } else {
            out.print("<a href='./profile.jsp' class='btn btn-outline-dark me-2'><i class='bi bi-person-circle'></i>&ensp;" + sessionDisplayName + "</a>");
            out.print("<a href='./cart.jsp' class='btn btn-primary'><i class='bi bi-cart-check-fill'></i>&ensp;Cart</a>");
          }
        %>
      </div>
    </div>
  </div>
</nav>