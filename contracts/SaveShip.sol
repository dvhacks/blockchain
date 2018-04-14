pragma solidity ^0.4.21;
// We have to specify what version of compiler this code will compile with

contract SaveShip {
    /* mapping field below is equivalent to an associative array or hash.
    The key of the mapping is candidate name stored as type bytes32 and value is
    an unsigned integer to store the vote count
    */

    address public sender;
    address public recipient;
    address public courrier;
    uint public cost;
    enum State {Created, Pending, InProgress, Fulfilled, Rejected}
    State public state;

    event Aborted();
    event Fulfilled();

    /// Create a SaveShip contract sending a shipment for a cost
    function SaveShip(uint _cost) public {
        sender = msg.sender;
        cost = _cost;
        state = State.Created;
    }

    /// Pay for the shipment into escrow
    function enterRecipient() public payable {
        require(state == State.Created);
        require(msg.value == cost);

        recipient = msg.sender;
        state = State.Pending;
    }

    /// Pay insurance of the package into escrow
    function enterCourrier() public payable {
        require(state == State.Pending);
        require(msg.value == cost);
        // TODO this should be true
//        require(msg.sender != recipient)

        courrier = msg.sender;
        state = State.InProgress;
    }

    function abort() public {
        require(state == State.Pending || state == State.InProgress || state == State.Rejected);

        emit Aborted();

        state = State.Rejected;

        recipient.transfer(cost);
        courrier.transfer(cost);
    }

    function fulfill() public {
        require(state == State.InProgress);

        emit Fulfilled();

        state = State.Fulfilled;

        sender.transfer(cost);
        courrier.transfer(cost);
    }
}
