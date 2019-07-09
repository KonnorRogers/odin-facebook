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
      // `<li class='dropdown-item'> ${n.actor} ${n.action} ${n.notifiable.type} </li>`
      console.log(n)
    );
    console.log(items)
  }
}

document.addEventListener("turbolinks:load", () => {
  new Notifications
});

