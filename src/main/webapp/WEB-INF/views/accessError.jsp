<%-- @author towhidul.islam @since 8/20/23 --%>

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
                    <h5> <spring:message code="label.accessError"/></h5>
                </div>
            </div>
        </div>
    </body>
</html>