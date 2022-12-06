// SPDX-License-Identifier: MIT

pragma solidity 0.8.8; // ^ any version above is OK


// similar to a class
contract SimpleStorage {
    // boolean, uint, int, address, bytes
    uint256 favoriteNumber =4 ; // initialized to zero

    mapping (string => uint256) public nameToFavoriteNumber;

    // new instance of People
    People public person = People({ favoriteNumber: 2, name: "Shawn Esquivel" });

    // lists of variables inside objects are indexed
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // 
    // uint256[] public favoriteNumbersList;
    // Dynamic [], fixed of length N [N]
    People[] public people;
    // 0: Shawn, 2: 3, 

    function store (uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber * 5 * 5 * 5**2;
    }
 
    function addPerson(string memory _name, uint256   _favoriteNumber) public {
        // _name = "shay";
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }
}