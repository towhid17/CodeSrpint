<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="UTF-8">
        <title>CodeSprint</title>
        <decorator:head/>
        <%@ include file="common/_header.jsp" %>
        <%@ include file="common/_message.jsp" %>
        <%@ include file="common/_spinner.jsp" %>
    </head>
    <body>
        <decorator:body/>
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                spinnerStop();
            });
        </script>
    </body>
</html>