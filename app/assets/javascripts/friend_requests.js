
class FriendRequests {
  constructor() {
    this.friendRequests = document.querySelector("[data-behavior='friend-requests']");
    this.friendRequestsLink = document.querySelector("[data-behavior='friend-requests-link']");
    this.friendRequestsCount = document.querySelector("[data-behavior='friend-requests-count']");
    this.friendRequestsItems = document.querySelector("[data-behavior='friend-requests-items']");
    
    if (this.friendRequests !== null) { this.setup() };
  }

  setup() {
    this.friendRequestsLink.addEventListener("click", this.handleClick, false);

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
      success: () => {
        console.log(this.friendRequestsCount);
        this.friendRequestsCount.innerText = null;
      }
    });
  };

  // populates the icon 
  handleSuccess(data) {
    console.log(data)
    const items = data.map(f => 
      `<a href=${f.url} class='dropdown-item'> ${f.message} </a>`
    );

    items.push("<a class='dropdown-item count' href='/friend_requests'>View all friend requests </a>"); 
    if (items.length - 1 > 0) { this.friendRequestsCount.innerText = items.length - 1; };
    this.friendRequestsItems.innerHTML = items;
  };
};

document.addEventListener("turbolinks:load", () => {
  new FriendRequests
});
