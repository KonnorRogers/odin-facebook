/* When the user clicks on the button, toggle between hiding and showing the dropdown content */ 

function dropDown(element) {
  element.classList.toggle("show");
}

window.onclick = (e) => {
  if (e.target.closest('.dropbtn')) { return false };

  const myDropdown = document.getElementById("myDropdown");
  if (myDropdown.classList.contains('show')) {
    myDropdown.classList.remove('show');
  }
}

const myFriendRequests = document.getElementById("myFriends");
const myNotifications = document.getElementById("myNotifications");

document.addEventListener('turbolinks:load', () => {
  const friendBtn = document.querySelector(".friend-requests-btn");
  notifications.addEventListener("click", dropDown(myFriendRequests), false);

  const notificationsBtn = document.querySelector(".notifications-btn")
  notificationsBtn.addEventLister("click", dropDown(myNotifications), false);
});
