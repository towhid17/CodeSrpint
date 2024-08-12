<%--
  @author towhidul.islam
  @since 8/20/23
--%>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <img src="${pageContext.request.contextPath}/assets/icons/comment.png"
                 style="width: 10px; height: 10px; margin-right: 5px;"
                 class="rounded me-2"
                 alt="...">
            <strong class="me-auto">Message</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <p id="toastMessage" style="color: rgb(5, 88, 211);">${message}</p>
        </div>
    </div>
</div>

<script>
    function showAlertMessage(message, color) {
        document.getElementById('toastMessage').innerHTML = message;
        const liveToast = document.getElementById('liveToast');
        const toastMessage = document.getElementById('toastMessage');
        toastMessage.style.color = color;
        var toast = new bootstrap.Toast(liveToast);
        toast.show();
    };
</script>