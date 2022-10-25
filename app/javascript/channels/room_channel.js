import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  const element = document.getElementById("room_id");
  const id = element ? element.dataset['channel'] : null;

  if (id) {
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
        const { room, playerId, won } = data;
        console.log(data);
        this.enableBoard({ room, playerId });
        this.updateBoard(room);
        this.announceWinner(won);
        setTimeout(() => { if (won) this.reload() }, 20);
      },

      reload() {
        window.location.reload();
      },

      announceWinner(winner) {
        switch (winner) {
          case 'X':
            alert('Player "X" WINS');
            break;
          case 'O':
            alert('Player "O" WINS');
            break;
          case 'Tie':
            alert("It's a \"Tie\"");
            break;
        }
      },

      updateBoard({ board }) {
        board.forEach((value, index) => {
          const cell = document.querySelector(`[data-index="${index}"]`);
          cell.innerText = value;
        })
      },

      enableBoard({ room, playerId }) {
        const cookieStrings = document.cookie.split(';');
        const cookies = {};
        cookieStrings.forEach(x => {
          const [key, value] = x.split('=');
          cookies[key.trim()] = value;
        })

        if (playerId != cookies['uuid']) {
          const boardElement = document.getElementById('room_id');
          boardElement.classList.remove('disabled');
          boardElement.dataset.current = room.current;
        }
      }
    });
  }
});
