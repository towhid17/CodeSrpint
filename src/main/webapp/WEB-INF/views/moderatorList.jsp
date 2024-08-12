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
        <title><spring:message code="label.moderator"/></title>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container-lg" style="display: flex; justify-content: center">
            <div class="col-12">
                <div class="shadow card" style="margin-top: 20px;">
                    <div class="card-header" style="display:flex; justify-content:space-between">
                        <div>
                            <img src="${pageContext.request.contextPath}/assets/icons/coding.png" alt="plus"
                                     style="width: 20px; height: 20px; margin-right: 10px;"/>
                            <spring:message code="label.moderator"/>
                        </div>
                        <a type="button"
                           class="btn btn-outline-primary"
                           href="/moderator/create">

                            <spring:message code="label.createModerator"/>
                            <img src="${pageContext.request.contextPath}/assets/icons/plus.png" alt="plus"
                                style="width: 20px; height: 15px; margin-left: 10px;"/>
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="rounded" style="width:100%; border-radius: 30px; font-size: 12px;">
                            <table id="example"
                                style="width: 100%;">

                                <thead class="col-centered">
                                    <tr class="table_header">
                                        <th> <p class="table_th">Username</p></th>
                                        <th> <p class="table_th">Email</p></th>
                                        <th> <p class="table_th">Full name</p></th>
                                        <th> <p class="table_th">Action</p></th>
                                    </tr>
                                </thead>

                                <tbody class="col-centered">
                                    <c:forEach items="${moderators}" var="moderator">
                                        <tr class="table_row">
                                            <td class="col-3">
                                                <c:out value="${moderator.userName}" />
                                                <c:if test="${moderator.lock == true}">
                                                    <img src="${pageContext.request.contextPath}/assets/icons/lock.png" alt="plus"
                                                         style="width: 12px; height: 12px; margin-left: 5px;"/>
                                                </c:if>
                                            </td>
                                            <td class="col-4">
                                                <c:out value="${moderator.email}" />
                                            </td>
                                            <td class="col-3">
                                                <c:out value="${moderator.fullName}" />
                                            </td>
                                            <td class="col-2">
                                                <c:choose>
                                                    <c:when test="${moderator.lock == false}">
                                                        <button type="button"
                                                                class="btn btn-outline-danger"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#staticBackdrop_moderator_lock"
                                                                data-name="${moderator.userName}"
                                                                data-id="${moderator.id}">
                                                                Lock
                                                                <img src="${pageContext.request.contextPath}/assets/icons/lock.png" alt="plus"
                                                                    style="width: 15px; height: 15px; margin-left: 10px;"/>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button"
                                                                class="btn btn-outline-info"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#staticBackdrop_moderator_unlock"
                                                                data-name="${moderator.userName}"
                                                                data-id="${moderator.id}">
                                                                Unlock
                                                                <img src="${pageContext.request.contextPath}/assets/icons/unlocked.png" alt="plus"
                                                                    style="width: 15px; height: 15px; margin-left: 10px;"/>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="staticBackdrop_moderator_lock" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.lockModeratorAccess"/></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="${pageContext.request.contextPath}/moderator/lock">
                            <div class="form-floating mb-3">
                                <input id="moderatorId" type="hidden" name="moderatorId" value=""/>
                                <input id="status" type="hidden" name="status" value="true"/>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="moderatorName" placeholder="Moderator" disabled/>
                                <label for="floatingInput"><spring:message code="label.moderator"/></label>
                            </div>
                            <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                <button id="lockModeratorBtn" type="submit" class="btn btn-outline-danger" id="submit_btn">
                                    <spring:message code="label.lock"/>
                                    <img src="${pageContext.request.contextPath}/assets/icons/lock.png" alt="plus"
                                         style="width: 20px; height: 20px; margin-left: 10px;"/>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="staticBackdrop_moderator_unlock" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.unlockModeratorAccess"/></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="${pageContext.request.contextPath}/moderator/lock">
                            <div class="form-floating mb-3">
                                <input id="moderatorId" type="hidden" name="moderatorId" value=""/>
                                <input id="status" type="hidden" name="status" value="false"/>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="moderatorName" placeholder="Moderator" disabled/>
                                <label for="floatingInput"><spring:message code="label.moderator"/></label>
                            </div>
                            <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                                <button id="unlockModeratorBtn" type="submit" class="btn btn-outline-info" id="submit_btn">
                                    <spring:message code="label.unlock"/>
                                    <img src="${pageContext.request.contextPath}/assets/icons/unlocked.png" alt="plus"
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
            document.addEventListener("DOMContentLoaded", function () {
                function setModeratorLockModal(modal) {
                    modal.addEventListener("show.bs.modal", function (event) {
                        var button = event.relatedTarget;

                        var moderatorName = modal.querySelector("#moderatorName");
                        moderatorName.value = button.getAttribute("data-name");

                        var moderatorId = modal.querySelector("#moderatorId");
                        moderatorId.value = button.getAttribute("data-id");
                    });
                }

                var modalModeratorLock = document.getElementById("staticBackdrop_moderator_lock");
                var modalModeratorUnlock = document.getElementById("staticBackdrop_moderator_unlock");

                setModeratorLockModal(modalModeratorLock);
                setModeratorLockModal(modalModeratorUnlock);
            });
        </script>

    </body>

</html>