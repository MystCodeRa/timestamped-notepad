# timestamped-notepad
## Timestamped Notepad Smart Contract
This is a simple smart contract written in solidity that allows whitelisted writers to create timestamped notes on the blockchain.
It uses Openzeppeline's 'AccessControl' system to manage writer permissions securely.
## Features 
- Only users with 'WRITER_ROLE' Can add notes.
- Each note includes:
- 'content' (text),
- 'author' (Ethereum address),
- 'timestamp' (block time).
- Anyone can read any note by index.
- Admin can:
- Add or remove  writers.
- Writers can view a list of their own notes via mapping.
## Access Control
This contract uses Openzeppeli's 'AccessControl':
- 'DEFAULT_ADMIN_ROLE': Can assign or revoke 'WRITER_ROLE'.
- 'WRITER_ROLE': Can create notes.
## Contract Owerview
struct Note {
    string content;
    address author;
    uint256 timestamp;
}
Note[] public notes;
mapping(address => uint[]) public notesByAuthor;
