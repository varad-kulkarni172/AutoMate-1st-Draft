pragma solidity ^0.8.0;

contract CommuteIO {
    // Mapping to store passenger requests
    mapping (uint256 => PassengerRequest) public passengerRequests;
    // Mapping to store enrolled passengers
    mapping (uint256 => Passenger) public passengers;
    // Variable to store the number of passenger requests
    uint256 public numPassRequests;
    // Variable to store the number of enrolled passengers
    uint256 public numPassengers;

    // Struct to represent a passenger request
    struct PassengerRequest {
        uint256 id;
        string name;
        address walletAddress;
        string homeAddress;
        string email;
        string vehicleName;
        string vehicleNumber;
        string vehicleDetailsHash;
        uint256 gender;
        uint256 requestStatus;
    }

    // Struct to represent an enrolled passenger
    struct Passenger {
        uint256 id;
        string name;
        address walletAddress;
        string homeAddress;
        string email;
        string vehicleName;
        string vehicleNumber;
        string vehicleDetailsHash;
        uint256 gender;
        uint256 review;
        uint256 ridesHosted;
        uint256 ridesTaken;
    }

    // Event emitted when a passenger request is approved
    event PassengerRequestApproved(uint256 requestId);

    // Event emitted when a passenger request is rejected
    event PassengerRequestRejected(uint256 requestId);

    // Function to add a new passenger request
    function addPassengerRequest(
        string memory _name,
        address _walletAddress,
        string memory _homeAddress,
        string memory _email,
        string memory _vehicleName,
        string memory _vehicleNumber,
        string memory _vehicleDetailsHash,
        uint256 _gender
    ) public {
        numPassRequests++;
        passengerRequests[numPassRequests] = PassengerRequest(
            numPassRequests,
            _name,
            _walletAddress,
            _homeAddress,
            _email,
            _vehicleName,
            _vehicleNumber,
            _vehicleDetailsHash,
            _gender,
            0 // Initial request status is 0 (pending)
        );
    }

    // Function to approve a passenger request
    function approvePassengerRequest(uint256 _requestId) public {
        require(passengerRequests[_requestId].requestStatus == 0, "Request is not pending");
        passengerRequests[_requestId].requestStatus = 1; // Update request status to 1 (approved)
        emit PassengerRequestApproved(_requestId);
    }

    // Function to reject a passenger request
    function rejectPassengerRequest(uint256 _requestId) public {
        require(passengerRequests[_requestId].requestStatus == 0, "Request is not pending");
        passengerRequests[_requestId].requestStatus = 2; // Update request status to 2 (rejected)
        emit PassengerRequestRejected(_requestId);
    }

    // Function to get the number of passenger requests
    function GetnumPassRequests() public view returns (uint256) {
        return numPassRequests;
    }

    // Function to get the details of a passenger request
    function GetPassRequestDetails(uint256 _requestId) public view returns (
        uint256,
        string memory,
        address,
        string memory,
        string memory,
        string memory,
        uint256,
        uint256
    ) {
        PassengerRequest storage request = passengerRequests[_requestId];
        return (
            request.id,
            request.name,
            request.walletAddress,
            request.homeAddress,
            request.email,
            request.vehicleName,
            request.vehicleNumber,
            request.requestStatus
        );
    }

    // Function to get the number of enrolled passengers
    function GetnumPassengers() public view returns (uint256) {
        return numPassengers;
    }

    // Function to get the details of an enrolled passenger
    function GetPassDetails(uint256 _passengerId) public view returns (
        uint256,
        string memory,
        address,
        string memory,
        string memory,
        string memory,
        string memory,
        uint256,
        uint256,
        uint256
    ) {
        Passenger storage passenger = passengers[_passengerId];
        return (
            passenger.id,
            passenger.name,
            passenger.walletAddress,
            passenger.homeAddress,
            passenger.email,
            passenger.vehicleName,
            passenger.vehicleNumber,
            passenger.review,
            passenger.ridesHosted,
            passenger.ridesTaken
        );
    }
}