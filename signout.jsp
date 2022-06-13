

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.invalidate();
    response.sendRedirect("index.jsp");
    response.setHeader("Pragma", "no-cache");
   response.setHeader("Cache-Control", "no-store");
   response.setHeader("Expires", "0");
   response.setDateHeader("Expires", -1);
%>