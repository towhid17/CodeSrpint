<div>
    <table class="table table-striped">
        <thead>
            <tr>
            <th class="header_img" scope="col">
                <img src="${pageContext.request.contextPath}/assets/icons/speedometer.png" alt="plus"
                    style="width: 20px; height: 20px; margin-right: 10px;"/>
                <spring:message code="label.difficulty"/>
            </th>
            </tr>
        </thead>
        <div class="table-wrapper">
            <c:choose>
                <c:when test="${currentTab == 'attribute'}">
                    <tbody id="difficultyList" class="table-scroll" style="height: 500px">
                    </tbody>
                </c:when>
                <c:otherwise>
                    <tbody id="difficultyList" class="table-scroll">
                    </tbody>
                </c:otherwise>
            </c:choose>
        </div>
    </table>
    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop_difficulty_add">
        <spring:message code="label.addDifficulty"/>
        <img src="${pageContext.request.contextPath}/assets/icons/plus.png" alt="plus"
            style="width: 20px; height: 20px; margin-left: 10px;"/>
    </button>


    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop_difficulty_add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.addDifficulty"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="difficultyName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Difficulty name"/>
                            <label for="floatingInput"><spring:message code="label.difficultyName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="addDifficultyBtn" type="button" class="btn btn-outline-primary" id="submit_btn">
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

    <div class="modal fade" id="staticBackdrop_difficulty_update" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.editDifficulty"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="difficultyName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Difficulty name"/>
                            <input id="difficultyId" type="hidden" path="id" class="form-control" id="floatingInput" placeholder="Difficulty name"/>
                            <label for="floatingInput"><spring:message code="label.difficultyName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="updateDifficultyBtn" type="button" class="btn btn-outline-info" id="submit_btn">
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

    <div class="modal fade" id="staticBackdrop_difficulty_delete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.deleteDifficulty"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="difficultyName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Difficulty name" disabled/>
                            <input id="difficultyId" type="hidden" path="id" class="form-control" id="floatingInput" placeholder="Difficulty name"/>
                            <label for="floatingInput"><spring:message code="label.difficultyName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="deleteDifficultyBtn" type="button" class="btn btn-outline-danger" id="submit_btn">
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
    function loadDifficultyList() {
        spinnerStart();

        $.ajax({
            url: "/difficulty/list",
            type: "GET",
            headers: {
                "Accept": "application/json"
            },
            success: function(result) {
                $("#difficultyList").empty();
                $.each(result, function(index, difficulty) {
                    var escapedName = $("<div>").text(difficulty.name).html();
                    $("#difficultyList").append(
                              "<tr style=\"width:100%;\">"
                            +   "<td style=\"width:70%;\">" + escapedName + "</td>"
                            +   "<td style=\"width:30%;\">"
                            +       "<div style=\"display: flex;\">"
                            +           "<button type=\"button\" class=\"btn btn-outline-info table_element_action_min\" "
                            +                    "data-bs-toggle=\"modal\" data-bs-target=\"#staticBackdrop_difficulty_update\" "
                            +                    "data-name=\""+ difficulty.name +"\" "
                            +                    "data-id=\""+ difficulty.id +"\" >"
                            +                "<img src=\"${pageContext.request.contextPath}/assets/icons/edit.png\" alt=\"plus\" class=\"table_element_action_min_img\"/>"
                            +           "</button>"
                            +           "<button type=\"button\" class=\"btn btn-outline-danger table_element_action_min\" "
                            +                    "data-bs-toggle=\"modal\" data-bs-target=\"#staticBackdrop_difficulty_delete\" "
                            +                    "data-name=\""+ difficulty.name +"\" "
                            +                    "data-id=\""+ difficulty.id +"\">"
                            +                "<img src=\"${pageContext.request.contextPath}/assets/icons/trash.png\" alt=\"plus\" class=\"table_element_action_min_img\"/>"
                            +           "</button>"
                            +       "</div>"
                            +   "</td>"
                            + "</tr>");
                });

                spinnerStop();
            },
            error: function(result) {
                showAlertMessage(result, "red");
                spinnerStop();
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        function setDifficultyModalData(modal) {
            modal.addEventListener("show.bs.modal", function (event) {
                var button = event.relatedTarget;

                var difficultyName = button.getAttribute("data-name");
                var difficultyId = button.getAttribute("data-id");

                var modalDifficultyName = modal.querySelector("#difficultyName");
                var modalDifficultyId = modal.querySelector("#difficultyId");

                modalDifficultyName.value = difficultyName;
                modalDifficultyId.value = difficultyId;
            });
        }

        var modalUpdate = document.getElementById("staticBackdrop_difficulty_update");
        var modalDelete = document.getElementById("staticBackdrop_difficulty_delete");

        setDifficultyModalData(modalUpdate);
        setDifficultyModalData(modalDelete);

        $("#addDifficultyBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_difficulty_add");
            var difficultyName = modal.querySelector("#difficultyName").value;
            var difficultySelect = document.getElementById("difficultySelect");

            spinnerStart();

            $.ajax({
                url: "/difficulty/save",
                type: "POST",
                data: { name: difficultyName },
                success: function(result) {
                    var splitResult = result.split("#");
                    var message = splitResult[0];
                    var id = splitResult[1];

                    loadDifficultyList();
                    showAlertMessage(message, "green");

                    if (difficultySelect) {
                        var option = document.createElement("option");
                        option.value = difficultyName;
                        option.setAttribute("data-id", id);
                        option.text = difficultyName;

                        difficultySelect.appendChild(option);
                    }

                    spinnerStop();
                },
                error: function(result) {
                    showAlertMessage(result.responseText, "red");
                    spinnerStop();
                }
            });

            modal.querySelector("#difficultyName").value = "";
            $("#staticBackdrop_difficulty_add").modal("hide");
        });

        $("#updateDifficultyBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_difficulty_update");
            var difficultyId = modal.querySelector("#difficultyId").value;
            var difficultyName = modal.querySelector("#difficultyName").value;

            var difficultySelect = document.getElementById("difficultySelect");

            spinnerStart();

            $.ajax({
                url: "/difficulty/save",
                type: "POST",
                data: { id: difficultyId,
                        name: difficultyName},
                success: function(result) {
                    var splitResult = result.split("#");
                    var message = splitResult[0];
                    var id = splitResult[1];

                    loadDifficultyList();
                    showAlertMessage(message, "green");

                    if (difficultySelect) {
                        var options = difficultySelect.options;
                        for (var i = 0; i < options.length; i++) {
                            if (options[i].getAttribute("data-id") === difficultyId) {
                                options[i].value = difficultyName;
                                options[i].text = difficultyName;
                                break;
                            }
                        }
                    }

                    spinnerStop();
                },
                error: function(result) {
                    showAlertMessage(result.responseText, "red");
                    spinnerStop();
                }
            });

            $("#staticBackdrop_difficulty_update").modal("hide");
        });

        $("#deleteDifficultyBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_difficulty_delete");
            var difficultyId = modal.querySelector("#difficultyId").value;
            var difficultyName = modal.querySelector("#difficultyName").value;

            var difficultySelect = document.getElementById("difficultySelect");

            spinnerStart();

            $.ajax({
                url: "/difficulty/delete",
                type: "POST",
                data: { id: difficultyId },
                success: function(result) {
                    loadDifficultyList();
                    showAlertMessage(result, "green");

                    if (difficultySelect) {
                        var options = difficultySelect.options;
                        for (var i = 0; i < options.length; i++) {
                            if (options[i].getAttribute("data-id") === difficultyId) {
                                options[i].remove();
                                break;
                            }
                        }
                    }

                    spinnerStop();
                },
                error: function(result) {
                    showAlertMessage(result.responseText, "red");
                    spinnerStop();
                }
            });

            $("#staticBackdrop_difficulty_delete").modal("hide");
        });

        loadDifficultyList();
    });
</script>
