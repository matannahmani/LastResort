const show2 = document.querySelector('#rare')
const show1 = document.querySelector('#normal')
let amount = 10;

function sleep (time) {
    return new Promise((resolve) => setTimeout(resolve, time));
}

async function postData(url , data ) {
  // Default options are marked with *
  const response = await fetch(url, {
    method: 'POST', // *GET, POST, PUT, DELETE, etc.
    mode: 'cors', // no-cors, *cors, same-origin
    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
    credentials: 'same-origin', // include, *same-origin, omit
    headers: {
      'Content-Type': 'application/json'
      // 'Content-Type': 'application/x-www-form-urlencoded',
    },
    redirect: 'follow', // manual, *follow, error
    referrerPolicy: 'no-referrer', // no-referrer, *client
    body: JSON.stringify(data) // body data type must match "Content-Type" header
  });
  return await response.json(); // parses JSON response into native JavaScript objects
}
postData('../user_units', { amount: amount })
  .then((data) => {
    console.log(data); // JSON data parsed by `response.json()` call
    show1(data)
  });

function show1(x){
    show1.play();
    sleep(2000).then(() => {
    alert(`you got ${x[0]}`);
    show1(x.next)
    });
}
function show2(x){
    show1.play();
    sleep(2000).then(() => {
    alert(`you got ${x[0]}`);
    show1(x)
    });
}
