<div class="spinner-wrapper" style="display: none;">
    <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<script>
    function spinnerStart() {
        const spinnerWrapperE1 = document.querySelector('.spinner-wrapper');
        spinnerWrapperE1.style.display = 'flex';
    }

    function spinnerStop() {
        const spinnerWrapperE1 = document.querySelector('.spinner-wrapper');
        spinnerWrapperE1.style.display = 'none';
    }

    spinnerStart();
</script>