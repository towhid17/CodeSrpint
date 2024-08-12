<div>
    <table class="table table-striped">
        <thead>
            <tr>
            <th class="header_img" scope="col">
                <img src="${pageContext.request.contextPath}/assets/icons/tag.png" alt="plus"
                    style="width: 20px; height: 20px; margin-right: 10px;"/>
                <spring:message code="label.tag"/>
            </th>
            </tr>
        </thead>
        <div class="table-wrapper">
            <c:choose>
                <c:when test="${currentTab == 'attribute'}">
                    <tbody id="tagList" class="table-scroll" style="height: 500px">
                    </tbody>
                </c:when>
                <c:otherwise>
                    <tbody id="tagList" class="table-scroll">
                    </tbody>
                </c:otherwise>
            </c:choose>
        </div>
    </table>
    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop_tag_add">
        <spring:message code="label.addTag"/>
        <img src="${pageContext.request.contextPath}/assets/icons/plus.png" alt="plus"
            style="width: 20px; height: 20px; margin-left: 10px;"/>
    </button>


    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop_tag_add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.addTag"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="tagName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Tag name"/>
                            <label for="floatingInput"><spring:message code="label.tagName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="addTagBtn" type="button" class="btn btn-outline-primary" id="submit_btn">
                                <spring:message code="label.add"/>
                                <img src="${pageContext.request.contextPath}/assets/icons/plus.png" alt="plus"
                                     style="width: 20px; height: 20px; margin-left: 10px;"/>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="staticBackdrop_tag_update" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.editTag"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="tagName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Tag name"/>
                            <input id="tagId" type="hidden" path="id" class="form-control" id="floatingInput" placeholder="Tag name"/>
                            <label for="floatingInput"><spring:message code="label.tagName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="updateTagBtn" type="button" class="btn btn-outline-info" id="submit_btn">
                                <spring:message code="label.edit"/>
                                <img src="${pageContext.request.contextPath}/assets/icons/edit.png" alt="plus"
                                     style="width: 20px; height: 20px; margin-left: 10px;"/>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="staticBackdrop_tag_delete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.deleteTag"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="tagName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Tag name" disabled/>
                            <input id="tagId" type="hidden" path="id" class="form-control" id="floatingInput" placeholder="Tag name"/>
                            <label for="floatingInput"><spring:message code="label.tagName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="deleteTagBtn" type="button" class="btn btn-outline-danger" id="submit_btn">
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
</div>

<script>
    function loadTagList() {
        $.ajax({
            url: "/tag/list",
            type: "GET",
            headers: {
                "Accept": "application/json"
            },
            success: function(result) {
                $("#tagList").empty();
                $.each(result, function(index, tag) {
                    var escapedName = $("<div>").text(tag.name).html();
                    $("#tagList").append(
                              "<tr style=\"width:100%;\">"
                            +   "<td style=\"width:70%;\">" + escapedName + "</td>"
                            +   "<td style=\"width:30%;\">"
                            +       "<div style=\"display: flex;\">"
                            +           "<button type=\"button\" class=\"btn btn-outline-info table_element_action_min\" "
                            +                    "data-bs-toggle=\"modal\" data-bs-target=\"#staticBackdrop_tag_update\" "
                            +                    "data-name=\""+ tag.name +"\" "
                            +                    "data-id=\""+ tag.id +"\" >"
                            +                "<img src=\"${pageContext.request.contextPath}/assets/icons/edit.png\" alt=\"plus\" class=\"table_element_action_min_img\"/>"
                            +           "</button>"
                            +           "<button type=\"button\" class=\"btn btn-outline-danger table_element_action_min\" "
                            +                    "data-bs-toggle=\"modal\" data-bs-target=\"#staticBackdrop_tag_delete\" "
                            +                    "data-name=\""+ tag.name +"\" "
                            +                    "data-id=\""+ tag.id +"\">"
                            +                "<img src=\"${pageContext.request.contextPath}/assets/icons/trash.png\" alt=\"plus\" class=\"table_element_action_min_img\"/>"
                            +           "</button>"
                            +       "</div>"
                            +   "</td>"
                            + "</tr>");
                });
            },
            error: function(result) {
                showAlertMessage(result, "red");
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        function setTagModalData(modal) {
            modal.addEventListener("show.bs.modal", function (event) {
                var button = event.relatedTarget;

                var tagName = button.getAttribute("data-name");
                var tagId = button.getAttribute("data-id");

                var modalTagName = modal.querySelector("#tagName");
                var modalTagId = modal.querySelector("#tagId");

                modalTagName.value = tagName;
                modalTagId.value = tagId;
            });
        }

        var modalUpdate = document.getElementById("staticBackdrop_tag_update");
        var modalDelete = document.getElementById("staticBackdrop_tag_delete");

        setTagModalData(modalUpdate);
        setTagModalData(modalDelete);

        $("#addTagBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_tag_add");
            var tagName = modal.querySelector("#tagName").value;

            spinnerStart();

            $.ajax({
                url: "/tag/save",
                type: "POST",
                data: { name: tagName },
                success: function(result) {
                    var splitResult = result.split("#");
                    var message = splitResult[0];
                    var id = splitResult[1];

                    loadTagList();
                    showAlertMessage(message, "green");
                    spinnerStop();
                },
                error: function(result) {
                    showAlertMessage(result.responseText, "red");
                    spinnerStop();
                }
            });

            modal.querySelector("#tagName").value = "";
            $("#staticBackdrop_tag_add").modal("hide");
        });

        $("#updateTagBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_tag_update");
            var tagId = modal.querySelector("#tagId").value;
            var tagName = modal.querySelector("#tagName").value;

            spinnerStart();

            $.ajax({
                url: "/tag/save",
                type: "POST",
                data: { id: tagId,
                        name: tagName},
                success: function(result) {
                    var splitResult = result.split("#");
                    var message = splitResult[0];
                    var id = splitResult[1];

                    loadTagList();
                    showAlertMessage(message, "green");
                    spinnerStop();
                },
                error: function(result) {
                    showAlertMessage(result.responseText, "red");
                    spinnerStop();
                }
            });

            $("#staticBackdrop_tag_update").modal("hide");
        });

        $("#deleteTagBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_tag_delete");
            var tagId = modal.querySelector("#tagId").value;

            spinnerStart();

            $.ajax({
                url: "/tag/delete",
                type: "POST",
                data: { id: tagId },
                success: function(result) {
                    loadTagList();
                    showAlertMessage(result, "green");
                    spinnerStop();
                },
                error: function(result) {
                    showAlertMessage(result.responseText, "red");
                    spinnerStop();
                }
            });

            $("#staticBackdrop_tag_delete").modal("hide");
        });

        loadTagList();
    });
</script>
