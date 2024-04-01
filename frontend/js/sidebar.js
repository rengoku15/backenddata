document.addEventListener("DOMContentLoaded", function() {
    var sidebarHtml = `
    <div class="sidebar">
        <h1>PiRide</h1>
        <a href="index.html">Home</a>
        <a href="dashboard.html">Dashboard</a>
        <a href="search.html">Route Search</a>
    </div>`;

    var sidebarContainer = document.getElementById("sidebar-container");
    sidebarContainer.innerHTML = sidebarHtml;
});
