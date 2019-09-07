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
      this.getNewNotifications();
      this.addClickListener();

      // every 5 seconds sends off an ajax request
      this.turnOnTimer();
      this.toggleIntervalListener();
    };
  };

  addClickListener() {
    this.linkBtn.addEventListener("click", () => this.handleClick(), true);
    this.linkBtn.addEventListener("click", () => this.setCountInnerText(""), false);
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
    return this.timer = setInterval(() => this.getNewNotifications(), 10000)
  }

  turnOffTimer() {
    return this.timer = false;
  }

  getNewNotifications() {
    const url = `/${this.url()}.json`
    Rails.ajax({
      url: url,
      type: "GET",
      dataType: "JSON",
      success: (data) => { this.handleSuccess(data) }
    })
  };


  // populates the dropdown menu
  handleSuccess(data) {
    this.setCount(data);

    data = data.slice(0, 5);
    const items = data.map(n =>
      `<a class='dropdown-item' href='${n.url}'> ${n.sender.first_name} ${n.sender.last_name} ${n.action} ${n.notifiable.type} </a>`
    );

    this.pushStaticLinks(items);
    this.items.innerHTML = items.join("");
  };

  pushStaticLinks(items){
    items.push(`<a class='dropdown-item count' href='/${this.url()}'> View all ${this.behavior.split("-").join(" ")} </a>`);
  };

  setCount(items) {
    if (items.length > 5) { return this.setCountInnerText("5+") };
    if (items.length > 0) { this.setCountInnerText(items.length) };
  }


  handleClick(e) {
    Rails.ajax({
      url: `/${this.url()}/mark_as_read`,
      type: "POST",
      dataType: "JSON"
    });
  };

  setCountInnerText(text) {
    this.count.innerText = text;
  };

  url() {
    const url = this.behavior;
    if (!url.includes("-")) { return url };

    return url.split("-").join("_");
  };
};

class FriendRequests extends Notifications {
  constructor(behavior) {
    super(behavior);
  };

  pushStaticLinks(items) {
    super.pushStaticLinks(items);
    items.push(`<a class="dropdown-item" href="/friendships">
                   View all friends
                </a>`);
  };
}

document.addEventListener("turbolinks:load", () => {
  new Notifications("notifications")
  new FriendRequests("friend-requests")
});

