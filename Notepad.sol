//SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;

import
"@openzeppelin/contracts/access/AccessControl.sol";

contract TimestampedNotepad is AccessControl {
    // Define a custom role for writers 
    bytes32 public constant WRITER_ROLE = keccak256("WRITER_ROLE");

    //structure for each note 
    struct Note {
        string content;
        address author;
        uint256 timestamp;
    }

    // Array to score all notes 
    Note[] public notes;

    mapping(address => uint[]) public notesByAuthor;

    constructor() {
        // Grant admin role to the deployer
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender); // Also grant writer role to the deployer
        _grantRole(WRITER_ROLE, msg.sender);
    }
    //Only accounts with WRITER_ROLE can Add notes 
    function addNote(string memory _content) public onlyRole(WRITER_ROLE) {
        notes.push(Note({content:_content, author: msg.sender, timestamp: block.timestamp }));
        notesByAuthor[msg.sender].push(notes.length - 1);
    }
    // Anyone can read a spesific note by index 
    function getNote(uint index) public view returns (string memory content, address author, uint timestamp) {
        require(index < notes.length, "Invalid index");
        Note memory note = notes[index];
        return (note.content, note.author, note.timestamp);
    }

    // Return total number of notes 
    function totalNotes() public view returns (uint) {
        return notes.length;
    }

    function getNotesByAuthor(address author) public view returns (uint[] memory) {
        return notesByAuthor[author];
    }

    // Admin can grant writer role to another address
    function addWriter(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(WRITER_ROLE, account);
    }

    // Admin can revoke  writer role
    function removeWriter(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(WRITER_ROLE, account);
    }  
}