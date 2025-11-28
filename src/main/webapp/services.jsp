<%@ page import="com.silvercare.model.ServiceCategory" %>
<%@ page import="com.silvercare.controller.ServiceCategoryController" %>
<%@ page import="com.silvercare.dto.ServiceDto" %>
<%@ page import="com.silvercare.controller.ServiceController" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./components/header-config.html" %>
<title>SilverCare | Service</title>
</head>
<body>
	<%
		String serviceCategoryNameParam = request.getParameter("category");
		String pageTitle = serviceCategoryNameParam + "&ensp;|&ensp;Services";
		String descriptionContent = "";
		String pageBtnVisibility = "";
		boolean serviceFound = false;
		for(ServiceCategory serviceCategoryData : ServiceCategoryController.getAllServiceCategories()) {
			String name = serviceCategoryData.getName();
			if(serviceCategoryNameParam.equals(name)){
				serviceFound = true;
				descriptionContent = serviceCategoryData.getDescription();
				break;
			}
		}
		
		if(!serviceFound) {
			pageBtnVisibility = "d-none";
			pageTitle = "<span style='color: red;'><i class=\"bi bi-exclamation-triangle-fill\"></i>&ensp;404 - Service Category Not Found</span>";
			descriptionContent = "<div class='text-center'>The service category you\'re looking for doesn\'t exist or has been moved.\n"
					+ "<p>Please check the URL or use menu to find what you need.</p>\n"
					+ "<p>Four further assistance, please contact support.</p></div>";
		}
	%>
    <jsp:include page="./components/navBar.jsp"></jsp:include>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <h2 class="text-center"><%= pageTitle %></h2>
            <div class="col-9 mt-3 mb-5">
                <p>
                	<%= descriptionContent %>
                </p>
            </div>
            <div class="col-12 col-sm-10">
                <div class="row gx-5 gy-4 justify-content-center">
				<%
				    int pageSize = 5;
				    int currentPage = 1;
				
				    if (request.getParameter("page") != null) {
				        try { currentPage = Integer.parseInt(request.getParameter("page")); }
				        catch (Exception e) { currentPage = 1; }
				    }
				
				    var allServices = ServiceController.getServicesByCategoryName(serviceCategoryNameParam);
				    int totalServices = allServices.size();
				    int totalPages = (int) Math.ceil((double) totalServices / pageSize);
				
				    int startIndex = (currentPage - 1) * pageSize;
				    int endIndex = Math.min(startIndex + pageSize, totalServices);
				%>
				<%
				if (serviceFound) {
				    for (int i = startIndex; i < endIndex; i++) {
				        ServiceDto service = allServices.get(i);
				
				        String name = service.getName();
				        String title = service.getTitle();
				        String imgUrl = "./img/service-" + service.getImgIndex() + "-banner.png";
				        String redirectUrl = "./serviceDetails.jsp?name=" + service.getName();
				
				        out.print(
				            "<div class='col-10 col-xl-9'>"
				                + "<div class='card mb-3' style='"
				                    + "box-shadow: 0 2px 8px rgba(0,0,0,0.15);"
				                    + "border: none;"
				                    + "transition: transform 0.25s ease, box-shadow 0.25s ease;"
				                    + "cursor: pointer;'"
				                    + " onmouseover=\"this.style.transform='translateY(-5px)'; this.style.boxShadow='0 6px 16px rgba(0,0,0,0.25)';\""
				                    + " onmouseout=\"this.style.transform='translateY(0)'; this.style.boxShadow='0 2px 8px rgba(0,0,0,0.15)';\""
				                + ">"
				                    + "<div class='row g-0 align-items-stretch'>"
				                        + "<div class='col-md-4'>"
				                            + "<img src='" + imgUrl + "' class='img-fluid h-100 rounded-start' style='object-fit: cover;'>"
				                        + "</div>"
				                        + "<div class='col-md-8'>"
				                            + "<div class='card-body h-100 d-flex flex-column justify-content-center'>"
				                                + "<h5 class='card-title'>" + name + "</h5>"
				                                + "<p class='card-text' style='font-size: 14px;'>" + title + "</p>"
				                                + "<a href='" + redirectUrl + "' class='btn w-50' style='background-color:#2C2C2C;color:white;'>Learn More</a>"
				                            + "</div>"
				                        + "</div>"
				                    + "</div>"
				                + "</div>"
				            + "</div>"
				        );
				    }
				}
				%>
				<div class="col-12 text-center mt-4">
			    <nav class="<%= pageBtnVisibility %>">
			        <ul class="pagination justify-content-center">
			
			            <li class="page-item <%= (currentPage == 1 ? "disabled" : "") %>">
			                <a class="page-link" href="?category=<%=serviceCategoryNameParam%>&page=<%=currentPage-1%>">Previous</a>
			            </li>
			
			            <% for(int i = 1; i <= totalPages; i++) { %>
			                <li class="page-item <%= (currentPage == i ? "active" : "") %>">
			                    <a class="page-link" href="?category=<%=serviceCategoryNameParam%>&page=<%=i%>"><%=i%></a>
			                </li>
			            <% } %>
			
			            <li class="page-item <%= (currentPage == totalPages ? "disabled" : "") %>">
			                <a class="page-link" href="?category=<%=serviceCategoryNameParam%>&page=<%=currentPage+1%>">Next</a>
			            </li>
			
			        </ul>
			    </nav>
</div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="./components/footer.html" %>
</body>
</html>