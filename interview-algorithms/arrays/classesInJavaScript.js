var object1 = { value: 10 }
var object2 = object1
var object3 = { value: 10 }

const object4 = {
  a: function() {
    console.log(this)
  }
}


object4.a()

// only now will the this be different than the window object,

function b() {
  console.log(this);
}

// this will just reference the window

class Player {
  constructor(name, type) {
    console.log(this)
    this.name = name;
    this.type = type;
  }
  introduce() {
    console.log(`Hi I am ${this.name}, I'm a ${this.type}`)
  }
}

class Wizard extends Player {
  constructor(name,type) {
    super(name, type)
    // super creates the connection to this. so you have to call super first 
    console.log('wizrd', 'this')
  }
  play() {
    console.log(`WEEEe I'm a ${this.type}`)
  }
}

const wizard1 = new Wizard("Shelly", "Healer")
const wizard2 = new Wizard("Sean", "Mage")
