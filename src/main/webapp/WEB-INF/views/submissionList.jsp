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
        <title>Submissions</title>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container-fluid" style="display: flex; justify-content: center; padding: 20px;">
            <div class="col-8" style="margin-right: 20px;">
                <div class="shadow card" style="min-height: 850px;">
                    <div class="card-header" style="display:flex; justify-content:space-between">
                        <div>
                            <img src="${pageContext.request.contextPath}/assets/icons/coding.png" alt="plus"
                                     style="width: 20px; height: 20px; margin-right: 10px;"/>
                            <c:choose>
                                <c:when test="${SESSION_USER_ROLE == 'MODERATOR'}">
                                    <c:out value="Pending Submissions"/>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="Submissions"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="card-body" style="font-size:12px;">
                        <c:if test="${not empty error}">
                            <input type="hidden" id="errorMessage" value="${error}"/>
                            <c:remove var="error" scope="session"/>
                        </c:if>

                        <table id="submissionProblems" 
                               style="width: 100%;">
                            <thead class="col-centered">
                                <tr class="table_header">
                                    <th> <p class="table_th"><c:out value=""/></p></th>
                                    <th> <p class="table_th"> <c:out value="Submission Date"/></p></th>
                                    <th> <p class="table_th"> <c:out value="Problem"/></p></th>
                                    <c:if test="${SESSION_USER_ROLE == 'MODERATOR'}">
                                        <th> <p class="table_th"> <c:out value="User"/></p></th>
                                    </c:if>
                                    <th> <p class="table_th"> <c:out value="Script"/> </p></th>
                                    <c:choose>
                                        <c:when test="${SESSION_USER_ROLE == 'MODERATOR'}">
                                            <th> <p class="table_th"> <c:out value="Action"/> </p></th>
                                        </c:when>
                                        <c:otherwise>
                                            <th> <p class="table_th"> <c:out value="Verdict"/> </p></th>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </thead>
                            <tbody class="col-centered">
                                <c:forEach var="problemSubmission" items="${submissionList}" varStatus="loop">
                                    <tr class="table_row">
                                        <td class="col-1"><c:out value="${loop.index + 1}"/></td>
                                        <td class="col-2"><c:out value="${fn:substring(problemSubmission.submissionDate, 0, 11)}"/></td>
                                        <td class="col-3">
                                            <a class="download" href="/problem/${problemSubmission.problem.id}">
                                                <c:out value="${problemSubmission.problem.title}"/>
                                            </a>
                                        </td>
                                        <c:if test="${SESSION_USER_ROLE == 'MODERATOR'}">
                                            <td class="col-1"><c:out value="${problemSubmission.user.userName}"/></td>
                                        </c:if>
                                        <td class="col-3">
                                            <button class="download" type="button" onclick="loadCodeInEditor(`${problemSubmission.id}`)">
                                                <c:out value="Script_${problemSubmission.id}"/>
                                            </button>
                                            <a class="download" href="/submission/download/${problemSubmission.id}">
                                                <img src="${pageContext.request.contextPath}/assets/icons/download.png" alt="plus"
                                                    style="width: 20px; height: 20px; margin-right: 10px;"/>
                                            </a>
                                        </td>
                                        <c:choose>
                                            <c:when test="${SESSION_USER_ROLE == 'MODERATOR'}">
                                                <td class="col-2">
                                                    <div class="flex-center">
                                                        <button type="button" class="btn btn-outline-primary table_element_action" data-bs-toggle="modal" data-bs-target="#staticBackdrop_submission_approve"
                                                                data-id="${problemSubmission.id}"
                                                                data-title="${problemSubmission.problem.title}"
                                                                data-user="${problemSubmission.user.userName}"
                                                                data-date="${problemSubmission.submissionDate}">
                                                            <img src="${pageContext.request.contextPath}/assets/icons/approve.png" alt="plus"
                                                                 class="table_element_action_img"/>
                                                        </button>
                                                        <button type="button" class="btn btn-outline-danger table_element_action" data-bs-toggle="modal" data-bs-target="#staticBackdrop_submission_reject"
                                                                data-id="${problemSubmission.id}"
                                                                data-title="${problemSubmission.problem.title}"
                                                                data-user="${problemSubmission.user.userName}"
                                                                data-date="${problemSubmission.submissionDate}">
                                                            <img src="${pageContext.request.contextPath}/assets/icons/reject.png" alt="plus"
                                                                 class="table_element_action_img"/>
                                                        </button>
                                                    </div>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td class="col-3">
                                                    <div class="btn-diff-${problemSubmission.status}">
                                                        <c:out value="${problemSubmission.status}"/>
                                                    </div>
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-4">
                <div class="shadow card">
                    <div class="card-header">
                        <c:out value="Code Editor: Java"/>
                    </div>
                    <div class="card-body">
                        <textarea name="code"><c:out value="public class Submitted {public static void main(String[] args) throws Exception {System.out.print(\"Hello world\");}}"/></textarea>
                        <div id="editor" style="height: 450px; border-radius:10px"></div>
                    </div>
                    <div class="card-footer" style="display: flex;">
                        <button class="btn btn-outline-info" type="button" onclick="runCode()">
                            <img src="${pageContext.request.contextPath}/assets/icons/play.png" alt="plus"
                                 style="width: 25px; height: 25px;"/>
                        </button>
                        <p class="d-inline-flex gap-1" style="margin-left: 10px">
                          <a id="outputBtn" class="cust_collapse" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOutput" aria-expanded="false" aria-controls="collapseOutput">
                            Output
                            <img src="${pageContext.request.contextPath}/assets/icons/down-arrow.png" alt="plus"
                                 style="width: 20px; height: 20px; margin-right: 10px;"/>
                          </a>
                          <div id="outputSpinner" class="spinner-border text-primary" style="display:none; height:15px; width:15px;" role="status">
                              <span class="visually-hidden">Loading...</span>
                          </div>
                        </p>
                    </div>
                    <div class="collapse" id="collapseOutput">
                      <div class="card card-header" id="codeOutput">
                      </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="staticBackdrop_submission_approve" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.approveSubmission"/></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="${pageContext.request.contextPath}/submission/approve">
                            <div class="form-floating mb-3">
                                <input id="problemIdInput" type="hidden" name="submissionId" value=""/>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemTitleInModal" placeholder="Problem" disabled/>
                                <label for="floatingInput"><spring:message code="label.problem"/></label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemUserInModal" placeholder="User" disabled/>
                                <label for="floatingInput"><spring:message code="label.user"/></label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemDateInModal" placeholder="Date" disabled/>
                                <label for="floatingInput"><spring:message code="label.date"/></label>
                            </div>
                            <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                <button id="deleteProblemBtn" type="submit" class="btn btn-outline-primary" id="submit_btn" style="margin-left:10px;">
                                    <spring:message code="label.approve"/>
                                    <img src="${pageContext.request.contextPath}/assets/icons/approve.png" alt="plus"
                                         style="width: 20px; height: 20px;"/>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="staticBackdrop_submission_reject" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Reject Submission</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="${pageContext.request.contextPath}/submission/reject">
                            <div class="form-floating mb-3">
                                <input id="problemIdInput2" type="hidden" name="submissionId" value=""/>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemTitleInModal2" placeholder="Problem" disabled/>
                                <label for="floatingInput"><spring:message code="label.problem"/></label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemUserInModal2" placeholder="User" disabled/>
                                <label for="floatingInput"><spring:message code="label.user"/></label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="problemDateInModal2" placeholder="Date" disabled/>
                                <label for="floatingInput"><spring:message code="label.date"/></label>
                            </div>
                            <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                <button id="rejectProblemBtn" type="submit" class="btn btn-outline-danger" style="margin-left:10px;">
                                    <spring:message code="label.reject"/>
                                    <img src="${pageContext.request.contextPath}/assets/icons/reject.png" alt="plus"
                                         style="width: 20px; height: 20px;"/>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.6/ace.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.6.8/beautify.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/code_v0.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                new DataTable('#example');
                var modal = document.getElementById("staticBackdrop_submission_approve");

                modal.addEventListener("show.bs.modal", function (event) {
                    var button = event.relatedTarget;

                    var problemTitleInModal = modal.querySelector("#problemTitleInModal");
                    problemTitleInModal.value = button.getAttribute("data-title");

                    var problemUserInModal = modal.querySelector("#problemUserInModal");
                    problemUserInModal.value = button.getAttribute("data-user");

                    var problemDateInModal = modal.querySelector("#problemDateInModal");
                    problemDateInModal.value = button.getAttribute("data-date");

                    var problemIdInput = document.getElementById("problemIdInput");
                    problemIdInput.value = button.getAttribute("data-id");
                });

                var modal = document.getElementById("staticBackdrop_submission_reject");

                modal.addEventListener("show.bs.modal", function (event) {
                    var button = event.relatedTarget;

                    var problemTitleInModal = modal.querySelector("#problemTitleInModal2");
                    problemTitleInModal.value = button.getAttribute("data-title");

                    var problemUserInModal = modal.querySelector("#problemUserInModal2");
                    problemUserInModal.value = button.getAttribute("data-user");

                    var problemDateInModal = modal.querySelector("#problemDateInModal2");
                    problemDateInModal.value = button.getAttribute("data-date");

                    var problemIdInput = document.getElementById("problemIdInput2");
                    problemIdInput.value = button.getAttribute("data-id");
                });
                
                const errorMessage = document.getElementById("errorMessage");

                if (errorMessage) {
                    const error = errorMessage.value;
                    showAlertMessage(error, "red");
                }
            });
        </script>

        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script>new DataTable('#submissionProblems');</script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.6/ace.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.6.8/beautify.js"></script>

    </body>

</html>