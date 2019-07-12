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
      this.getNewBehavior()

      // every 5 seconds sends off an ajax request
      setInterval(() => this.getNewBehavior(), 5000)
    };


  };

  addClickListener() {
    this.linkBtn.addEventListener("click", 
      () => this.handleClick, false);
  }

  getNewBehavior() {
    Rails.ajax({
      url: `/${this.behavior}.json`,
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

    items.push(`<a class='dropdown-item count' href='/${this.behavior}'> View all ${this.behavior} </a>`); 
    if (items.length - 1 > 5) { 
      this.setCount("5+") 
    } else if (items.length - 1 > 0) {
      this.setCount(items.length - 1)
    };
    this.items.innerHTML = items;
  };

  handleClick(e) {
    Rails.ajax({
      url: `/${this.behavior}/mark_as_read`,
      type: "POST",
      dataType: "JSON",
    });
  };

  setCount(text) {
    this.count.innerText = text;
  };

  countUnread(ary) {
    let unread_count = 0;
    ary.forEach(f => { 
      if (f.read === null) {
        unread_count += 1
      }
    })

    return unread_count;
  }
};

document.addEventListener("turbolinks:load", () => {
  new Notifications("notifications");
});

