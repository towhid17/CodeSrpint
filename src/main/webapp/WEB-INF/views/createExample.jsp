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
        <title>Example</title>
    </head>
    <body>
        <div class="container-lg" style="margin-top:20px; display:flex; justify-content: space-between; position: relative;">
            <!--sidebar-->
            <div class="shadow col-1 custom_nav sidebar" style="height: 100%; position: absolute;">
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
                <button class="btn btn_sidebar_selected" style="margin-top:2px">
                    <img src="${pageContext.request.contextPath}/assets/icons/prioritize.png" alt="plus"
                         style="width: 25px; height: 25px; margin-right: 10px;"/>
                    <spring:message code="label.example"/>
                </button>
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
            </div>

            <div class="col-1"></div>
                
            <div class="col-11 shadow card" style="border-radius: 0px 10px 10px 0px;">
                <div class="card-header header_img">
                    <img src="${pageContext.request.contextPath}/assets/icons/code.png" alt="plus"
                        style="width: 30px; height: 30px; margin-right: 10px;"/>
                    <h5 class="form-floating mb-3" style="margin-top:20px;">
                        <c:out value="Problem: ${problem.title}"></c:out>
                    </h5>
                </div>
                <div style="display: flex; width: 100%; padding: 20px;">
                    <!-- create Example -->
                    <div style="width: 100%; margin-right:20px; margin-bottom: 50px">
                        <div style="display: flex;">
                            <div class="shadow card" style="width: 100%; ">
                                <div class="card-header header_img">
                                    <img src="${pageContext.request.contextPath}/assets/icons/prioritize.png" alt="plus"
                                        style="width: 30px; height: 30px; margin-right: 10px;"/>
                                    <h6><spring:message code="label.addExample"/></h6>
                                </div>
                                
                                <div class="card-body" style="width: 100%;">
                                    <div id="example">
                                        <c:forEach var="exampleItem" items="${exampleList}" varStatus="loop">
                                            
                                            <div class="card-body" style="background-color: rgba(128, 128, 128, 0.108); margin-bottom: 10px; border-radius: 20px;">
                                                <form:form action="/example/remove" method="post">
                                                    <div>
                                                        <div class="input-group flex-nowrap" style="margin-bottom:20px">
                                                            <span class="input-group-text" id="addon-wrapping"><spring:message code="label.input"/></span>
                                                            <pre class="form-control" aria-label="Input" aria-describedby="addon-wrapping" style="margin-bottom: 0px; padding: 5px;"><c:out value="${exampleItem.input}"/></pre>
                                                        </div>
                                                        <div class="input-group flex-nowrap" style="margin-bottom:20px">
                                                            <span class="input-group-text" id="addon-wrapping"><spring:message code="label.output"/></span>
                                                            <pre class="form-control" aria-label="Input" aria-describedby="addon-wrapping" style="margin-bottom: 0px; padding: 5px;"><c:out value="${exampleItem.output}"/></pre>
                                                        </div>

                                                        <input type="hidden" name="exampleId" value="${exampleItem.id}"/>
                                                        <input type="hidden" name="problemId" value="${problem.id}"/>

                                                    </div>
                                                    <div class="card-footer">
                                                        <div style="display:flex; justify-content: center">
                                                            <button type="submit" class="btn btn-outline-danger remove_item_btn">
                                                                <spring:message code="label.remove"/>
                                                                <img src="${pageContext.request.contextPath}/assets/icons/trash.png" alt="plus"
                                                                    style="width: 20px; height: 20px; margin-left: 10px;"/>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form:form>
                                            </div>

                                        </c:forEach>
                                        
                                        <div id="exampleItem" class="shadow card" style="margin-bottom:20px">
                                            <div class="card-body">
                                                <form:form id="ExampleForm" modelAttribute="example" action="/example/add" method="post">
                                                    <div>
                                                        <div class="input-group flex-nowrap" style="margin-bottom:20px">
                                                            <span class="input-group-text" id="addon-wrapping">
                                                                <spring:message code="label.input"/>*
                                                            </span>
                                                            <form:input path="input" type="text" class="form-control" aria-label="Input" aria-describedby="addon-wrapping"/>
                                                            <form:errors path="input" cssClass="error"/>
                                                        </div>
                                                        <div class="input-group flex-nowrap" style="margin-bottom:20px">
                                                            <span class="input-group-text" id="addon-wrapping">
                                                                <spring:message code="label.output"/>*
                                                            </span>
                                                            <form:input path="output" type="text" class="form-control" aria-label="Output" aria-describedby="addon-wrapping"/>
                                                            <form:errors path="output" cssClass="error"/>
                                                        </div>
                                                    </div>
                                                    <div style="display:flex; justify-content: flex-end">
                                                        <button type="submit" class="btn btn-outline-primary add_item_btn">
                                                            <spring:message code="label.addExample"/>
                                                            <img src="${pageContext.request.contextPath}/assets/icons/plus.png" alt="plus"
                                                                style="width: 20px; height: 20px; margin-left: 10px;"/>
                                                        </button>
                                                    </div>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-lg card-footer" style="display:flex; justify-content: flex-end; padding-top:30px;">
            <a href="/problem/save" type="button" class="btn btn-outline-primary" id="submit_btn">
                <img src="${pageContext.request.contextPath}/assets/icons/next-button.png" alt="plus"
                        style="width: 20px; height: 20px; margin-left: 10px; transform: rotate(180deg);"/>
                <spring:message code="label.previous"/> <span style="margin-left: 5px; font-size:10px; color:gray;">Problem</span>
            </a>
            <form action="/problem/save" method="get">
                <input type="hidden" name="problemId" value="${problem.id}"/>
                <button type="submit" class="btn btn-outline-primary" id="submit_btn">
                    <img src="${pageContext.request.contextPath}/assets/icons/next-button.png" alt="plus"
                            style="width: 20px; height: 20px; margin-left: 10px; transform: rotate(180deg);"/>
                    <spring:message code="label.previous"/> <span style="margin-left: 5px; font-size:10px; color:gray;">Problem</span>
                </button>
            </form>
            <a href="/constraint/add/problem/${problem.id}" type="button" class="btn btn-outline-primary" id="submit_btn">
                <spring:message code="label.next"/> <span style="margin-left: 5px; font-size:10px; color:gray;">Constraint</span>
                <img src="${pageContext.request.contextPath}/assets/icons/next-button.png" alt="plus"
                        style="width: 20px; height: 20px; margin-left: 10px;"/>
            </a>
        </div>
    </body>
</html>