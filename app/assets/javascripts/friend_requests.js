
class FriendRequests {
  constructor() {
    this.friendRequests = document.querySelector("[data-behavior='friend-requests']");
    this.friendRequestsLink = document.querySelector("[data-behavior='friend-requests-link']");
    this.friendRequestsCount = document.querySelector("[data-behavior='friend-requests-count']");
    this.friendRequestsItems = document.querySelector("[data-behavior='friend-requests-items']");
    
    if (this.friendRequests !== null) { this.setup() };
  }

  setup() {
    this.friendRequestsLink.addEventListener("click", () => {
      this.handleClick;
    }, false);

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
        this.friendRequestsCount.innerText = "";
      }
    });
  }

  // populates the icon 
  handleSuccess(data) {
    console.log(data)
    // const items = data.map(n => 
    //   "<li> Hi </li>"
    // );

    // items.push("Hello"); 
    // // if (items.length - 1 > 0) { this.friendRequestsCount.innerText = items.length - 1; };
    // this.friendRequestsItems.innerHTML = "<h1> Hi </h1>";
  };
};

document.addEventListener("turbolinks:load", () => {
  friends = new FriendRequests
    console.log(friends.friendRequestsItems);
    console.log(friends.friendRequests);
    console.log(friends.friendRequestsCount);
    console.log(friends.friendRequestsLink);
});
