<%-- @author towhidul.islam @since 8/20/23 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<html data-bs-theme="light">
    <head>
        <meta charset="UTF-8" />
        <title>Editorial</title>
        <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    </head>
    <body>
        <div class="container-lg" style="margin-top:20px; display:flex; justify-content: space-between">
            <!--sidebar-->
            <div class="shadow col-1 custom_nav sidebar">
                <form action="/problem/save" method="get">
                    <input type="hidden" name="problemId" value="${problem.id}"/>
                    <button type="submit"
                            class="btn btn_sidebar_non_selected"
                            style="margin-top: 50px;">
                        <img src="${pageContext.request.contextPath}/assets/icons/coding.png" alt="plus"
                             style="width: 25px; height: 25px; margin-right: 10px;"/>
                        <spring:message code="label.problem"/>
                    </button>
                </form>
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
                <button class="btn btn_sidebar_selected" style="margin-top:2px">
                    <img src="${pageContext.request.contextPath}/assets/icons/monitor.png" alt="plus"
                         style="width: 25px; height: 25px; margin-right: 10px;"/>
                    <spring:message code="label.editorial"/>
                </button>
            </div>

            <!-- create problem -->
            <div class="col-11" style="margin-right:20px; margin-bottom: 50px">
                <div style="display: flex;">
                    <div class="shadow card" style="width: 100%; border-radius: 0px 10px 10px 0px;">
                        <div class="card-header header_img">
                            <img src="${pageContext.request.contextPath}/assets/icons/code.png" alt="plus"
                                style="width: 30px; height: 30px; margin-right: 10px;"/>
                            <h5 class="form-floating mb-3" style="margin-top:20px;">
                                <c:out value="Problem: ${problem.title}"></c:out>
                            </h5>
                            <hr/>
                        </div>
                        <div class="card-body">
                            <div class="card-header">
                                <h6><spring:message code="label.addEditorial"/></h6>
                            </div>
                            <form:form modelAttribute="editorial" action="/editorial/add" method="post">
                                <form:input type="hidden" path="id" value="${editorial.id}"/>
                                <form:input type="hidden" path="version" value="${editorial.version}"/>
                                <div class="form-floating">
                                    <form:textarea id="editorialDescription" path="description" class="form-control" style="height: 500px"/>
                                    <form:errors path="description" cssClass="error"/>
                                </div>

                                <hr/>

                                <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:30px;">
                                    <a href="/constraint/add/problem/${problem.id}" type="button" class="btn btn-outline-primary" id="submit_btn">
                                        <img src="${pageContext.request.contextPath}/assets/icons/next-button.png" alt="plus"
                                                style="width: 20px; height: 20px; margin-left: 10px; transform: rotate(180deg);"/>
                                        <spring:message code="label.previous"/> <span style="margin-left: 5px; font-size:10px; color:gray;">Constraint</span>
                                    </a>
                                    <button type="submit" class="btn btn-outline-primary" id="submit_btn">
                                        <spring:message code="label.save"/>
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

        <script>
            tinymce.init({
              selector: 'textarea',
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