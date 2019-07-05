/* When the user clicks on the button, toggle between hiding and showing the dropdown content */ 
function dropDown() {
  document.getElementById("myDropdown").classList.toggle("show");
}

window.onclick = function(e) {
  if (e.target.matches('.dropbtn')) { return false };
  if (e.target.closest('.dropbtn')) { return false };

  const myDropdown = document.getElementById("myDropdown");
  if (myDropdown.classList.contains('show')) {
    myDropdown.classList.remove('show');
  }
}


document.addEventListener('DOMContentLoaded', function () {
  let dropbtn = document.getElementById("drop-btn");
  dropbtn.addEventListener("click", dropDown, false);
});
