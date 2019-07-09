class Notifications {
  constructor() {
    this.notifications = document.querySelector("[data-behavior='notifications']");
    if (this.notifications !== null) { this.setup() };
  };


  setup() {
    Rails.ajax({
      url: "/notifications.json",
      type: "GET",
      dataType: "JSON",
      success: (data) => { this.handleSuccess(data) }
    })
  };

  handleSuccess(data) {
    const items = data.map((n) => 
      `<li class='dropdown-item'> ${n.sender.first_name} ${n.sender.last_name} ${n.action} you a ${n.notifiable.type} </li>`
    );
    return items
  }
}

document.addEventListener("turbolinks:load", () => {
  new Notifications
});

