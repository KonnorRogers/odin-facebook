class Notifications {
  constructor(behavior) {
    this.behavior = behavior
    this.behaviorElement = document.querySelector(`[data-behavior=${behavior}]`);
    this.linkBtn = document.querySelector(`[data-behavior='${behavior}-link']`);
    this.count = document.querySelector(`[data-behavior='${behavior}-count']`);
    this.items = document.querySelector(`[data-behavior='${behavior}-items']`);

    // Checks that the behavior button exists
    if (this.behaviorElement !== null) { 
      this.addClickListener() 
      this.getNewNotifications()

      // every 5 seconds sends off an ajax request
      const ajax = setInterval(() => this.getNewNotifications(), 10000);
      this.toggleIntervalListener(ajax);
    };


  };

  addClickListener() {
    this.linkBtn.addEventListener("click", this.handleClick, false);
    this.linkBtn.addEventListener("click", () => this.setCount(""), false)
  }

  toggleIntervalListener(interval) {
    this.linkBtn.addEventListener("click", () => clearInterval(interval), false);
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

    items.push(`<a class='dropdown-item count' href='/${this.behavior}'> View all ${this.behavior.split("-").join(" ")} </a>`); 
    if (items.length - 1 > 5) { 
      this.setCount("!") 
    } else if (items.length - 1 > 0) {
      this.setCount(items.length - 1)
    };
    this.items.innerHTML = items.join("");
  };

  handleClick(e) {
    Rails.ajax({
      url: "/notifications/mark_as_read",
      type: "POST",
      dataType: "JSON"
    });
  };

  setCount(text) {
    this.count.innerText = text;
  };
};

document.addEventListener("turbolinks:load", () => {
  new Notifications("notifications");
  new Notifications("friend-requests");
});

