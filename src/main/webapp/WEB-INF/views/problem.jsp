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
        <div class="container-fluid" style="display: flex; margin-top:20px;">
            <!-- problem spec -->
            <div class="col-7" style="padding-right: 20px">
                <div class="shadow card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs">
                            <li class="nav-item">
                                <button class="nav-link active" aria-current="true" href="#" id="button1">Problem</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" aria-current="false" href="#" id="button2">Editorial</button>
                            </li>
                            <c:if test="${SESSION_USER_ROLE == 'MODERATOR' or SESSION_USER_ROLE == 'USER'}">
                                <li class="nav-item">
                                    <button class="nav-link" aria-current="false" href="#" id="button3">Submissions</button>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                    <div class="card-body" style="justify-content: left;">
                        <h5 class="card-title"><c:out value="${problem.id}. ${problem.title}"/></h5>
                        <div style="display:flex; align-items: center;">
                            <p class="btn-diff-${problem.difficulty.name}"
                                style="margin-bottom: 0px;">
                                <c:out value="${problem.difficulty.name}"/>
                            </p>
                            <p class="category problem_category"
                                style="margin-left: 10px; margin-bottom:0px;">
                                <c:out value="${problem.category.name}"/>
                            </p>
                        </div>
                        <hr/>
                        <div class="problem-wrapper" style="width:100%;">
                            <div id="problem_details" class="problem-scroll" style="width:100%;">
                                <textarea id="problemDescriptionArea" class="card-text"><c:out value="${problem.description}"/></textarea>
                                <hr/>
                                <div class="card-header" style="border-radius: 10px;">
                                    <c:forEach items="${problem.examples}" var="example" varStatus="loop">
                                        <div style="font-size: 14px">
                                            <c:out value="Example ${loop.index + 1}:"/>
                                        </div>
                                        <div class="card" style="border:0px; margin-bottom:10px;">
                                            <div class="card-header">
                                                <div style="display: flex;"><p style="font-weight:bold"><spring:message code="label.input"/></p> <c:out value="${example.input}"/></div>
                                                <div style="display: flex;"><p style="font-weight:bold"><spring:message code="label.output"/></p> <c:out value="${example.output}"/></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <hr class="blank"/>
                                <div class="card" style="border:0px">
                                    <div class="card-header" style="margin-bottom: 10px;">
                                        <spring:message code="label.constraint"/>:
                                    </div>
                                    <ul>
                                        <c:forEach items="${problem.constraints}" var="constraint" varStatus="loop">
                                            <li class="tag2" style="margin-bottom: 5px;">
                                                <c:out value="${constraint.description}"/>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <hr>
                                <div class="card-body">
                                    <a style="text-decoration: none;" class="cust_collapse" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                        <spring:message code="label.relatedTopics"/>
                                        <img src="${pageContext.request.contextPath}/assets/icons/down-arrow.png" alt="plus"
                                            style="width: 20px; height: 20px; margin-right: 10px;"/>
                                    </a>
                                    <div class="collapse" id="collapseExample">
                                        <div class="flex-items">
                                            <c:forEach var="tag" items="${problem.tags}" varStatus="loop">
                                                <div class="tag2">
                                                    <c:out value="${tag.name}"/>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="editorial_details" style="display: none;">
                            <c:if test="${problem.editorial != null}">
                                <div style="display: flex; height:35px; margin-bottom: 20px;">
                                    <div style="display:flex; flex-direction: column; align-items: center;">
                                        <div style="display:flex;">
                                            <img src="${pageContext.request.contextPath}/assets/icons/star_filled.png" alt="plus"
                                                style="width: 23px; height: 23px; margin-right: 10px;"/>
                                            <h4 id="averageRating">
                                                <c:set var="averageRating" value="${problem.editorial.averageRating}" />
                                                <fmt:formatNumber var="formattedRating" value="${averageRating}" pattern="#.#" />
                                                <c:out value="${formattedRating}" />
                                            </h4>
                                        </div>
                                        <p  id="numOfRatings" style="font-size: 11px;"><c:out value="(Total ratings: ${problem.editorial.numOfRating})"/>
                                    </div>
                                    <c:if test="${SESSION_USER_ROLE == 'USER'}">
                                        <c:choose>
                                            <c:when test="${rating == null}">
                                                <div id="ratingNew" style="display: block;">
                                                    <input type="hidden" id="previousRating" value="0"/>
                                            </c:when>
                                            <c:otherwise>
                                                <div id="ratingNew" style="display: none;">
                                            </c:otherwise>
                                        </c:choose>
                                            <button id="ratingBtn" data-editorialId="${problem.editorial.id}" type="button" class="btn btn-outline-info"
                                                    data-bs-toggle="modal" data-bs-target="#staticBackdrop_rating"
                                                    style="font-size:14px; margin-left: 10px;">
                                                <spring:message code="label.rate"/>
                                                <img src="${pageContext.request.contextPath}/assets/icons/star.png" alt="plus"
                                                        style="width: 20px; height: 20px; margin-left: 10px;"/>
                                            </button>
                                        </div>
                                        <c:choose>
                                            <c:when test="${rating == null}">
                                                <div id="ratingUpdate" style="display: none;">
                                            </c:when>
                                            <c:otherwise>
                                                <div id="ratingUpdate" style="display: block;">
                                                    <input type="hidden" id="previousRating" value="${rating.value}"/>
                                            </c:otherwise>
                                        </c:choose>
                                            <div class="shadow rating_box">
                                                <p style="font-size: 10px; margin-bottom:1px; height: 10px; width: 100%;"><c:out value="Your Rating"/></p>
                                                <div style="display: flex; width: 100%;">
                                                    <p id="ratingValueInEdit" style="font-size: 18px; height: 25px; width: 50%;"><c:out value="${rating.value}"/></p>
                                                    <button id="ratingBtn" data-editorialId="${problem.editorial.id}" type="button"
                                                            class="btn btn-outline-info table_element_action"
                                                            data-bs-toggle="modal" data-bs-target="#staticBackdrop_rating"
                                                            style="height: 25px; width: 50%;">
                                                        <img src="${pageContext.request.contextPath}/assets/icons/edit.png" alt="plus"
                                                                class="table_element_action_img"/>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                <hr style="margin-bottom: 0px;"/>
                                <div class="problem-wrapper" style="width:100%; height: 600px;">
                                    <div class="problem-scroll" style="height: 600px;">
                                        <textarea id="editorialDescriptionArea" class="card-text" style="height: 550px"><c:out value="${problem.editorial.description}"/></textarea>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <div class="problem-wrapper" style="width:100%;">
                        <c:if test="${SESSION_USER_ROLE == 'MODERATOR' or SESSION_USER_ROLE == 'USER'}">
                            <div id="submission_details" class="problem-scroll" style="display: none;">
                                <div class="card-header">
                                    <spring:message code="label.submissions"/>
                                </div>
                                <div class="card-body" style="font-size:12px;">
                                    <c:if test="${not empty error}">
                                        <input type="hidden" id="errorMessage" value="${error}"/>
                                        <c:remove var="error" scope="session"/>
                                    </c:if>

                                    <table id="submissionProblem"
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
                                            <c:forEach var="problemSubmission" items="${problemSubmissions}" varStatus="loop">
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
                        </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- problem sub -->
            <div class="col-5">
                <form action="/code/saveFile" method="post">
                    <div class="shadow card">
                        <div class="card-header">
                            <c:out value="Code Editor: Java"/>
                        </div>
                        <div class="card-body">
                            <input type="hidden" name="problemId" value="${problem.id}"/>
                            <textarea name="code"><c:out value="public class Submitted {public static void main(String[] args) throws Exception {System.out.print(\"Hello world\");}}"/></textarea>
                            <div id="editor" style="height: 450px; border-radius:10px"></div>
                        </div>
                        <div class="card-footer" style="display: flex;">
                            <c:if test="${SESSION_USER_ROLE == 'USER'}">
                                <button class="btn btn-outline-primary" style="margin-right:15px;" type="submit">
                                    <div style="display: flex;">
                                        Submit
                                        <img src="${pageContext.request.contextPath}/assets/icons/submitCode.png" alt="plus"
                                             style="width: 25px; height: 25px; margin-left: 10px;"/>
                                    </div>
                                </button>
                            </c:if>
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
                </form>
                <hr class="blank"/>
                <c:if test="${SESSION_USER_ROLE == 'USER'}">
                    <form:form modelAttribute="submissionFileDto" action="/submission/save" enctype="multipart/form-data" method="post">
                        <div class="shadow card">
                            <div class="card-header">
                                Submit Solution (i.e File.java)
                            </div>
                            <div class="card-body">
                                <input type="hidden" name="problemId" value="${problem.id}"/>
                                <div class="mb-3">
                                    <input class="form-control" type="file" id="formFile" name="submissionFile"/>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-outline-primary" type="submit" class="btn btn-primary">
                                    <div style="display: flex;">
                                        Submit
                                        <img src="${pageContext.request.contextPath}/assets/icons/submitFile.png" alt="plus"
                                             style="width: 25px; height: 25px; margin-left: 10px;"/>
                                    </div>
                                </button>
                            </div>
                        </div>
                    </form:form>
                </c:if>
            </div>
        </div>

        <input type="hidden" id="tab" name="tab" value="${tab}"/>
        
        <!-- rating modal -->
        <div class="modal fade" id="staticBackdrop_rating" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Rate Editorial</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="display: flex; justify-content: center;">
                        <div class="rating-wrapper">
                            <div class="rating">
                              <input type="radio" name="rating" id="star1" value="5"/>
                              <label for="star1"></label>
                              <input type="radio" name="rating" id="star2" value="4"/>
                              <label for="star2"></label>
                              <input type="radio" name="rating" id="star3" value="3"/>
                              <label for="star3"></label>
                              <input type="radio" name="rating" id="star4" value="2"/>
                              <label for="star4"></label>
                              <input type="radio" name="rating" id="star5" value="1"/>
                              <label for="star5"></label>
                            </div>
                        </div>                          
                    </div>
                    <div class="modal-footer" style="display: flex; justify-content: center;">
                        <button class="btn btn-outline-primary" id="submit_rating" type="button" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- submission approve modal -->
        <c:if test="${SESSION_USER_ROLE == 'MODERATOR'}">
            <div class="modal fade" id="staticBackdrop_submission_approve" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">Approve Submission</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="${pageContext.request.contextPath}/submission/approve">
                                <div class="form-floating mb-3">
                                    <input id="problemIdInput" type="hidden" name="submissionId" value=""/>
                                    <input type="hidden" name="problemId" value="${problem.id}"/>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="problemTitleInModal" placeholder="Problem" disabled/>
                                    <label for="floatingInput">Submission</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="problemUserInModal" placeholder="User" disabled/>
                                    <label for="floatingInput">User</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="problemDateInModal" placeholder="Date" disabled/>
                                    <label for="floatingInput">Date</label>
                                </div>
                                <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                    <button id="deleteProblemBtn" type="submit" class="btn btn-outline-primary" id="submit_btn" style="margin-left:10px;">
                                        Approve
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
                                    <input id="problemIdInput" type="hidden" name="submissionId" value=""/>
                                    <input type="hidden" name="problemId" value="${problem.id}"/>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="problemTitleInModal" placeholder="Problem" disabled/>
                                    <label for="floatingInput">Problem</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="problemUserInModal" placeholder="User" disabled/>
                                    <label for="floatingInput">User</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="problemDateInModal" placeholder="Date" disabled/>
                                    <label for="floatingInput">Date</label>
                                </div>
                                <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                    <button id="rejectProblemBtn" type="submit" class="btn btn-outline-danger" style="margin-left:10px;">
                                        Reject
                                        <img src="${pageContext.request.contextPath}/assets/icons/reject.png" alt="plus"
                                             style="width: 20px; height: 20px;"/>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.6/ace.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.6.8/beautify.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/code_v0.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var tab = document.getElementById("tab");

                if (tab != null) {
                    if (tab.value == "problemSubmission") {
                        document.getElementById("button3").click();
                    }
                }

                function setProblemSubmissionModal(modal) {
                    modal.addEventListener("show.bs.modal", function (event) {
                        var button = event.relatedTarget;

                        var problemTitleInModal = modal.querySelector("#problemTitleInModal");
                        problemTitleInModal.value = button.getAttribute("data-title");

                        var problemUserInModal = modal.querySelector("#problemUserInModal");
                        problemUserInModal.value = button.getAttribute("data-user");

                        var problemDateInModal = modal.querySelector("#problemDateInModal");
                        problemDateInModal.value = button.getAttribute("data-date");

                        var problemIdInput = modal.querySelector("#problemIdInput");
                        problemIdInput.value = button.getAttribute("data-id");
                    });
                }

                var modalApprove = document.getElementById("staticBackdrop_submission_approve");
                var modalReject = document.getElementById("staticBackdrop_submission_reject");

                if (modalApprove) {
                    setProblemSubmissionModal(modalApprove);
                }

                if (modalReject) {
                    setProblemSubmissionModal(modalReject);
                }

                const ratingInputs = document.querySelectorAll('input[name="rating"]');
                const ratingWrapper = document.querySelector(".rating-wrapper");

                const previousRating = document.getElementById("previousRating");
                const submitButton = document.getElementById("submit_rating");

                if (previousRating) {
                    const previousRatingValue = previousRating.value;

                    ratingInputs.forEach((input) => {
                        if (input.value == previousRatingValue) {
                            input.checked = true;
                        }
                    });
                }

                ratingWrapper.addEventListener("click", function (event) {
                    if (event.target.matches("label")) {
                        const clickedValue = event.target.getAttribute("for").replace("star", "");

                        ratingInputs.forEach((input) => {
                            input.checked = input.value === clickedValue;
                        });
                    }
                });


                function getSelectedRating() {
                    let selectedValue = null;

                    ratingInputs.forEach((input) => {
                        if (input.checked) {
                            selectedValue = input.value;
                        }
                    });

                    return selectedValue;
                }

                submitButton.addEventListener("click", function () {
                    const selectedRating = getSelectedRating();
                    var ratingBtn = document.getElementById("ratingBtn");
                    var editorialId = ratingBtn.getAttribute("data-editorialId");
                    var previousRating = document.getElementById("previousRating");
                    var previousRatingValue = previousRating.value;
                    var ratingValueInEdit = document.getElementById("ratingValueInEdit");
                    var ratingNew = document.getElementById("ratingNew");
                    var ratingUpdate = document.getElementById("ratingUpdate");

                    var averageRating = document.getElementById("averageRating");
                    var totalRatings = document.getElementById("numOfRatings");

                    if (selectedRating !== null) {
                        $.ajax({
                            type: "POST",
                            url: "/editorial/rating/save",
                            data: {rating: selectedRating,
                                   editorialId: editorialId
                            },
                            success: function (result) {
                                var resultArray = result.split("#");

                                showAlertMessage(resultArray[0], "green");

                                averageRating.innerHTML = parseFloat(resultArray[1]).toFixed(1);
                                totalRatings.innerHTML = "(Total ratings: " + resultArray[2] + ")";

                                previousRating.value = selectedRating;
                                ratingValueInEdit.innerHTML = selectedRating;

                                ratingNew.style.display = "none";
                                ratingUpdate.style.display = "block";
                            },
                            error: function (e) {
                                showAlertMessage(e.responseText, "red");
                            }
                      });
                    }

                    $("#staticBackdrop_rating").modal("hide");
                });

                function handleButtonClick(buttonId) {
                    var buttons = document.querySelectorAll(".nav-link");

                    buttons.forEach(function (button) {
                        button.classList.remove("active");
                        button.setAttribute("aria-current", "false");
                    });

                    var clickedButton = document.querySelector(buttonId);
                    clickedButton.classList.add("active");

                    clickedButton.setAttribute("aria-current", "true");
                }

                var problem_button = document.getElementById("button1");
                var editorial_button = document.getElementById("button2");
                var submission_button = document.getElementById("button3");

                var problem_details = document.getElementById("problem_details");
                var editorial_details = document.getElementById("editorial_details");
                var submission_details = document.getElementById("submission_details");

                document.getElementById("button1").addEventListener("click", function () {
                    handleButtonClick("#button1");
                    problem_details.style.display = "block";
                    editorial_details.style.display = "none";

                    if (submission_details) {
                        document.getElementById("submission_details").style.display = "none";
                    }
                });

                document.getElementById("button2").addEventListener("click", function () {
                    handleButtonClick("#button2");
                    problem_details.style.display = "none";
                    editorial_details.style.display = "block";

                    if (submission_details) {
                        submission_details.style.display = "none";
                    }
                });

                if (submission_button) {
                    submission_button.addEventListener("click", function () {
                        handleButtonClick("#button3");
                        problem_details.style.display = "none";
                        editorial_details.style.display = "none";
                        submission_details.style.display = "block";
                    });
                }

                const errorMessage = document.getElementById("errorMessage");

                if (errorMessage) {
                    const error = errorMessage.value;
                    showAlertMessage(error, "red");
                }
            });
        </script>

        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script>new DataTable('#submissionProblem');</script>

        <script>
            tinymce.init({
              selector: '#editorialDescriptionArea',
              readonly: true,
              toolbar: false,
              menubar: false,
              statusbar: false,
              height: 600,
              skin: document.querySelector('html').dataset.bsTheme === 'light' ? 'oxide' : 'oxide-dark',
              content_css: document.querySelector('html').dataset.bsTheme === 'light' ? 'default' : 'dark',
            });

            tinymce.init({
              selector: '#problemDescriptionArea',
              readonly: true,
              toolbar: false,
              menubar: false,
              statusbar: false,
              skin: document.querySelector('html').dataset.bsTheme === 'light' ? 'oxide' : 'oxide-dark',
              content_css: document.querySelector('html').dataset.bsTheme === 'light' ? 'default' : 'dark',
            });
        </script>

    </body>
</html>