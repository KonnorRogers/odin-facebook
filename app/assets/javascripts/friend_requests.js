
class FriendRequests {
  constructor() {
    this.friendRequests = document.querySelector("[data-behavior='friend-requests']");
    this.friendRequestsLink = document.querySelector("[data-behavior='friend-requests-link']");
    this.friendRequestsCount = document.querySelector("[data-behavior='friend-requests-count']");
    this.friendRequestsItems = document.querySelector("[data-behavior='friend-requests-items']");
    
    if (this.friendRequests !== null) { 
      this.addClickListener() 
      this.getNewFriendRequests()

      // every 5 seconds sends off an ajax request for new
      // notifications
      setInterval(() => this.getNewFriendRequests(), 5000)
    };
  }

  addClickListener() {
    this.friendRequestsLink.addEventListener("click", this.handleClick, false);
  }

  getNewFriendRequests() {
    Rails.ajax({
      url: "/friend_requests.json",
      type: "GET",
      dataType: "JSON",
      success: (data) => { this.handleSuccess(data) }
    })
  };

  handleClick(e) {
    Rails.ajax({
      url: "/friend_requests/mark_as_read",
      type: "POST",
      dataType: "JSON",
      success: (data) => { "success" }
    });
  };

  // populates the icon 
  handleSuccess(data) {
    const unread_count = this.countUnread(data)
    const items = data.map(f =>
      `<a href=${f.url} class='dropdown-item'> ${f.message} </a>`
    );

    items.push("<a class='dropdown-item count' href='/friend_requests'>View all friend requests </a>"); 

    if (unread_count > 0) { this.setCount(unread_count) };
    this.friendRequestsItems.innerHTML = items.join("");
  };

  setCount(text) {
    this.friendRequestsCount.innerText = text;
  }

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
  new FriendRequests
});
