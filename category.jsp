

<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@include file="imp.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="css.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <div class="container">
            <!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body modal-body-sub_agile">
					<div class="main-mailposi">
						<span class="fa fa-envelope-o" aria-hidden="true"></span>
					</div>
					<div class="modal_body_left modal_body_left1">
						<h3 class="agileinfo_sign">Add category</h3>
						
                                                <form method="post" enctype="multipart/form-data">
							<div class="styled-input agile-styled-input-top">
			<input type="text" placeholder="category name" name="catname" required="">
							</div>
							<div class="styled-input">
								<input class="text" type="file" name="catimage" required="">
							</div>
                                                   
                                                    <div class="styled-input">
                                                        
<input type="submit" value="Add category" name="submit">
<%
    String cname="", imagename="", path1="" ;
    boolean successful=true;
    
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if(isMultipart)
    {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = null;
         try
        {
        items = upload.parseRequest(request);
         }
         catch (FileUploadException e)
       {
       e.printStackTrace();
       }
   for(FileItem myitem:items)
   {
    
   
        if (myitem.isFormField())
        {
            String itemName1 = myitem.getFieldName();//catsummary
            String value=myitem.getString();//
          
            if(itemName1.equals("catname")) //control's name - textbox name
            {
                cname=value;//Oils
            }
        }
        else
        {
                String type=myitem.getContentType();
                long size=myitem.getSize()/1024; //kbytes
                
                if(size==0)
                {
                    imagename="noimagefound.jpg";
                }
                else if((type.equals("image/pjpeg") || type.equals("image/jpeg")
                        || type.equals("image/png") || type.equals("image/x-png")
                        || type.equals("image/gif")))
                    {
                imagename=new java.util.Date().getTime()+myitem.getName();
                path1=getServletContext().getRealPath("/") + "upload\\" + imagename;
                
                File savefile=new File(path1);
                myitem.write(savefile);    
                }
                else
                {
                    successful=false;
                    out.println("Only pictures are allowed");
                } 
                             
        }
   
  }
   if(successful==true)
   {
        String path="jdbc:mysql://localhost:3306/";
         String place="shopping";
         String uname="root";
         String pass="";
       Class.forName("com.mysql.jdbc.Driver");
        try
        {
            Connection myconn =DriverManager.getConnection(path+place,uname,pass);
            try
            {
                String q = "insert into categorytable(catname,catimage) values(?,?)";
                PreparedStatement myst = myconn.prepareStatement(q);
                myst.setString(1, cname);
                myst.setString(2,imagename);
                int myres = myst.executeUpdate();
                if(myres>0)
                {
                    out.print("Category added successfully");
                }
                else
                {
                    out.print("Category not added successfully");
                }
            }
            catch(Exception e)
            {
                out.print("Error in query" + e.getMessage());
            }
            finally
            {
                myconn.close();
            }
        }   
        catch(Exception e)
        {
            out.print("Error in connection" + e.getMessage());
        }
   }
}
%>


            </div>
               </form>
                                        </div>
                                </div>
        </div>
    </div>
                         
         
    </body>
</html>

       