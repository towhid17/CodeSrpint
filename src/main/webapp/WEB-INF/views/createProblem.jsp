<%-- @author towhidul.islam @since 8/20/23 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html data-bs-theme="light">
    <head>
        <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    </head>
    <body>
        <div class="container-lg" style="margin-top:20px; display:flex; justify-content: space-between;">
            <div class="shadow col-1 custom_nav sidebar" style="margin-bottom: 50px; height: 862px;">
                <button class="btn btn_sidebar_selected">
                    <img src="${pageContext.request.contextPath}/assets/icons/coding.png" alt="plus"
                         style="width: 25px; height: 25px; margin-right: 10px;"/>
                    <spring:message code="label.problem"/>
                </button>
                <c:choose>
                    <c:when test="${problem.id == null}">
                        <!--
                        <button class="btn btn_sidebar_non_selected">
                            <img src="${pageContext.request.contextPath}/assets/icons/prioritize.png" alt="plus"
                                 style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.example"/>
                        </button>
                        <button class="btn btn_sidebar_non_selected">
                            <img src="${pageContext.request.contextPath}/assets/icons/constraint.png" alt="plus"
                                 style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.constraint"/>
                        </button>
                        <button class="btn btn_sidebar_non_selected">
                            <img src="${pageContext.request.contextPath}/assets/icons/monitor.png" alt="plus"
                                 style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.editorial"/>
                        </button>
                        -->
                    </c:when>
                    <c:otherwise>
                        <a href="/example/add/problem/${problem.id}" class="btn btn_sidebar_non_selected">
                            <img src="${pageContext.request.contextPath}/assets/icons/prioritize.png" alt="plus"
                                 style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.example"/>
                        </a>
                        <a href="/constraint/add/problem/${problem.id}" class="btn btn_sidebar_non_selected">
                            <img src="${pageContext.request.contextPath}/assets/icons/constraint.png" alt="plus"
                                 style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.constraint"/>
                        </a>
                        <a href="/editorial/create/problem/${problem.id}" class="btn btn_sidebar_non_selected">
                            <img src="${pageContext.request.contextPath}/assets/icons/monitor.png" alt="plus"
                                 style="width: 25px; height: 25px; margin-right: 10px;"/>
                            <spring:message code="label.editorial"/>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="col-11" style="display: flex;">
                <div style="margin-right:20px; margin-bottom:50px; width: 72%; height:862px;">
                    <div style="display: flex;">
                        <div class="shadow card" style="border-radius: 0px 10px 10px 0px;">
                            <div class="card-header header_img">
                                <img src="${pageContext.request.contextPath}/assets/icons/page.png" alt="plus"
                                    style="width: 30px; height: 30px; margin-right: 10px;"/>
                                <h5><spring:message code="label.createProblem"/></h5>
                            </div>
                            <div class="card-body">
                                <form:form modelAttribute="problem" action="/problem/save" method="post">
                                    <form:input type="hidden" path="id" value="${problem.id}"/>
                                    <form:input type="hidden" path="version" value="${problem.version}"/>
                                    <form:input type="hidden" path="deleted" value="false"/>
                                    <div class="form-floating mb-3">
                                        <form:input path="title" type="username" class="form-control" id="floatingInput" placeholder="title"/>
                                        <label for="floatingInput"><spring:message code="label.title"/>*</label>
                                        <form:errors path="title" cssClass="error"/>
                                    </div>
                                    <div class="form-floating">
                                        <p><spring:message code="label.description"/>*</p>
                                        <form:textarea path="description" class="form-control" id="descriptionArea" style="height: 200px"/>
                                        <form:errors path="description" cssClass="error"/>
                                    </div>

                                    <hr/>

                                    <div style="display:flex; justify-content: space-around;">
                                        <div class="card" style="border-radius:10px 0px 0px 10px; width: 400px;">
                                            <div class="card-header header_img">
                                                <img src="${pageContext.request.contextPath}/assets/icons/categories.png" alt="plus"
                                                    style="width: 20px; height: 20px; margin-right: 10px;"/>
                                                <h6><spring:message code="label.category"/>*</h6>
                                            </div>
                                            <div class="card-body">
                                                <form:select id="categorySelect" path="category" class="form-select" aria-label="Large select example">
                                                    <c:forEach var="category" items="${categoryList}">
                                                        <form:option data-id="${category.id}" value="${category.name}" label="${category.name}"/>
                                                    </c:forEach>
                                                </form:select>
                                            </div>
                                        </div>

                                        <div class="card" style="border-radius: 0px 10px 10px 0px; width: 400px;">
                                            <div class="card-header header_img">
                                                <img src="${pageContext.request.contextPath}/assets/icons/speedometer.png" alt="plus"
                                                    style="width: 20px; height: 20px; margin-right: 10px;"/>
                                                <h6><spring:message code="label.difficulty"/>*</h6>
                                            </div>
                                            <div class="card-body">
                                                <form:select id="difficultySelect" path="difficulty" class="form-select" aria-label="Large select example">
                                                    <c:forEach var="difficulty" items="${difficultyList}">
                                                        <form:option data-id="${category.id}" value="${difficulty.name}" label="${difficulty.name}"/>
                                                    </c:forEach>
                                                </form:select>
                                            </div>
                                        </div>
                                    </div>

                                    <hr class="blank"/>

                                    <div class="card">
                                        <div class="card-header header_img">
                                            <img src="${pageContext.request.contextPath}/assets/icons/tag.png" alt="plus"
                                                style="width: 20px; height: 20px; margin-right: 10px;"/>
                                            <spring:message code="label.selectTag"/>
                                        </div>
                                        <div class="card-body">
                                            <div class="flex-items">
                                                <c:forEach var="tag" items="${tagList}" varStatus="loop">
                                                    <c:if test="${loop.index lt 4}">
                                                        <c:set var="checked" value="false" />
                                                        <c:forEach var="problemTag" items="${problem.tags}">
                                                            <c:if test="${tag.name == problemTag.name}">
                                                                <c:set var="checked" value="true" />
                                                            </c:if>
                                                        </c:forEach>
                                                        <div class="form-check">
                                                            <form:checkbox data-id="${tag.id}" class="checkbox" path="tags" value="${tag.name}" checked="${checked ? 'true' : ''}" />
                                                            <label class="form-check-label" for="flexCheckDefault">
                                                                <c:out value="${tag.name}"/>
                                                            </label>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <p class="d-inline-flex gap-1">
                                                <a class="cust_collapse" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                                    <spring:message code="label.expand"/>
                                                    <img src="${pageContext.request.contextPath}/assets/icons/down-arrow.png" alt="plus"
                                                        style="width: 20px; height: 20px; margin-right: 10px;"/>
                                                </a>
                                            </p>
                                            <div class="collapse" id="collapseExample">
                                                <div id="tagCollapseContainer" class="flex-items">
                                                    <c:forEach var="tag" items="${tagList}" varStatus="loop">
                                                        <c:if test="${loop.index ge 4}">
                                                            <c:set var="checked" value="false" />
                                                            <c:forEach var="problemTag" items="${problem.tags}">
                                                                <c:if test="${tag.name == problemTag.name}">
                                                                    <c:set var="checked" value="true" />
                                                                </c:if>
                                                            </c:forEach>
                                                            <div class="form-check">
                                                                <form:checkbox data-id="${tag.id}" class="checkbox" path="tags" value="${tag.name}" checked="${checked ? 'true' : ''}" />
                                                                <label class="form-check-label" for="flexCheckDefault">
                                                                    <c:out value="${tag.name}"/>
                                                                </label>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer" id="labelContainer" style="color: gray; font-size: 13px;">
                                            <c:out value="Selected tags:"/> <br/>
                                        </div>
                                    </div>

                                    <hr/>

                                    <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:30px;">
                                        <button type="submit" class="btn btn-outline-primary" id="submit_btn" style="margin-right:10px;">
                                            <spring:message code="label.save"/>
                                            <img src="${pageContext.request.contextPath}/assets/icons/checked.png" alt="plus"
                                                style="width: 20px; height: 20px; margin-left: 10px;"/>
                                        </button>
                                        <c:if test="${problem.id != null}">
                                            <a href="/example/add/problem/${problem.id}" class="btn btn-outline-primary" id="submit_btn">
                                                Next <span style="margin-left: 5px; font-size:10px; color:gray;">Example & Constraint</span>
                                                <img src="${pageContext.request.contextPath}/assets/icons/next-button.png" alt="plus"
                                                    style="width: 20px; height: 20px; margin-left: 10px;"/>
                                            </a>
                                        </c:if>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="width: 28%; height:862px;">
                    <div class="shadow card">
                        <div class="card-header header_img">
                            <img src="${pageContext.request.contextPath}/assets/icons/page.png" alt="plus"
                                style="width: 20px; height: 20px; margin-right: 10px;"/>
                            <h6>Create Category, Difficulty & Tag</h6>
                        </div>
                        <div class="card-body">
                            <%@ include file="_createCategory.jsp" %>
                        </div>

                        <hr/>

                        <div class="card-body">
                            <%@ include file="_createDifficulty.jsp" %>
                        </div>

                        <hr/>

                        <div class="card-body">
                            <%@ include file="_createTag.jsp" %>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const checkboxes = document.querySelectorAll(".checkbox");
                const labelContainer = document.getElementById("labelContainer");

                checkboxes.forEach((checkbox) => {
                    checkbox.addEventListener("change", function () {
                        if (this.checked) {
                            const label = document.createElement("div");
                            label.textContent = this.value;
                            label.classList.add("label");
                            label.classList.add("btn");
                            label.classList.add("btn-outline-secondary");
                            label.setAttribute("disabled", "disabled");
                            labelContainer.appendChild(label);

                        } else {
                            const labels = labelContainer.querySelectorAll(".label");
                            labels.forEach((label) => {
                                if (label.textContent === this.value) {
                                    labelContainer.removeChild(label);
                                }
                            });
                        }
                    });
                });
            });

            tinymce.init({
              selector: '#descriptionArea',
              plugins: 'ai tinycomments mentions anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount checklist mediaembed casechange export formatpainter pageembed permanentpen footnotes advtemplate advtable advcode editimage tableofcontents mergetags powerpaste tinymcespellchecker autocorrect a11ychecker typography inlinecss',
              toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | align lineheight | tinycomments | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
              tinycomments_mode: 'embedded',
              tinycomments_author: 'Author name',
              mergetags_list: [
                { value: 'First.Name', title: 'First Name' },
                { value: 'Email', title: 'Email' },
              ],
              skin: document.querySelector('html').dataset.bsTheme === 'light' ? 'oxide' : 'oxide-dark',
              content_css: document.querySelector('html').dataset.bsTheme === 'light' ? 'default' : 'dark',
              ai_request: (request, respondWith) => respondWith.string(() => Promise.reject("See docs to implement AI Assistant"))
            });
        </script>
    </body>
</html>