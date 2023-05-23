<%@ page import="java.util.*" %>

<%@ page import="java.text.DecimalFormat" %>

<%@ page import="java.math.RoundingMode" %>

<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<html>

<head>

    <title>Product Catalog</title>

    <style>

        table {

            border-collapse: collapse;

            width: 100%;

        }

 

        th, td {

            border: 1px solid black;

            padding: 8px;

            text-align: left;

        }

 

        th {

            background-color: #f2f2f2;

        }

 

        .center {

            text-align: center;

        }

    </style>

</head>

<body>

    <h1 class="center">PRODUCT CATALOG</h1>

    <form method="post">

        <table>

            <tr>

                <th>Product Name</th>

                <th>Price</th>

                <th>Quantity</th>

                <th>Gift Wrap</th>

            </tr>

            <tr>

                <td>Product A</td>

                <td>$20</td>

                <td><input type="number" name="quantity1" min="0" VALUE=0></td>

                <td><input type="checkbox" name="giftWrap1" value="1"></td>

            </tr>

            <tr>

                <td>Product B</td>

                <td>$40</td>

                <td><input type="number" name="quantity2" min="0" VALUE=0></td>

                <td><input type="checkbox" name="giftWrap2" value="1"></td>

            </tr>

            <tr>

                <td>Product C</td>

                <td>$50</td>

                <td><input type="number" name="quantity3" min="0" VALUE=0></td>

                <td><input type="checkbox" name="giftWrap3" value="1"></td>

            </tr>

        </table>

        <br>

        <input type="submit" value="Calculate Total">

    </form>

 

<%

    

     double PRODUCT_A_PRICE = 20.0;

     double PRODUCT_B_PRICE = 40.0;

     double PRODUCT_C_PRICE = 50.0;

     double FLAT_10_DISCOUNT_THRESHOLD = 200.0;

     double FLAT_10_DISCOUNT_AMOUNT = 10.0;

     int BULK_5_DISCOUNT_THRESHOLD = 10;

     double BULK_5_DISCOUNT_PERCENTAGE = 0.05;

     int BULK_10_DISCOUNT_THRESHOLD = 20;

     double BULK_10_DISCOUNT_PERCENTAGE = 0.1;

     int TIERED_50_DISCOUNT_THRESHOLD = 30;

     double TIERED_50_DISCOUNT_PERCENTAGE = 0.5;

     double GIFT_WRAP_FEE = 5.0;

     int SHIPPING_PACKAGE_CAPACITY = 5;

     double SHIPPING_FEE_PER_PACKAGE = 10.0;

 

    // Get user inputs
    String a=request.getParameter("quantity1");
    String b=request.getParameter("quantity2");
    String c =request.getParameter("quantity3");
    int quantity11=0;
    int quantity21=0;
    int quantity31=0;
    if(a!=null){
      quantity11 = Integer.parseInt(a.trim());
    }
    if(b!=null){
     quantity21 = Integer.parseInt(b.trim());
    }
    
    if(c!=null){
     quantity31 =  Integer.parseInt(c.trim());
    }
    boolean giftWrap1 = request.getParameter("giftWrap1") != null;

    boolean giftWrap2 = request.getParameter("giftWrap2") != null;

    boolean giftWrap3 = request.getParameter("giftWrap3") != null;

 

    // Calculate totals

    double productATotal = PRODUCT_A_PRICE * quantity11;

    double productBTotal = PRODUCT_B_PRICE * quantity21;

    double productCTotal = PRODUCT_C_PRICE * quantity31;

    double total = productATotal + productBTotal + productCTotal;

 

    // Apply discounts

    double discount = 0.0;

    String discountType = "";

 

 
 if (quantity11 + quantity21 + quantity31 >= TIERED_50_DISCOUNT_THRESHOLD) {

    discount = total * TIERED_50_DISCOUNT_PERCENTAGE;

    discountType = "Tiered 50% Discount";

}

 else if (quantity11 + quantity21 + quantity31 >= BULK_10_DISCOUNT_THRESHOLD) {

     discount = total * BULK_10_DISCOUNT_PERCENTAGE;

     discountType = "Bulk 10% Discount";

 }

 else if (quantity11 + quantity21 + quantity31 >= BULK_5_DISCOUNT_THRESHOLD) {

     discount = total * BULK_5_DISCOUNT_PERCENTAGE;

     discountType = "Bulk 5% Discount";

 }
 else if (total >= FLAT_10_DISCOUNT_THRESHOLD) {

    discount = FLAT_10_DISCOUNT_AMOUNT;

    discountType = "Flat $10 Discount";

}
    // Calculate gift wrap fee

    double giftWrapFee = 0.0;

    if (giftWrap1) {
    	
    	if(quantity11>0){

        giftWrapFee += GIFT_WRAP_FEE;
    	}
    }

    if (giftWrap2) {
    	
    	if(quantity21>0){

        giftWrapFee += GIFT_WRAP_FEE;
    	}
    }

    if (giftWrap3) {
    	if(quantity31>0){
        giftWrapFee += GIFT_WRAP_FEE;
    	}
    }

 

    // Calculate shipping fee

    int packageCount = (int) Math.ceil((quantity11 + quantity21 + quantity31) / SHIPPING_PACKAGE_CAPACITY);

    double shippingFee = packageCount * SHIPPING_FEE_PER_PACKAGE;

 

    // Calculate final total

    double finalTotal = total - discount + giftWrapFee + shippingFee;

 

    // Format values for display

    String formattedProductATotal = String.format("%.2f", productATotal);

    String formattedProductBTotal = String.format("%.2f", productBTotal);

    String formattedProductCTotal = String.format("%.2f", productCTotal);

    String formattedTotal = String.format("%.2f", total);

    String formattedDiscount = String.format("%.2f", discount);

    String formattedGiftWrapFee = String.format("%.2f", giftWrapFee);

    String formattedShippingFee = String.format("%.2f", shippingFee);

    String formattedFinalTotal = String.format("%.2f", finalTotal);

