import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  const element = document.getElementById("room_id");
  const id = element ? element.dataset['channel'] : null;

  if(id) {
    consumer.subscriptions.create({
      channel: "RoomChannel",
      room_id: id,
    }, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log(this);
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log(this);
      },
    
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data);
      }
    });
  }
});
