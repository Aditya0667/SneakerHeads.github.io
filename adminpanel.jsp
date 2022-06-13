
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%
    if(session.getAttribute("uname")==null && session.getAttribute("aname")==null)
    {
        response.setHeader("Pragma", "no-cache");
           response.setHeader("Cache-Control", "no-store");
           response.setHeader("Expires", "0");
           response.setDateHeader("Expires", -1);
        response.sendRedirect("login.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="css.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN PANEL</title>
    </head>
    <body>
        <%@include file="headeradmin.jsp" %>
        
        
        <div class="container">
            <!-- Modal content-->
			
				</div>
				<div class="modal-body modal-body-sub_agile">
					<div class="main-mailposi">
						<span class="fa fa-envelope-o" aria-hidden="true"></span>
					</div>
                                    <h3 class="tittle-w3l"> ADMIN PANEL
				<span class="heading-style">
					<i></i>
					<i></i>
					<i></i>
				</span>
			</h3>
                                    
                                    <div class="container">
                                    <div class="row"> 
                                        <div class="col-md-4">
                                            <a href="category.jsp"> <img src="upload/addcat.png" width="100px"> </a>
                                            <br>
                                            <a href="category.jsp">Add category </a>
                                        </div>
                                        <div class="col-md-4">
                                            <a href="subcategory.jsp"> <img src="upload/addsubcat.png" width="100px"> </a>
                                            <br>
                                            <a href="subcategory.jsp">Add Subcategory </a>
                                            
                                            
                                    </div>
					<div class="col-md-4">
                                            <a href="product.jsp"> <img src="upload/adddetails.png" width="100px"> </a>
                                            <br>
                                            <a href="product.jsp">Add Product </a>
                                            
                                            </div>
                                       
                                        <div class="col-md-4">
                                        <a href="showcategories.jsp"> <img src="upload/updatecat.png" width="100px"> </a>
                                            <br>
                                            <a href="showcategories.jsp">Update/Delete Categories </a>
                                            </div>
                                        <div class="col-md-4">
                                        <a href="showcategories.jsp"> <img src="upload/updatesubcat.png" width="100px"> </a>
                                            <br>
                                            <a href="showcategories.jsp">Update/Delete SubCategories </a>
                                            </div>
                                         <div class="col-md-4">
                                            <a href="listofproducts.jsp"> <img src="upload/view_details.png" width="100px"> </a>
                                            <br>
                                            <a href="listofproducts.jsp">List of products </a>
                                            
                                            </div>
                                        
                                        <div class="col-md-4">
                                        <a href="vieworder.jsp"> <img src="upload/orderdetails.png" width="100px"> </a>
                                            <br>
                                            <a href="vieworders.jsp">View Orders </a>
                                            </div>
                                        
                                         <div class="col-md-4">
                                        <a href="orderstatus.jsp"> <img src="upload/updatestatus.png" width="100px"> </a>
                                            <br>
                                            <a href="orderstatus.jsp">View/Update Order Status </a>
                                            </div>
                                        
                                        
                                    </div>
                                    
        </div>
    </div>
        
                         
                                        <%@include file="footer.jsp" %>
        
                            
         
    </body>
   
</html>

       