%>

 

<!DOCTYPE html>

<html>

<head>

    <title>Order Summary</title>

    <style>

        /* Styles for the table */

        table {

            border-collapse: collapse;

            width: 100%;

        }

 

        th, td {

            text-align: left;

            padding: 8px;

            border-bottom: 1px solid #ddd;

        }

 

        .total {

            font-weight: bold;

        }

 

        .discount {

            color: red;

        }

    </style>

</head>

<body>

    <h1>Order Summary</h1>

    <table>

        <tr>

            <th>Product</th>

            <th>Price</th>

            <th>Quantity</th>

            <th>Total</th>

        </tr>

        <% if (quantity11 > 0) { %>

            <tr>

                <td>Product A</td>

                <td>$20</td>

                <td><%= quantity11 %></td>

                <td>$<%= formattedProductATotal %></td>

            </tr>

        <% } %>

        <% if (quantity21 > 0) { %>

            <tr>

                <td>Product B</td>

                <td>$40</td>

                <td><%= quantity21 %></td>

                <td>$<%= formattedProductBTotal %></td>

            </tr>

        <% } %>

        <% if (quantity31 > 0) { %>

            <tr>

                <td>Product C</td>

                <td>$50</td>

                <td><%= quantity31 %></td>

                <td>$<%= formattedProductCTotal %></td>

            </tr>

        <% } %>

        <tr class="total">

            <td colspan="3">Subtotal</td>

            <td>$<%= formattedTotal %></td>

        </tr>

        <% if (discount > 0) { %>

            <tr>

                <td colspan="3">Discount (<%= discountType %>)</td>

                <td class="discount">-$<%= formattedDiscount %></td>

            </tr>

        <% } %>

        <% if (giftWrapFee > 0) { %>

            <tr>

                <td colspan="3">Gift Wrap Fee</td>

                <td>$<%= formattedGiftWrapFee %></td>

            </tr>

        <% } %>

        <% if (shippingFee > 0) { %>

            <tr>

                <td colspan="3">Shipping Fee</td>

                <td>$<%= formattedShippingFee %></td>

            </tr>

        <% } %>

        <tr class="total">

            <td colspan="3">Total</td>

            <td>$<%= formattedFinalTotal %></td>

        </tr>

    </table>

</body>

</html>