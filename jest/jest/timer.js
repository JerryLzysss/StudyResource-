function timerGame(callback) {
  console.log('Ready....go!');
  setTimeout(() => {
    console.log("Time's up -- stop!");
    callback && callback();
  }, 1000);
}

function infiniteTimerGame(callback) {
  console.log('Ready....go!');

  setTimeout(() => {
    console.log("Time's up! Check the console for the next scheduled game");
    callback && callback();

    setTimeout(() => {
      infiniteTimerGame(callback);
    }, 10000);
  }, 1000);
}

module.exports = { timerGame, infiniteTimerGame };
