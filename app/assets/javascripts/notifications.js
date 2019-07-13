class Notifications {
  constructor(behavior) {
    this.behavior = behavior
    this.behaviorElement = document.querySelector(`[data-behavior=${behavior}]`);
    this.linkBtn = document.querySelector(`[data-behavior='${behavior}-link']`);
    this.count = document.querySelector(`[data-behavior='${behavior}-count']`);
    this.items = document.querySelector(`[data-behavior='${behavior}-items']`);
    this.timer = false;

    // Checks that the behavior button exists
    if (this.behaviorElement !== null) { 
      this.addClickListener() 
      this.getNewNotifications()

      // every 5 seconds sends off an ajax request
      this.turnOnTimer();
      this.toggleIntervalListener();
    };


  };

  addClickListener() {
    this.linkBtn.addEventListener("click", this.handleClick, false);
    this.linkBtn.addEventListener("click", () => this.setCount(""), false)
  }

  toggleIntervalListener(interval) {
    // When the button is clicked, tells you that the interval is no longer
    // running in the background
    this.linkBtn.addEventListener("click", () => { 
      clearInterval(this.timer)
      this.turnOffTimer();
    }, false);

    // IF anywhere outside the dropdown is clicked, restart the interval timer
    addEventListener("click", (e) => { 
      const dropdown = e.target.closest(`[data-behavior='${this.behavior}']`)
      if (dropdown === null && this.timer === false) { 
        return this.turnOnTimer();
      };
    }, false);
  }

  turnOnTimer() {
    return this.timer = setInterval(() => this.getNewNotifications(), 5000)
  }

  turnOffTimer() {
    return this.timer = false;
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
    const filteredData = this.filterData(data);
    const items = filteredData.map(n => 
      `<a class='dropdown-item' href=${n.url}> ${n.sender.first_name} ${n.sender.last_name} ${n.action} ${n.notifiable.type} </a>`
    );

    items.push(`<a class='dropdown-item count' href='/notifications'> View all ${this.behavior.split("-").join(" ")} </a>`); 
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

  filterData(data) {
    return data.filter(n => n.isFriendRequest === false)
  }
};

class FriendRequests extends Notifications {
  // Overrides the original filterData so that it only returns friendRequests
  filterData(data) {
    return data.filter(n => n.isFriendRequest === true);
  };
};

document.addEventListener("turbolinks:load", () => {
  new Notifications("notifications");
  new FriendRequests("friend-requests");
});

