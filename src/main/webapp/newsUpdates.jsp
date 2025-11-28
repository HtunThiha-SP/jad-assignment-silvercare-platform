<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.silvercare.dto.NewsDto" %>
<%@ page import="com.silvercare.controller.NewsController" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@ include file="../components/header-config.html" %>
    <title>SilverCare | News and Updates</title>

    <style>
        body {
            background-color: #F5F5F5;
        }

        .news-hero {
            background: linear-gradient(120deg, #1D3142, #2C5364);
            color: #F7FAFC;
            border-radius: 24px;
            padding: 32px 28px;
        }

        .news-tag {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: .12em;
            font-weight: 600;
        }

        .news-card {
            border-radius: 16px;
            border: none;
            background-color: #FFFFFF;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
            overflow: hidden;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

        .news-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 40px rgba(15, 23, 42, 0.12);
        }

        .news-card-header {
            font-size: 12px;
            color: #6B7280;
        }

        .news-pill {
            border-radius: 999px;
            padding: 2px 10px;
            font-size: 11px;
            font-weight: 600;
        }

        .pill-announcement {
            background-color: #EFF6FF;
            color: #1D4ED8;
        }

        .pill-health {
            background-color: #ECFDF5;
            color: #15803D;
        }

        .pill-event {
            background-color: #FEF3C7;
            color: #92400E;
        }

        /* Fade-in animation on scroll */
        .fade-in-up {
            opacity: 0;
            transform: translateY(18px);
            transition: opacity 0.5s ease-out, transform 0.5s ease-out;
        }

        .fade-in-up.show {
            opacity: 1;
            transform: translateY(0);
        }

        .news-stat-card {
            border-radius: 18px;
            border: none;
            background-color: #111827;
            color: #F9FAFB;
        }
    </style>
</head>
<body>
    <jsp:include page="./components/navBar.jsp"></jsp:include>

    <div class="container mt-5 mb-5">

        <div class="row justify-content-center mb-4">
            <div class="col-12 col-lg-10">
                <div class="news-hero fade-in-up">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <div class="news-tag mb-2">News &amp; Updates</div>
                            <h2 class="mb-2" style="font-weight: 700;">
                                Stay informed about SilverCare and your well-being.
                            </h2>
                            <p class="mb-0" style="max-width: 520px;">
                                Read the latest service announcements, health tips, and community
                                activities carefully curated for our clients and their families.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row justify-content-center g-4">
            <div class="col-12 col-lg-10">
            
		<%
		    var newsList = NewsController.getAllNews();
		    for (NewsDto news : newsList) {
		%>
		    <div class="card news-card mb-3 fade-in-up news-item" data-category="<%= news.getCategory() %>">
		        <div class="card-body">
		            <div class="d-flex justify-content-between news-card-header mb-1">
		                <div>
		                    <span class="news-pill pill-<%= news.getCategory().toLowerCase() %> me-2" style="color: <%= news.getColor() %>;">
		                        <%= news.getCategory() %>
		                    </span>
		                    <span style="font-size: 12px; color:#6B7280;">• <%= news.getCreatedTime() %></span>
		                </div>
		                <span><%= news.getAuthor() %></span>
		            </div>
		            <h5 class="card-title mb-2"><%= news.getTitle() %></h5>
		            <p class="card-text mb-2" style="font-size: 14px;">
		                <%= news.getDescription() %>
		            </p>
		        </div>
		    </div>
		<%
		    }
		%>


            </div>
        </div>
    </div>

    <%@ include file="./components/footer.html" %>

    <script>
        const newsItems = document.querySelectorAll(".news-item");


        // Fade-in on scroll using IntersectionObserver
        const faders = document.querySelectorAll(".fade-in-up");
        const observer = new IntersectionObserver((entries, obs) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("show");
                    obs.unobserve(entry.target); // animate once
                }
            });
        }, {
            threshold: 0.2
        });

        faders.forEach(el => observer.observe(el));
    </script>
</body>
</html>