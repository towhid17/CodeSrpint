<%-- @author towhidul.islam @since 8/20/23 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html data-bs-theme="light">
    <head>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container-lg" style="display: flex;">
            <c:choose>
                <c:when test="${SESSION_USER == null or SESSION_USER_ROLE == 'MODERATOR' or SESSION_USER_ROLE == 'ADMIN'}">
                    <div class="col-12" style="padding-right: 20px;">
                </c:when>
                <c:otherwise>
                    <div class="col-9" style="padding-right: 20px;">
                </c:otherwise>
            </c:choose>
                <div class="card" style="margin-top: 20px;">
                    <div class="card-header" style="display:flex; justify-content:space-between;">
                        <div>
                            <img src="${pageContext.request.contextPath}/assets/icons/select1.png" alt="plus"
                                             style="width: 20px; height: 20px; margin-right: 10px;"/>
                            <spring:message code="label.navigateProblem"/>
                        </div>
                    </div>
                    <div style="padding: 20px;">
                        <!-- tags -->
                        <div class="card" style="border:0px;">
                            <div class="card-header" style="font-size:14px;">
                                <img src="${pageContext.request.contextPath}/assets/icons/tag.png" alt="plus"
                                            style="width: 20px; height: 20px; margin-right: 10px;"/>
                                <spring:message code="label.tag"/>
                            </div>
                            <div class="flex-items" style="margin-left: 20px; margin-top: 10px;">
                                <c:forEach items="${tagList}" var="tag" varStatus="loop">
                                    <c:if test="${loop.index lt 8}">
                                        <a class="cust_collapse" style="text-decoration:none;" href="/problem/list/tag/${tag.name}">
                                            <c:out value="${tag.name}"/>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <p class="d-inline-flex gap-1">
                                    <a class="cust_collapse" style="text-decoration:none;" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                        <spring:message code="label.expand"/>
                                        <img src="${pageContext.request.contextPath}/assets/icons/down-arrow.png" alt="plus"
                                            style="width: 20px; height: 20px; margin-right: 10px;"/>
                                    </a>
                                </p>
                            </div>

                            <div class="collapse" id="collapseExample" style="padding: 20px;">
                                <div class="flex-items">
                                    <c:forEach items="${tagList}" var="tag" varStatus="loop">
                                        <c:if test="${loop.index ge 8}">
                                            <a class="cust_collapse" style="text-decoration: none;" href="/problem/list/tag/${tag.name}">
                                                <c:out value="${tag.name}"/>
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- category -->
                        <div class="card" style="border:0px; margin-top:5px;">
                            <div class="card-header" style="font-size:14px;">
                                <img src="${pageContext.request.contextPath}/assets/icons/categories.png" alt="plus"
                                            style="width: 20px; height: 20px; margin-right: 10px;"/>
                                <spring:message code="label.category"/>
                            </div>
                            <div class="card-body">
                                <div id="carouselExampleFade" class="carousel slide">
                                    <div class="carousel-inner" style="width: 80%; margin-left:10%;">
                                        <div class="carousel-item active">
                                            <c:forEach items="${categoryList}" var="category" varStatus="loop">
                                                <c:if test="${loop.index lt 5}">
                                                    <a style="text-decoration:none;" href="/problem/list/category/${category.name}">
                                                        <button type="button" class="category">
                                                            <c:out value="${category.name}"/>
                                                        </button>
                                                    </a>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <c:if test="${categoryList.size() gt 5}">
                                            <c:forEach begin="5" end="${categoryList.size() - 1}" step="5" var="outerIndex" varStatus="loop">
                                                <div class="carousel-item">
                                                    <c:forEach begin="${outerIndex}" end="${Math.min(outerIndex + 4, categoryList.size() - 1)}" var="innerIndex">
                                                        <a style="text-decoration:none;" href="/problem/list/category/${categoryList[innerIndex].name}">
                                                            <button type="button" class="category">
                                                                <c:out value="${categoryList[innerIndex].name}"/>
                                                            </button>
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
                                    <span style="color: blueviolet;"> << </span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
                                    <span style="color: blueviolet;"> >> </span>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <hr style="margin-top:0px;"/>

                        <div style="display: flex; margin-bottom: 15px; margin-left: 30px;">
                            <div class="dropdown" style="margin-right: 10px;">
                                <a class="btn btn-secondary dropdown-toggle cust_dropdown" href="#" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    <spring:message code="label.difficulty"/>
                                </a>

                                <ul class="dropdown-menu">
                                    <c:forEach items="${difficultyList}" var="difficulty">
                                        <li>
                                            <a class="dropdown-item" href="/problem/list/difficulty/${difficulty.name}"><c:out value="${difficulty.name}"/></a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <c:if test="${SESSION_USER_ROLE == 'USER'}">
                                <div class="dropdown" style="margin-right: 10px;">
                                    <a class="btn btn-secondary dropdown-toggle cust_dropdown" href="#" role="button"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <spring:message code="label.status"/>
                                    </a>

                                    <ul class="dropdown-menu ">
                                        <li>
                                            <form action="/problem/list/status" method="post">
                                                <input type="hidden" name="status" value="Accepted"/>
                                                <button class="dropdown-item" type="submit" class="dropdown-item">Accepted</button>
                                            </form>
                                        </li>
                                        <li>
                                            <form action="/problem/list/status" method="post">
                                                <input type="hidden" name="status" value="Attempted"/>
                                                <button class="dropdown-item" type="submit" class="dropdown-item">Attempted</button>
                                            </form>
                                        </li>
                                        <li>
                                            <form action="/problem/list/status" method="post">
                                                <input type="hidden" name="status" value="NotAttempted"/>
                                                <button class="dropdown-item" type="submit" class="dropdown-item">Not Attempted</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>
                        </div>

                        <!-- table -->
                        <div class="shadow card">
                            <div class="card-header" style="display:flex; justify-content:space-between; font-size: 18px;">
                                <div>
                                    <img src="${pageContext.request.contextPath}/assets/icons/code.png" alt="plus"
                                             style="width: 20px; height: 20px; margin-right: 10px;"/>
                                    <spring:message code="label.problems"/>
                                </div>
                                <c:if test="${SESSION_USER_ROLE == 'ADMIN'}">
                                    <a type="button"
                                       class="btn btn-outline-primary"
                                       href="/problem/save">

                                        <spring:message code="label.createProblem"/>
                                        <img src="${pageContext.request.contextPath}/assets/icons/plus.png" alt="plus"
                                            style="width: 20px; height: 15px; margin-left: 10px;"/>
                                    </a>
                                </c:if>
                            </div>

                            <div class="card-body">
                                <div class="rounded" style="width:100%; border-radius: 30px; font-size:12px;">
                                    <table id="example" style="width: 100%;">
                                        <thead class="col-centered">
                                            <tr class="card-header">
                                                <c:if test="${SESSION_USER_ROLE == 'USER'}">
                                                    <th> <p class="table_th">Status</p></th>
                                                </c:if>
                                                <th> <p class="table_th">Title</p></th>
                                                <th> <p class="table_th">Category</p></th>
                                                <th> <p class="table_th">Acceptance</p></th>
                                                <th> <p class="table_th">Difficulty</p></th>
                                                <c:if test="${SESSION_USER_ROLE == 'ADMIN'}">
                                                    <th> <p class="table_th">Action</p></th>
                                                </c:if>
                                            </tr>
                                        </thead>

                                        <tbody class="col-centered">
                                            <c:forEach items="${problemList}" var="problem">
                                                <c:choose>
                                                    <c:when test="${(SESSION_USER_ROLE == 'USER' or SESSION_USER_ROLE == 'MODERATOR') and problem.deleted == true}">
                                                    </c:when>

                                                    <c:otherwise>
                                                        <tr class="table_row">
                                                            <c:if test="${SESSION_USER_ROLE == 'USER'}">
                                                                <td class="col-1">
                                                                    <div class="btn-diff-${problem.currentUserSubmissionStatus}">
                                                                        <c:out value="${problem.currentUserSubmissionStatus}"/>
                                                                    </div>
                                                                </td>
                                                            </c:if>
                                                            <td class="col-4">
                                                                <a style="text-decoration:none;" href="${pageContext.request.contextPath}/problem/${problem.id}">
                                                                    <c:out value="${problem.id}. ${problem.title}" />
                                                                </a>
                                                            </td>
                                                            <td class="col-2">
                                                                <c:out value="${problem.category.name}" />
                                                            </td>
                                                            <td class="col-2">
                                                                <div style="font-size: 13px;">
                                                                    <c:out value="${problem.acceptanceRate}%" />
                                                                </div>
                                                            </td>
                                                            <td class="col-2">
                                                                <div class="btn-diff-${problem.difficulty.name}">
                                                                    <c:out value="${problem.difficulty.name}" />
                                                                </div>
                                                            </td>
                                                            <c:if test="${SESSION_USER_ROLE == 'ADMIN'}">
                                                                <td class="col-2">
                                                                    <div class="flex-center">
                                                                        <c:choose>
                                                                            <c:when test="${problem.deleted == true}">
                                                                                <div class="deleted">
                                                                                    <spring:message code="label.deleted"/>
                                                                                </div>
                                                                                <button type="button"
                                                                                        class="btn btn-outline-info table_element_action"
                                                                                        data-bs-toggle="modal"
                                                                                        data-bs-target="#staticBackdrop_problem_undo"
                                                                                        data-title="${problem.title}"
                                                                                        data-id="${problem.id}">
                                                                                        <img src="${pageContext.request.contextPath}/assets/icons/undo.png" alt="plus"
                                                                                            class="table_element_action_img"/>
                                                                                </button>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <form action="/problem/save" method="get" style="margin-bottom: 0px;">
                                                                                  <input type="hidden" name="problemId" value="${problem.id}">
                                                                                  <button class="btn btn-outline-info table_element_action" type="submit">
                                                                                    <img src="${pageContext.request.contextPath}/assets/icons/edit.png" alt="edit"
                                                                                        class="table_element_action_img"/>
                                                                                  </button>
                                                                                </form>
                                                                                <button type="button"
                                                                                        class="btn btn-outline-danger table_element_action"
                                                                                        data-bs-toggle="modal"
                                                                                        data-bs-target="#staticBackdrop_problem_delete"
                                                                                        data-title="${problem.title}"
                                                                                        data-id="${problem.id}">

                                                                                        <img src="${pageContext.request.contextPath}/assets/icons/trash.png" alt="plus"
                                                                                            class="table_element_action_img"/>
                                                                                </button>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </td>
                                                            </c:if>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- session -->
            <c:if test="${SESSION_USER != null and SESSION_USER_ROLE == 'USER'}">
                <div id="userHistoryContainer" class="col-3" style="margin-top:20px;">
                    <div class="rounded shadow">
                        <div class="card">
                            <div class="card-header">
                                <h6><spring:message code="label.activeSession"/></h6>
                            </div>
                            <div class="card-body">
                                <div style="display:flex;">
                                    <img src="${pageContext.request.contextPath}/assets/icons/user.png" alt="plus"
                                                 style="width: 20px; height: 20px; margin-right: 10px;"/>
                                    <c:out value="${SESSION_USER.userName}" />
                                </div>
                                <hr/>
                                <div>
                                    <input id="totalProblem" type="hidden" value="${userHistoryDto.totalProblems}"/>
                                    <input id="easyProblem" type="hidden" value="${userHistoryDto.totalEasyProblems}"/>
                                    <input id="mediumProblem" type="hidden" value="${userHistoryDto.totalMediumProblems}"/>
                                    <input id="hardProblem" type="hidden" value="${userHistoryDto.totalHardProblems}"/>

                                    <input id="totalAccepted" type="hidden" value="${userHistoryDto.totalProblemsAccepted}"/>
                                    <input id="easyAccepted" type="hidden" value="${userHistoryDto.totalEasyProblemsAccepted}"/>
                                    <input id="mediumAccepted" type="hidden" value="${userHistoryDto.totalMediumProblemsAccepted}"/>
                                    <input id="hardAccepted" type="hidden" value="${userHistoryDto.totalHardProblemsAccepted}"/>

                                    <p style="font-size: 11px; margin-bottom: 0px;">
                                        <spring:message code="label.totalProblems_accepted"/> (<c:out value="${userHistoryDto.totalProblems}/${userHistoryDto.totalProblemsAccepted}"/>)
                                    </p>
                                    <div id="Progress_Status">
                                      <div id="progressBarTotal"></div>
                                    </div>

                                    <p style="font-size: 11px; margin-bottom: 0px;">
                                        <spring:message code="label.easyProblems_accepted"/> (<c:out value="${userHistoryDto.totalEasyProblems}/${userHistoryDto.totalEasyProblemsAccepted}"/>)
                                    </p>
                                    <div id="Progress_Status">
                                      <div id="progressBarEasy"></div>
                                    </div>

                                    <p style="font-size: 11px; margin-bottom: 0px;">
                                        <spring:message code="label.mediumProblems_accepted"/> (<c:out value="${userHistoryDto.totalMediumProblems}/${userHistoryDto.totalMediumProblemsAccepted}"/>)
                                    </p>
                                    <div id="Progress_Status">
                                      <div id="progressBarMedium"></div>
                                    </div>

                                    <p style="font-size: 11px; margin-bottom: 0px;">
                                        <spring:message code="label.hardProblems_accepted"/> (<c:out value="${userHistoryDto.totalHardProblems}/${userHistoryDto.totalHardProblemsAccepted}"/>)
                                    </p>
                                    <div id="Progress_Status">
                                      <div id="progressBarHard"></div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <div class="modal fade" id="staticBackdrop_problem_delete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Delete Problem</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="${pageContext.request.contextPath}/problem/delete">
                            <div class="form-floating mb-3">
                                <input id="problemIdInput" type="hidden" name="problemId" value=""/>
                                <input id="deleted" type="hidden" name="deleted" value="true"/>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemTitleInModal" placeholder="Problem" disabled/>
                                <label for="floatingInput">Problem</label>
                            </div>
                            <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                <button id="deleteProblemBtn" type="submit" class="btn btn-outline-danger" id="submit_btn">
                                    <spring:message code="label.delete"/>
                                    <img src="${pageContext.request.contextPath}/assets/icons/trash.png" alt="plus"
                                        style="width: 20px; height: 20px; margin-left: 10px;"/>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="staticBackdrop_problem_undo" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Activate Problem</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="${pageContext.request.contextPath}/problem/delete">
                            <div class="form-floating mb-3">
                                <input id="problemIdInput" type="hidden" name="problemId" value=""/>
                                <input id="deleted" type="hidden" name="deleted" value="false"/>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemTitleInModal" placeholder="Problem" disabled/>
                                <label for="floatingInput">Problem</label>
                            </div>
                            <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                <button id="deleteProblemBtn" type="submit" class="btn btn-outline-info" id="submit_btn">
                                    <spring:message code="label.undo"/>
                                    <img src="${pageContext.request.contextPath}/assets/icons/undo.png" alt="plus"
                                        style="width: 20px; height: 20px; margin-left: 10px;"/>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script>new DataTable('#example');</script>

        <script>
            function setProblemModalData(modal) {
                modal.addEventListener("show.bs.modal", function (event) {
                    var button = event.relatedTarget;

                    var problemTitleInModal = modal.querySelector("#problemTitleInModal");
                    problemTitleInModal.value = button.getAttribute("data-id")+ ". " + button.getAttribute("data-title");

                    var problemIdInput = modal.querySelector("#problemIdInput");
                    problemIdInput.value = button.getAttribute("data-id");
                });
            }

            document.addEventListener("DOMContentLoaded", function () {
                var modalProblemDeleted = document.getElementById("staticBackdrop_problem_delete");
                var modalProblemUndo = document.getElementById("staticBackdrop_problem_undo");

                setProblemModalData(modalProblemDeleted);
                setProblemModalData(modalProblemUndo);

                var userHistoryContainer = document.getElementById("userHistoryContainer");
                if (userHistoryContainer != null) {
                    function update(width, id) {
                      var element = document.getElementById(id);
                      element.style.width = width + '%';
                    }

                    var totalProblem = document.getElementById("totalProblem").value;
                    var easyProblem = document.getElementById("easyProblem").value;
                    var mediumProblem = document.getElementById("mediumProblem").value;
                    var hardProblem = document.getElementById("hardProblem").value;

                    var totalAccepted = document.getElementById("totalAccepted").value;
                    var easyAccepted = document.getElementById("easyAccepted").value;
                    var mediumAccepted = document.getElementById("mediumAccepted").value;
                    var hardAccepted = document.getElementById("hardAccepted").value;

                    var totalProgress = (totalAccepted / totalProblem) * 100;
                    var easyProgress = (easyAccepted / easyProblem) * 100;
                    var mediumProgress = (mediumAccepted / mediumProblem) * 100;
                    var hardProgress = (hardAccepted / hardProblem) * 100;

                    update(totalProgress, "progressBarTotal");
                    update(easyProgress, "progressBarEasy");
                    update(mediumProgress, "progressBarMedium");
                    update(hardProgress, "progressBarHard");
                }

                const categories = document.querySelectorAll(".category");

                categories.forEach(function (category) {
                    category.addEventListener("click", function () {
                        categories.forEach(function (button) {
                            if(button!==this) {
                                button.classList.remove("category-active");
                            }
                        });
                    this.classList.add("category-active");
                  });
                });

                spinnerStop();
            });
        </script>
    </body>
</html>