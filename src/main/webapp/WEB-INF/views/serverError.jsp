<%-- @author towhidul.islam @since 8/20/23 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html data-bs-theme="light">
    <body>
        <div class="container-lg">
            <div class="card shadow" style="margin:30px; background-color: rgba(255, 0, 0, 0.377)">
                <div class="card-header">
                    <p> <spring:message code="label.error"/> </p>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>