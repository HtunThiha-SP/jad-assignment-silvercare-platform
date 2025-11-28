<%@ page import="com.silvercare.model.ServiceCategory" %>
<%@ page import="com.silvercare.service.ServiceCategoryManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./components/header-config.html" %>
<title>SilverCare | Service Categories</title>
</head>
<body>
    <jsp:include page="./components/navBar.jsp"></jsp:include>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <h2 class="text-center">Browse Service Categories</h2>
            <div class="col-9 mt-3 mb-5">
                <p>We provide a complete range of supportive care services designed to enhance daily living and overall well-being. 
                    From compassionate in-home assistance and specialized medical support to convenient transportation, nutritious meal delivery, 
                    and personalized lifestyle wellness programs, our services work together to help individuals stay independent, comfortable, 
                    and engaged in the life they love.
                </p>
            </div>
            <div class="col-12 col-sm-10">
                <div class="row gx-5 gy-4 justify-content-center">
				<%
					for(ServiceCategory serviceCategory : ServiceCategoryManager.getAllServiceCategories()) {
					    String name = serviceCategory.getName();
					    String description = serviceCategory.getDescription();
					    String imgUrl = "./img/service-category" + serviceCategory.getImgIndex() + "-banner.png";
					    String redirectUrl = "./services.jsp?category=" + serviceCategory.getName();
					
					    out.print(
					        "<div class='col-sm-10 col-md-6 col-xl-4'>"
					        + "<div class='card' style='"
					            + "box-shadow: 0 2px 8px rgba(0,0,0,0.15);"
					            + "border: none;"
					            + "transition: transform 0.25s ease, box-shadow 0.25s ease;"
					            + "cursor: pointer;'"
					            + " onmouseover=\"this.style.transform='translateY(-5px)'; this.style.boxShadow='0 6px 16px rgba(0,0,0,0.25)';\""
					            + " onmouseout=\"this.style.transform='translateY(0)'; this.style.boxShadow='0 2px 8px rgba(0,0,0,0.15)';\""
					        + ">"
					            + "<img src='" + imgUrl + "' class='card-img-top' alt='" + name + "'>"
					            + "<div class='card-body'>"
					                + "<h5 class='card-title'>" + name + "</h5>"
					                + "<p class='card-text' style='font-size: 14px;'>" + description + "</p>"
					                + "<a href='" + redirectUrl + "' class='btn' style='background-color: #2C2C2C; color: white;'>Learn More</a>"
					            + "</div>"
					        + "</div>"
					        + "</div>"
					    );
					}
				%>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="./components/footer.html" %>
</body>
</html>