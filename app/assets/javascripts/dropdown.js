/* When the user clicks on the button, toggle between hiding and showing the dropdown content */ 

function dropDown(e) {
  e.classList.toggle("show");
}

function removeDropDown(dropdown, closestString) {
  window.onclick = (e) => {
    if (e.target.closest(closestString)) { return false };

    if (dropdown.classList.contains('show')) {
      dropdown.classList.remove('show');
    }
  }
}

function addDropdown(dropdown, string) {
  document.querySelector(string).addEventListener("click", dropDown(dropdown), false);
};



document.addEventListener('turbolinks:load', () => {
  const nDropdown = document.querySelector("#myNotifications");
  const nString = ".notifications-btn"

  const fDropdown = document.querySelector("#myFriends")
  const fString = ".friend-requests-btn"

  addDropdown(nDropdown, nString);
  addDropdown(fDropdown, fString);
});
