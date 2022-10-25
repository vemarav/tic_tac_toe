import { Controller } from "@hotwired/stimulus"
import { getMetaValue } from "../utils";

export default class extends Controller {
  connect() {
    console.info('\nConnected to room controller...🎮');

    
  }

  play(event) {
    event.preventDefault();

    // return if cell is not empty?
    const cell = event.target;
    if (cell.innerText) return;

    // disable board access until next player turn
    const boardElement = document.getElementById('room_id');
    boardElement.classList.add('disabled');

    // get current player
    const currentPlayer = boardElement.dataset.current;
    // set cell value to currentPlayer
    cell.innerText = currentPlayer;

    // get url and current index and send it to server
    const url = cell.dataset.url;
    const index = cell.dataset.index;

    fetch(url, {
      method: 'PUT',
      body: JSON.stringify({
        room: {
          index,
          current: currentPlayer,
        }
      }),
      dataType: 'script',
      credentials: 'include',
      headers: {
        'X-CSRF-Token': getMetaValue('csrf-token'),
        'Content-Type': 'application/json'
      },
    });
  }
}