<%--
  @author towhidul.islam
  @since 8/20/23
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css"/>
        <script defer src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top custom_nav shadow" style="padding:0px;">
            <c:choose>
                <c:when test="${tabMode != null}">
                    <div class="container-fluid">
                </c:when>
                <c:otherwise>
                    <div class="container-lg">
                </c:otherwise>
            </c:choose>
                <img src="${pageContext.request.contextPath}/assets/icons/logo.png"
                    alt="Logo"
                    width="30"
                    height="30"
                    class="d-inline-block align-text-top"/>
                <a class="navbar-brand"
                    style="cursor: pointer; color: #fff; margin-left: 10px;"
                    href="/problem/list">
                    CodeSprint
                </a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item" id="nav_problem" style="padding:0px;">
                        <c:choose>
                            <c:when test="${currentTab == 'problem'}">
                                <a class="nav-link selected_nav_item" aria-current="page" href=""><spring:message code="label.problem"/></a>
                            </c:when>
                            <c:otherwise>
                                <a class="nav-link non_selected_nav_item" aria-current="page" href="/problem/list"><spring:message code="label.problem"/></a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <c:if test="${sessionScope.SESSION_USER != null}">
                        <c:choose>
                            <c:when test="${SESSION_USER_ROLE eq 'MODERATOR' or SESSION_USER_ROLE eq 'USER'}">
                                <li class="nav-item" id="nav_submission">
                                    <c:choose>
                                        <c:when test="${currentTab == 'submission'}">
                                            <a class="nav-link selected_nav_item" aria-current="page" href=""><spring:message code="label.submission"/></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="nav-link non_selected_nav_item" aria-current="page" href="/submission/list"><spring:message code="label.submission"/></a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:when>
                            <c:when test="${SESSION_USER_ROLE eq 'ADMIN'}">
                                <li class="nav-item" id="nav_moderator">
                                    <c:choose>
                                        <c:when test="${currentTab == 'moderator'}">
                                            <a class="nav-link selected_nav_item" aria-current="page" href=""><spring:message code="label.moderator"/></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="nav-link non_selected_nav_item" aria-current="page" href="/moderator/list"><spring:message code="label.moderator"/></a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="nan-item" id="nav_attribute">
                                    <c:choose>
                                        <c:when test="${currentTab == 'attribute'}">
                                            <a class="nav-link selected_nav_item" aria-current="page" href=""><spring:message code="label.attribute"/></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="nav-link non_selected_nav_item" aria-current="page" href="/attribute"><spring:message code="label.attribute"/></a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:when>
                        </c:choose>
                    </c:if>
                </ul>
                <form class="d-flex" style="margin-bottom: 0px;">
                    <div id="navbarScroll" class="d-flex">
                        <div class="dropdown">
                            <button class="btn btn-outline-light dropdown-toggle"
                                    type="button"
                                    id="dropdownMenuButton1"
                                    data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    <img src="${pageContext.request.contextPath}/assets/icons/user.png"
                                        alt="user"
                                        width="20"
                                        height="20"
                                        class="d-inline-block align-text-top"/>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-lg-end shadow" aria-labelledby="dropdownMenuButton1" style="min-width: 300px;">
                                <c:choose>
                                    <c:when test="${sessionScope.SESSION_USER != null}">
                                        <li>
                                            <a class="dropdown-item" style="font-size:18; font-weight: bold;"
                                               href="">
                                                ${SESSION_USER.userName}
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <div style="display: flex; margin-left: 15px; padding: 10px;">
                                                <spring:message code="label.appearance"/>
                                                <div class="form-check form-switch mx-4">
                                                    <input id="switch-theme"
                                                           class="form-check-input p-2"
                                                           type="checkbox"
                                                           role="switch"
                                                           onclick="switchTheme()"/>
                                                </div>
                                            </div>
                                        </li>
                                        <li>
                                            <a class="dropdown-item"
                                               href="/logout">
                                                <div style="display:flex; padding: 10px;">
                                                    <img src="${pageContext.request.contextPath}/assets/icons/logout.png"
                                                        alt="user"
                                                        width="20"
                                                        height="20"
                                                        class="d-inline-block align-text-top"
                                                        style="margin-right: 10px;"/>
                                                    <spring:message code="label.logout"/>
                                                </div>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <div style="display: flex; margin-left: 15px;">
                                                <spring:message code="label.appearance"/>
                                                <div class="form-check form-switch mx-4">
                                                    <input id="switch-theme"
                                                           class="form-check-input p-2"
                                                           type="checkbox"
                                                           role="switch"
                                                           onclick="switchTheme()"/>
                                                </div>
                                            </div>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item"
                                               href="/login">
                                                <div style="display:flex; padding: 10px;">
                                                    <img src="${pageContext.request.contextPath}/assets/icons/login.png"
                                                        alt="user"
                                                        width="20"
                                                        height="20"
                                                        class="d-inline-block align-text-top"
                                                        style="margin-right: 10px;"/>
                                                    <spring:message code="label.login"/>
                                                </div>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </form>
              </div>
            </div>
        </nav>

        <script>
            function switchThemeOfEditor() {
                var element = document.body;

                if (editor != null) {
                    if (element.dataset.bsTheme == "dark") {
                        editor.setTheme("ace/theme/monokai");

                    } else {
                        editor.setTheme("ace/theme/clouds");
                    }
                }
            }

            function switchTheme() {
                var element = document.body;
                element.dataset.bsTheme = (element.dataset.bsTheme == "dark" ? "light" : "dark");

                switchThemeOfEditor();
            }
        </script>
    </body>
</html>