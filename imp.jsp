
<%
    if(session.getAttribute("uname")==null && session.getAttribute("aname")==null)
    {
        response.sendRedirect("login.jsp");
    }
%>