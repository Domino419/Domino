const clock = document.querySelector("h2#clock");

function getClock() {
    const date = new Date();
    const HOURS = String(date.getHours()).padStart(2, "0");
    const MINUTES = String(date.getMinutes()).padStart(2, "0");
    const SECONDS = String(date.getSeconds()).padStart(2, "0");
    clock.innerText = `${HOURS}:${MINUTES}:${SECONDS} `;
}
getClock();
setInterval(getClock, 1000);

//"1".padStart(2, "0");
