// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControl {

    event GrantRole(address indexed account, bytes32 indexed role);
    event RevokeRole(address indexed account, bytes32 indexed role);

    mapping(bytes32=>mapping(address=>bool)) public roles;
   
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42

    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));
    //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96

    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender],"not authorized");
        _;
    }

    constructor(){
        _grantRole(msg.sender,ADMIN);
    }

    function _grantRole(address _account, bytes32 _role) internal {
        roles[_role][_account]=true;
        emit GrantRole(_account,_role);
    }

    function grantRole(address _account,bytes32 _role) external onlyRole(ADMIN){
        _grantRole(_account,_role);
    }

    function revokeRole(address _account,bytes32 _role) external onlyRole(ADMIN){
        roles[_role][_account]=false;
        emit RevokeRole(_account,_role);
    }

}
/* What are the benefits of having two functions to grant roles one internal and one external 
If I'm right, it's because we need to give the ADMIN role to the contract deployer. 
we are doing it in the constructor function. so here using an internal function will cost a lower fee.*/
