import Typed from 'typed.js';

var optionOne = {
  strings: ['The year is 2060...or 61...it could be 65 for all I know. The last few years have been a blur....'],
  typeSpeed: 70
};

var typedOne = new Typed('#text-one', optionOne);



var optionTwo = {
  strings: ['I try to put the past in the past, and lets just say that something happened. What I once thought of as the world, well... it’s not that way any more....'],
  typeSpeed: 50

};

// setTimeout(optionTwo, 10000);

// var typedTwo = new Typed('#text-two', optionTwo);

var optionThree = {
  strings: ['I was one of the lucky ones, working for an oil mining rig off the coast of Manila, when all of a sudden there was a flash of light.'],
  typeSpeed: 50
};

// var typedThree = new Typed('#text-three', optionThree);

setTimeout(() => {
  var typedTwo = new Typed('#text-two', optionTwo);
}, 10000)

setTimeout(() => {
  var typedThree = new Typed('#text-three', optionThree);
}, 20000)
