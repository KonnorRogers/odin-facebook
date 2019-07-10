class Notifications {
  constructor() {
    this.notifications = document.querySelector("[data-behavior='notifications']");
    this.notificationsLink = document.querySelector("[data-behavior='notifications-link']");
    this.notificationsCount = document.querySelector("[data-behavior='notifications-count']");
    this.notificationsItems = document.querySelector("[data-behavior='notification-items']");

    if (this.notifications !== null) { this.setup() };
  };


  setup() {
    this.notificationsLink.addEventListener("click", () => {
      this.handleClick;
    }, false);

    Rails.ajax({
      url: "/notifications.json",
      type: "GET",
      dataType: "JSON",
      success: (data) => { this.handleSuccess(data) }
    })
  };

  handleClick(e) {
    Rails.ajax({
      url: "/notifications/mark_as_read",
      type: "POST",
      dataType: "JSON",
      success: () => {
        this.notificationsCount.innerText = "";
      }
    });
  }

  // populates the icon 
  handleSuccess(data) {
    const items = data.map(n => 
      `<a class='dropdown-item' href=${n.url}> ${n.sender.first_name} ${n.sender.last_name} ${n.action} ${n.notifiable.type} </a>`
    );

    items.push("<a class='dropdown-item count' href='/notifications'> View all notifications </a>"); 
    if (items.length - 1 > 0) { this.notificationsCount.innerText = items.length - 1; };
    this.notificationsItems.innerHTML = items;
  };
};

document.addEventListener("turbolinks:load", () => {
  new Notifications
});

