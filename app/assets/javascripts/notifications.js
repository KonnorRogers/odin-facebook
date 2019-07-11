class Notifications {
  constructor() {
    this.notifications = document.querySelector("[data-behavior='notifications']");
    this.notificationsLink = document.querySelector("[data-behavior='notifications-link']");
    this.notificationsCount = document.querySelector("[data-behavior='notifications-count']");
    this.notificationsItems = document.querySelector("[data-behavior='notifications-items']");

    // Checks that the notifications button exists
    if (this.notifications !== null) { 
      this.addClickListener() 
      this.getNewNotifications()

      // every 5 seconds sends off an ajax request for new
      // notifications
      setInterval(() => this.getNewNotifications(), 5000)
    };


  };

  addClickListener() {
    this.notificationsLink.addEventListener("click", 
      () => this.handleClick, false);
  }

  getNewNotifications() {
    Rails.ajax({
      url: "/notifications.json",
      type: "GET",
      dataType: "JSON",
      success: (data) => { this.handleSuccess(data) }
    })
  };


  // populates the dropdown menu
  handleSuccess(data) {
    const items = data.map(n => 
      `<a class='dropdown-item' href=${n.url}> ${n.sender.first_name} ${n.sender.last_name} ${n.action} ${n.notifiable.type} </a>`
    );

    items.push("<a class='dropdown-item count' href='/notifications'> View all notifications </a>"); 
    if (items.length - 1 > 5) { 
      this.setCount("5+") 
    } else if (items.length - 1 > 0) {
      this.setCount(items.length - 1)
    };
    this.notificationsItems.innerHTML = items;
  };

  handleClick(e) {
    Rails.ajax({
      url: "/notifications/mark_as_read",
      type: "POST",
      dataType: "JSON",
    });
  }

  setCount(text) {
    this.notificationsCount.innerText = text;
  }
};

document.addEventListener("turbolinks:load", () => {
  new Notifications
});

