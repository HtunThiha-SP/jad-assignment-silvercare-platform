<%@ page import="java.util.List" %>
<%@ page import="com.silvercare.dto.CartDto" %>
<%@ page import="com.silvercare.controller.CartController" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@ include file="./components/header-config.html" %>
    <title>SilverCare | Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="./components/navBar.jsp" %>
<div class="container py-4">
    <h3 class="mb-4">Your Cart</h3>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    List<CartDto> cartItems = null;
    double total = 0;

    if (userId != null) {
        cartItems = CartController.getCartItemsByUserId(userId);
        if (cartItems != null) {
            for (CartDto c : cartItems) {
                total += c.getPrice();
            }
        }
    }
%>

    <%
        if (userId == null) {
    %>
        <div class="alert alert-warning">Please log in to view your cart.</div>
    <%
        } else if (cartItems == null || cartItems.isEmpty()) {
    %>
        <div class="alert alert-info">Your cart is empty.</div>
    <%
        } else {
    %>

    <div class="table-responsive mb-3">
        <table class="table table-bordered align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width: 70px;">#</th>
                    <th>Service</th>
                    <th>Category</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th style="width: 110px;">Delete</th>
                </tr>
            </thead>
            <tbody>

                <%
                    int sn = 1;
                    for (CartDto item : cartItems) {
                %>
                <tr>
                    <td><%= sn++ %></td>
                    <td><%= item.getServiceName() %></td>
                    <td><%= item.getServiceCategory() %></td>
                    <td><%= item.getDescription() %></td>
                    <td>$<%= item.getPrice() %></td>
                    <td>
                        <form action="<%= request.getContextPath() %>/delete-cart-item" method="post">
                            <input type="hidden" name="cartId" value="<%= item.getId() %>">
                            <button class="btn btn-danger btn-sm w-100">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>

            </tbody>
        </table>
    </div>

    <div class="d-flex justify-content-end mb-4">
        <h5 class="fw-bold">Total: $<%= total %></h5>
    </div>

    <div class="d-flex justify-content-end">
        <form action="<%= request.getContextPath() %>/checkout" method="post">
            <button class="btn btn-primary btn-lg">Proceed to Checkout</button>
        </form>
    </div>

    <%
        }
    %>
</div>
<%@ include file="./components/footer.html" %>

</body>
</html>