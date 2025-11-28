<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.silvercare.controller.ReviewController" %>
<%@ page import="com.silvercare.dto.ReviewDisplayDto" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./components/header-config.html" %>
<title>SilverCare | Service Reviews</title>

<style>
    body {
        background-color: #F5F5F5;
    }
    .review-hero {
        background: linear-gradient(120deg, #1D3142, #2C5364);
        color: #F9FAFB;
        border-radius: 24px;
        padding: 28px 24px;
    }
    .rating-number { font-size: 40px; font-weight: 700; }
    .star {
        font-size: 20px;
        cursor: pointer;
        color: #D1D5DB;
        transition: color 0.2s ease;
    }
    .star.active { color: #FACC15; }
    .review-card {
        border-radius: 18px;
        border: none;
        background-color: #FFFFFF;
        box-shadow: 0 6px 20px rgba(15,23,42,0.08);
    }
    .review-avatar {
        width: 40px;
        height: 40px;
        border-radius: 999px;
        background-color: #E5E7EB;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        color: #4B5563;
    }
    .badge-service {
        font-size: 11px;
        border-radius: 999px;
        background-color: #EEF2FF;
        color: #4338CA;
        padding: 2px 10px;
    }
</style>
</head>
<body>
    <jsp:include page="./components/navBar.jsp"></jsp:include>

    <%
    String categoryName = request.getParameter("name");
            if (categoryName == null || categoryName.isBlank()) {
                categoryName = "In-home Care";
            }

            HttpSession currentSession = request.getSession(false);
            Integer sessionUserId = null;
            String displayName = "Guest";
            boolean loggedIn = false;

            if (currentSession != null && currentSession.getAttribute("userId") != null) {
                loggedIn = true;
                sessionUserId = (Integer) currentSession.getAttribute("userId");
                String d = (String) currentSession.getAttribute("displayName");
                if (d != null && !d.isBlank()) {
                    displayName = d;
                }
            }

            // success / error message from servlet
            Boolean reviewSuccess = (Boolean) (currentSession != null ? currentSession.getAttribute("reviewSuccess") : null);
            String reviewMessage = (String) (currentSession != null ? currentSession.getAttribute("reviewMessage") : null);
            if (currentSession != null) {
                currentSession.removeAttribute("reviewSuccess");
                currentSession.removeAttribute("reviewMessage");
            }

            // Load reviews & summary from backend
            List<ReviewDisplayDto> reviews = ReviewController.getReviewsForCategory(categoryName);
            Map<String, Object> summary = ReviewController.getReviewSummaryForCategory(categoryName);
            double avgRating = (double) summary.getOrDefault("avgRating", 0.0);
            int reviewCount = (int) summary.getOrDefault("reviewCount", 0);

            String avgRatingDisplay = (reviewCount > 0)
                    ? String.format("%.1f", avgRating)
                    : "-";
    %>

    <div class="container mt-5 mb-5">
        <!-- Message alert -->
        <%
            if (reviewMessage != null) {
        %>
            <div class="row justify-content-center mb-3">
                <div class="col-12 col-lg-10">
                    <div class="alert alert-<%= (reviewSuccess != null && reviewSuccess) ? "success" : "danger" %> alert-dismissible fade show" role="alert">
                        <%= reviewMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            </div>
        <%
            }
        %>

        <!-- Hero -->
        <div class="row justify-content-center mb-4">
            <div class="col-12 col-lg-10">
                <div class="review-hero">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <p class="mb-1 text-uppercase"
                               style="font-size: 12px; letter-spacing:.14em; font-weight:600;">
                                Reviews
                            </p>
                            <h3 class="mb-1" style="font-weight:700;">
                                <%= categoryName %>
                            </h3>
                            <p class="mb-0" style="max-width:520px;">
                                See what clients say about our <%= categoryName %> services and share
                                your own experience to help others make informed choices.
                            </p>
                        </div>
                        <div class="col-md-4 mt-4 mt-md-0">
                            <div class="card border-0" style="border-radius:18px; background:rgba(15,23,42,0.8); color:#F9FAFB;">
                                <div class="card-body text-center">
                                    <div class="rating-number"><%= avgRatingDisplay %></div>
                                    <div class="mb-1">
                                        <% if (reviewCount > 0) {
                                               int fullStars = (int) Math.round(avgRating);
                                               for (int i = 1; i <= 5; i++) {
                                                   if (i <= fullStars) { %>
                                                       <i class="bi bi-star-fill text-warning"></i>
                                                   <% } else { %>
                                                       <i class="bi bi-star text-warning"></i>
                                                   <% }
                                               }
                                           } else { %>
                                               <span class="text-muted">No reviews yet</span>
                                           <% } %>
                                    </div>
                                    <small class="text-muted">
                                        <%= reviewCount %> review<%= (reviewCount == 1 ? "" : "s") %>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Form + reviews -->
        <div class="row justify-content-center g-4">
            <div class="col-12 col-lg-10">
                <div class="row g-4">
                    <!-- LEFT: review form -->
                    <div class="col-md-5">
                        <div class="card review-card mb-3">
                            <div class="card-body">
                                <h5 class="mb-3">
                                    <i class="bi bi-pencil-square"></i>&ensp;Write a Review
                                </h5>

                                <% if (!loggedIn) { %>
                                    <p class="text-muted" style="font-size: 14px;">
                                        You need to be logged in to submit a review.
                                    </p>
                                    <a href="<%= request.getContextPath() %>/pages/login.jsp"
                                       class="btn btn-primary w-100">
                                        Login to Continue
                                    </a>
                                <% } else { %>
                                    <form action="<%= request.getContextPath() %>/create-review" method="post">
                                        <input type="hidden" name="categoryName" value="<%= categoryName %>">

                                        <!-- Rating stars -->
                                        <div class="mb-3">
                                            <label class="form-label">Overall rating</label>
                                            <div id="starRating">
                                                <i class="bi bi-star-fill star" data-value="1"></i>
                                                <i class="bi bi-star-fill star" data-value="2"></i>
                                                <i class="bi bi-star-fill star" data-value="3"></i>
                                                <i class="bi bi-star-fill star" data-value="4"></i>
                                                <i class="bi bi-star-fill star" data-value="5"></i>
                                                <input type="hidden" name="rating" id="ratingInput" value="0">
                                            </div>
                                            <small id="ratingLabel" class="text-muted" style="font-size: 12px;">
                                                Tap a star to select your rating.
                                            </small>
                                        </div>

                                        <!-- Service select (using known IDs from your service table) -->
                                        <div class="mb-3">
                                            <label class="form-label">Service</label>
                                            <select class="form-select" name="serviceId" required>
                                                <% if ("In-home Care".equalsIgnoreCase(categoryName)) { %>
                                                    <option value="1">Personal Care Session (30 min)</option>
                                                    <option value="2">Personal Care Session (1 hour)</option>
                                                    <option value="3">Home Assistance Session (1 hour)</option>
                                                    <option value="4">Meal Preparation Session (1.5 hours)</option>
                                                    <option value="5">Medication Reminder Visit (30 min)</option>
                                                    <option value="6">Companionship Visit (1 hour)</option>
                                                <% } else if ("Specialized Care".equalsIgnoreCase(categoryName)) { %>
                                                    <option value="7">Dementia Care Support Session (1 hour)</option>
                                                    <option value="8">Dementia Care Support Session (1.5 hours)</option>
                                                    <option value="9">Post-Surgery Recovery Session (2 hours)</option>
                                                    <option value="10">Chronic Illness Support Session (1 hour)</option>
                                                    <option value="11">Palliative Comfort Visit (1.5 hours)</option>
                                                    <option value="12">Mobility &amp; Fall-Prevention Session (1 hour)</option>
                                                <% } else if ("Transportation & Meal Delivery".equalsIgnoreCase(categoryName)) { %>
                                                    <option value="13">Medical Appointment Transport</option>
                                                    <option value="14">Grocery Shopping Transport</option>
                                                    <option value="15">Meal Delivery Drop-Off</option>
                                                    <option value="16">Pharmacy Pickup Service</option>
                                                    <option value="17">Accompanied Travel Support (2 hours)</option>
                                                <% } else { %>
                                                    <!-- Lifestyle Wellness Support -->
                                                    <option value="18">Home Exercise &amp; Mobility Session (45 min)</option>
                                                    <option value="19">Cognitive Stimulation Session (1 hour)</option>
                                                    <option value="20">Recreational Activity Session (1 hour)</option>
                                                    <option value="21">Home Organization Support Session (1.5 hours)</option>
                                                    <option value="22">Community Outing Support Session (2 hours)</option>
                                                <% } %>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Your review</label>
                                            <textarea class="form-control" name="comment" rows="4"
                                                      placeholder="Share how this service helped you or your loved one."
                                                      required></textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Name (shown with your review)</label>
                                            <input type="text" class="form-control"
                                                   value="<%= displayName %>" disabled>
                                        </div>

                                        <button type="submit" class="btn btn-primary w-100">
                                            Submit Review
                                        </button>
                                    </form>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <!-- RIGHT: existing reviews -->
                    <div class="col-md-7">
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="bi bi-chat-left-quote-fill"></i>&ensp;Client reviews
                            </h5>
                            <span class="text-muted" style="font-size: 13px;">
                                <%= (reviewCount > 0)
                                    ? ("Showing " + reviewCount + " review" + (reviewCount == 1 ? "" : "s"))
                                    : "No reviews yet for this category" %>
                            </span>
                        </div>

                        <% if (reviews.isEmpty()) { %>
                            <p class="text-muted" style="font-size: 14px;">
                                There are no reviews yet. Be the first to share your experience!
                            </p>
                        <% } else {
                               for (ReviewDisplayDto r : reviews) {
                                   String reviewerName = r.reviewerName();
                                   String serviceName = r.serviceName();
                                   int rating = r.rating();
                                   String comment = r.comment();
                                   java.sql.Timestamp ts = r.createdOn();
                        %>
                            <div class="card review-card mb-3">
                                <div class="card-body">
                                    <div class="d-flex mb-2">
                                        <div class="review-avatar me-3">
                                            <%= reviewerName != null && !reviewerName.isBlank()
                                                    ? reviewerName.substring(0,1).toUpperCase()
                                                    : "U" %>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <strong><%= reviewerName %></strong>
                                                    <span class="badge-service ms-2">
                                                        <%= serviceName %>
                                                    </span>
                                                </div>
                                                <small class="text-muted">
                                                    <%= ts != null ? ts.toLocalDateTime().toLocalDate().toString() : "" %>
                                                </small>
                                            </div>
                                            <div class="mt-1" style="font-size: 13px;">
                                                <%
                                                    for (int i = 1; i <= 5; i++) {
                                                        if (i <= rating) { %>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                        <% } else { %>
                                                            <i class="bi bi-star text-warning"></i>
                                                        <% }
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="mb-0" style="font-size: 14px;">
                                        <%= comment %>
                                    </p>
                                </div>
                            </div>
                        <%     } // end for
                           } // end else %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="./components/footer.html" %>

    <script>
        // Rating stars (UI only – sends value to hidden input)
        const stars = document.querySelectorAll("#starRating .star");
        const ratingInput = document.getElementById("ratingInput");
        const ratingLabel = document.getElementById("ratingLabel");

        if (stars && ratingInput && ratingLabel) {
            stars.forEach(star => {
                star.addEventListener("click", () => {
                    const value = parseInt(star.getAttribute("data-value"));
                    ratingInput.value = value;

                    stars.forEach(s => {
                        const sVal = parseInt(s.getAttribute("data-value"));
                        if (sVal <= value) {
                            s.classList.add("active");
                        } else {
                            s.classList.remove("active");
                        }
                    });

                    const labels = ["Very poor", "Poor", "Okay", "Good", "Excellent"];
                    ratingLabel.textContent = "You selected: " + labels[value - 1] + " (" + value + " / 5)";
                });
            });
        }
    </script>
</body>
</html>

