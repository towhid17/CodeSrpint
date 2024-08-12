<%-- @author towhidul.islam @since 8/20/23 --%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html data-bs-theme="light">
    <head>
        <meta charset="UTF-8" />
    </head>

    <body>
        <div class="container-lg" style="margin-top:20px; display:flex; justify-content: space-between; position: relative;">
            
            <div class="col-4 shadow custom_nav sidebar" style="height: 100%; position: absolute; height: 600px;">
                <div>
                    <div class="signup_sidebar_btn">
                        <button class="btn btn_sidebar_selected" style="width: 40%;">
                            <img src="${pageContext.request.contextPath}/assets/icons/login.png" alt="plus"
                                style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.login"/>
                        </button>
                        <a href="/signup" class="btn btn_sidebar_non_selected" style="width: 40%;">
                            <img src="${pageContext.request.contextPath}/assets/icons/signup.png" alt="plus"
                                style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.signUp"/>
                        </a>
                    </div>

                    <div style="display: flex; justify-content: center; align-items: center; margin-top: 50px;">
                        <img src="${pageContext.request.contextPath}/assets/icons/login.png" alt="plus"
                            style="width: 150px; height: 150px; margin-right: 10px;"/>
                    </div>
                </div>
            </div>

            <div class="col-4"></div>
            
            <div class="col-8" style="margin-right:20px; margin-bottom: 50px; height: 600px;">
                <div style="display: flex;">
                    <div class="shadow card" style="width: 100%; height: 600px; border-radius: 0px 10px 10px 0px;">
                        <div class="card-header header_img">
                            <img src="${pageContext.request.contextPath}/assets/icons/login.png" alt="plus"
                                 style="width: 30px; height: 30px; margin-right: 10px;"/>
                            <h5>Login</h5>
                        </div>
                        <div class="card-body" style="display: flex; justify-content: center;">
                            <form action="login" method="post" style="width: 70%;">
                                <div class="form-floating mb-3">
                                    <input type="Username" name="userName" class="form-control" id="floatingInput" placeholder="Username">
                                    <label for="floatingInput"><spring:message code="label.userName"/>*</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="password" name="password" class="form-control" id="floatingInput" placeholder="Password">
                                    <label for="floatingInput"><spring:message code="label.password"/>*</label>
                                </div>
                                <c:if test="${not empty error}">
                                    <p style="color: red;">${error}</p>
                                </c:if>
                                <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:30px;">
                                    <button type="submit" class="btn btn-outline-primary" id="submit_btn">
                                        <spring:message code="label.login"/>
                                        <img src="${pageContext.request.contextPath}/assets/icons/next-button.png" alt="plus"
                                             style="width: 20px; height: 20px; margin-left: 10px;"/>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>    
    </body>
</html>