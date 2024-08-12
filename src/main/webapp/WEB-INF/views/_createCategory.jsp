<div>
    <table class="table table-striped">
        <thead>
            <tr>
            <th class="header_img" scope="col">
                <img src="${pageContext.request.contextPath}/assets/icons/categories.png" alt="plus"
                    style="width: 20px; height: 20px; margin-right: 10px;"/>
                <spring:message code="label.category"/>
            </th>
            </tr>
        </thead>
        <div class="table-wrapper">
            <c:choose>
                <c:when test="${currentTab == 'attribute'}">
                    <tbody id="categoryList" class="table-scroll" style="height: 500px">
                    </tbody>
                </c:when>
                <c:otherwise>
                    <tbody id="categoryList" class="table-scroll">
                    </tbody>
                </c:otherwise>
            </c:choose>
        </div>
    </table>
    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop_category_add">
        <spring:message code="label.addCategory"/>
        <img src="${pageContext.request.contextPath}/assets/icons/plus.png" alt="plus"
            style="width: 20px; height: 20px; margin-left: 10px;"/>
    </button>


    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop_category_add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.addCategory"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="categoryName" path="name" class="form-control" id="floatingInput" placeholder="Category name"/>
                            <label for="floatingInput"><spring:message code="label.categoryName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="addCategoryBtn" type="button" class="btn btn-outline-primary" id="submit_btn">
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

    <div class="modal fade" id="staticBackdrop_category_update" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.editCategory"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="categoryName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Category name"/>
                            <input id="categoryId" type="hidden" path="id" class="form-control" id="floatingInput" placeholder="Category name"/>
                            <label for="floatingInput"><spring:message code="label.categoryName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="updateCategoryBtn" type="button" class="btn btn-outline-info" id="submit_btn">
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

    <div class="modal fade" id="staticBackdrop_category_delete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel"><spring:message code="label.deleteCategory"/></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-floating mb-3">
                            <input id="categoryName" type="Username" path="name" class="form-control" id="floatingInput" placeholder="Category name" disabled/>
                            <input id="categoryId" type="hidden" path="id" class="form-control" id="floatingInput" placeholder="Category name"/>
                            <label for="floatingInput"><spring:message code="label.categoryName"/></label>
                        </div>
                        <div class="card-footer" style="display:flex; justify-content: flex-end; padding-top:10px; margin-right: 10px;">
                            <button id="deleteCategoryBtn" type="button" class="btn btn-outline-danger" id="submit_btn">
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
    function loadCategoryList() {
        spinnerStart();

        $.ajax({
            url: "/category/list",
            type: "GET",
            headers: {
                "Accept": "application/json"
            },
            success: function(result) {
                $("#categoryList").empty();
                $.each(result, function(index, category) {
                    var escapedName = $("<div>").text(category.name).html();
                    $("#categoryList").append(
                                "<tr style=\"width:100%;\">"
                            +   "<td style=\"width:70%;\">" + escapedName + "</td>"
                            +   "<td style=\"width:30%;\">"
                            +       "<div style=\"display: flex;\">"
                            +           "<button type=\"button\" class=\"btn btn-outline-info table_element_action_min\" "
                            +                    "data-bs-toggle=\"modal\" data-bs-target=\"#staticBackdrop_category_update\" "
                            +                    "data-name=\""+ category.name +"\" "
                            +                    "data-id=\""+ category.id +"\" >"
                            +                "<img src=\"${pageContext.request.contextPath}/assets/icons/edit.png\" alt=\"plus\" class=\"table_element_action_min_img\"/>"
                            +           "</button>"
                            +           "<button type=\"button\" class=\"btn btn-outline-danger table_element_action_min\" "
                            +                    "data-bs-toggle=\"modal\" data-bs-target=\"#staticBackdrop_category_delete\" "
                            +                    "data-name=\""+ category.name +"\" "
                            +                    "data-id=\""+ category.id +"\">"
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
        var modalUpdate = document.getElementById("staticBackdrop_category_update");
        var modalDelete = document.getElementById("staticBackdrop_category_delete");

        setCategoryModalData(modalUpdate);
        setCategoryModalData(modalDelete);

        function setCategoryModalData(modal) {
            modal.addEventListener("show.bs.modal", function (event) {
                var button = event.relatedTarget;

                var categoryName = button.getAttribute("data-name");
                var categoryId = button.getAttribute("data-id");

                var modalCategoryName = modal.querySelector("#categoryName");
                var modalCategoryId = modal.querySelector("#categoryId");

                modalCategoryName.value = categoryName;
                modalCategoryId.value = categoryId;
            });
        }

        $("#addCategoryBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_category_add");
            var categoryName = modal.querySelector("#categoryName").value;
            var categorySelect = document.getElementById("categorySelect");

            spinnerStart();

            $.ajax({
                url: "/category/save",
                type: "POST",
                data: { name: categoryName },
                success: function(result) {
                    var splitResult = result.split("#");
                    var message = splitResult[0];
                    var id = splitResult[1];

                    loadCategoryList();
                    showAlertMessage(message, "green");

                    if (categorySelect) {
                        var option = document.createElement("option");
                        option.value = categoryName;
                        option.setAttribute("data-id", id);
                        option.text = categoryName;

                        categorySelect.appendChild(option);
                    }

                    spinnerStop();
                },
                error: function(result) {
                    showAlertMessage(result.responseText, "red");
                    spinnerStop();
                }
            });

            modal.querySelector("#categoryName").value = "";
            $("#staticBackdrop_category_add").modal("hide");
        });

        $("#updateCategoryBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_category_update");
            var categoryId = modal.querySelector("#categoryId").value;
            var categoryName = modal.querySelector("#categoryName").value;

            var categorySelect = document.getElementById("categorySelect");

            spinnerStart();

            $.ajax({
                url: "/category/save",
                type: "POST",
                data: { id: categoryId,
                        name: categoryName},
                success: function(result) {
                    var splitResult = result.split("#");
                    var message = splitResult[0];
                    var id = splitResult[1];

                    loadCategoryList();
                    showAlertMessage(message, "green");

                    if (categorySelect) {
                        var options = categorySelect.options;
                        for (var i = 0; i < options.length; i++) {
                            if (options[i].getAttribute("data-id") === categoryId) {
                                options[i].value = categoryName;
                                options[i].text = categoryName;
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

            $("#staticBackdrop_category_update").modal("hide");
        });

        $("#deleteCategoryBtn").click(function() {
            var modal = document.getElementById("staticBackdrop_category_delete");
            var categoryId = modal.querySelector("#categoryId").value;
            var categoryName = modal.querySelector("#categoryName").value;

            var categorySelect = document.getElementById("categorySelect");

            spinnerStart();

            $.ajax({
                url: "/category/delete",
                type: "POST",
                data: { id: categoryId },
                success: function(result) {
                    loadCategoryList();
                    showAlertMessage(result, "green");

                    if (categorySelect) {
                        var options = categorySelect.options;
                        for (var i = 0; i < options.length; i++) {
                            if (options[i].getAttribute("data-id") === categoryId) {
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

            $("#staticBackdrop_category_delete").modal("hide");
        });

        loadCategoryList();
    });
</script>


