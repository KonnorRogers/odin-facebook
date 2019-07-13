/* When the user clicks on the button, toggle between hiding and showing the dropdown content */ 

const dropdownToggle = (e) => {
  e.classList.toggle("show");
}

const removeDropDown = (dropdown, closestString) => {
  window.addEventListener("click", (e) => {
    if (e.target.closest(closestString)) { return false };

    if (!dropdown.classList.contains('show')) { return false };

    dropdown.classList.remove('show');
  });
};

const addDropdown = (dropdown, btnString) => {
  document.querySelector(btnString).addEventListener("click", () => {
    dropdownToggle(dropdown)
  }, false);
};



document.addEventListener('turbolinks:load', () => {
  const btns = [".notifications-btn", ".friend-requests-btn"];
  const dropDowns = ["#myNotifications", "#myFriends"];

  for (let i = 0; i < btns.length; i++) {
    btn = btns[i];
    dropdown = document.querySelector(dropDowns[i]);

    addDropdown(dropdown, btn);
    removeDropDown(dropdown, btn);
  };
});
