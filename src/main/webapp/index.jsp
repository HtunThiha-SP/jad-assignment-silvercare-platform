<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./components/header-config.html" %>
<title>SilverCare | Premium Caregiving Services</title>
</head>
<body>
	<jsp:include page="./components/navBar.jsp"></jsp:include>
    <section class="py-5">
        <div class="container">
            <div class="row align-items-center gy-4">
                <div class="col-md-4 text-center">
                    <img src="./img/silvercare-logo.png" 
                         alt="SilverCare Logo" 
                         class="img-fluid" 
                         style="max-width: 250px; border-radius: 20px;">
                </div>
                <div class="col-md-7">
                    <h2 class="fw-bold">What We Do</h2>
                    <p class="mt-3">
                        SilverCare provides compassionate and professional in-home assistance, offering a range
                        of personalized caregiver services tailored to the unique need of seniors and individuals
                        requiring support to maintain their independence and quality of life. Our dedicated team is
                        committed to delivering exceptional care, focusing on everything from daily living activities
                        and medication reminders to specialized companionship.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-white">
        <div class="container">
            <div class="row gy-4 align-items-center">
                <div class="col-md-5 text-center">
                    <img src="./img/service-category-hero.jpg" 
                         alt="SilverCare Services" 
                         class="img-fluid rounded shadow">
                </div>
                <div class="col-md-6 mt-0 pt-0">
                    <h2 class="fw-bold mt-0 pt-0">Our Services - Your Satisfaction</h2>
                    <p class="mt-3">
                        We offer a wide variety of services designed to meet your needs and exceed your expectations. 
                        With a strong focus on quality and customer care, we ensure every client enjoys a smooth, 
                        satisfying experience from start to finish. Choose us for reliable service, exceptional value, 
                        and results you can trust.
                    </p>
                    <button style="
                        background-color: #2C2C2C;
                        color: white;
                        padding: 5px 30px 5px 30px;
                        border-radius: 10px;"
                        onclick="window.location.href='./serviceCategories.jsp'"
                    >
                        <i class="bi bi-search-heart"></i>&ensp;Browse Services
                    </button>
                </div>
            </div>
        </div>
    </section>

    <section class="py-3">
        <div class="container text-center">
            <h2 class="fw-bold mb-4">What Our Clients Say</h2>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="p-4 bg-white rounded shadow-sm h-100">
                        <p class="fst-italic">
                            "SilverCare has been a blessing. Their caregivers treat my mother 
                            with kindness and dignity every day."
                        </p>
                        <h6 class="mt-3 fw-bold">— Sarah Lim</h6>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 bg-white rounded shadow-sm h-100">
                        <p class="fst-italic">
                            "Professional, punctual, and caring. I trust SilverCare with my 
                            father's well-being completely."
                        </p>
                        <h6 class="mt-3 fw-bold">— Jonathan Lee</h6>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4 bg-white rounded shadow-sm h-100">
                        <p class="fst-italic">
                            "Their personalized attention makes all the difference. Highly 
                            recommended for elderly care."
                        </p>
                        <h6 class="mt-3 fw-bold">— Mei Chen</h6>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@ include file="./components/footer.html" %>
</body>
</html>