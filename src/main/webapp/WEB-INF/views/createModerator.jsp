<%-- @author towhidul.islam @since 8/20/23 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html data-bs-theme="light">
    <body>
        <div class="container-lg" style="margin-top:20px; display:flex; justify-content: space-between">
            <div class="col-4 shadow custom_nav sidebar">
                <div class="signup_sidebar_btn">
                    <button class="btn btn_sidebar_selected" style="width: 40%;">
                        <img src="${pageContext.request.contextPath}/assets/icons/signup.png" alt="plus"
                            style="width: 25px; height: 25px; margin-right: 10px;"/>
                        <spring:message code="label.createModerator"/>
                    </button>
                </div>

                <div style="display: flex; justify-content: center; align-items: center; margin-top: 50px;">
                    <img src="${pageContext.request.contextPath}/assets/icons/add-user.png" alt="plus"
                         style="width: 250px; height: 250px; margin-right: 10px;"/>
                </div>
            </div>
            
            <div class="col-8" style="margin-right:20px; margin-bottom: 50px">
                <div style="display: flex;">
                    <div class="shadow card" style="width: 100%; border-radius: 0px 10px 10px 0px;">
                        <div class="card-header header_img">
                            <img src="${pageContext.request.contextPath}/assets/icons/signup.png" alt="plus"
                                 style="width: 30px; height: 30px; margin-right: 10px;"/>
                            <h5><spring:message code="label.addNewModerator"/></h5>
                        </div>
                        <div class="card-body" style="display: flex; justify-content: center;">
                            <form:form modelAttribute="moderator" action="/moderator/create" method="post" style="width: 70%;">
                                <div class="form-floating mb-3">
                                    <form:input type="Username" path="userName" class="form-control" id="floatingInput" placeholder="Username"/>
                                    <label for="floatingInput"><spring:message code="label.userName"/>*</label>
                                    <form:errors path="userName" cssClass="error"/>
                                </div>
                                <div class="form-floating mb-3">
                                    <form:input type="password" path="password" class="form-control" id="floatingInput" placeholder="Password"/>
                                    <label for="floatingInput"><spring:message code="label.password"/>*</label>
                                    <form:errors path="password" cssClass="error"/>
                                </div>
                                <!--
                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" id="floatingInput" placeholder="Confirm">
                                    <label for="floatingInput"><spring:message code="label.confirmPassword"/>*</label>
                                </div>
                                -->
                                <div class="form-floating mb-3">
                                    <form:input type="email" path="email" class="form-control" id="floatingInput" placeholder="name@example.com"/>
                                    <label for="floatingInput"><spring:message code="label.email"/>*</label>
                                    <form:errors path="email" cssClass="error"/>
                                </div>
                                <div class="form-floating mb-3">
                                    <form:input type="date" path="dob" class="form-control" id="floatingInput" placeholder="DOB"/>
                                    <label for="floatingInput"><spring:message code="label.dob"/>*</label>
                                    <form:errors path="dob" cssClass="error"/>
                                </div>
                                <div class="form-floating mb-3">
                                    <form:input type="text" path="fullName" class="form-control" id="floatingInput" placeholder="Full name"/>
                                    <label for="floatingInput"><spring:message code="label.fullName"/>*</label>
                                    <form:errors path="fullName" cssClass="error"/>
                                </div>

                                <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:30px;">
                                    <button type="submit" class="btn btn-outline-primary" id="submit_btn">
                                        <spring:message code="label.submit"/>
                                        <img src="${pageContext.request.contextPath}/assets/icons/next-button.png" alt="plus"
                                                style="width: 20px; height: 20px; margin-left: 10px;"/>
                                    </button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>