<%-- @author towhidul.islam @since 8/20/23 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html data-bs-theme="light">
    <head>
        <meta charset="UTF-8" />
        <title>Attribute</title>
    </head>
    <body>
        <div class="container-lg" style="padding: 20px;">
            <div class="card">
                <div class="card-header">
                    <h3><spring:message code="label.attribute"/></h3>
                </div>
                <div class="container rounded" style="display: flex; justify-content: space-between; border: 1px solid #80808021;">
                    <div class="col-3" style="margin-right: 10px;">
                        <div class="card shadow rounded" style="padding: 25px;">
                            <%@ include file="_createCategory.jsp" %>
                        </div>
                    </div>

                    <div class="col-3" style="margin-right: 10px;">
                        <div class="card shadow rounded" style="padding: 25px;">
                            <%@ include file="_createDifficulty.jsp" %>
                        </div>
                    </div>

                    <div class="col-3">
                        <div class="card shadow rounded" style="padding: 25px;">
                            <%@ include file="_createTag.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>