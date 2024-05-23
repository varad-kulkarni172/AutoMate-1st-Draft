    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract CommuteIO {
        struct PassengerRequest {
            uint256 passRequestID;
            string passName;
            address passWalletAddress;
            string passHomeAddress;
            string passEMail;
            string passVehicleName;
            string passVehicleNumber;
            string passVehicleDetailsHash;
            string passGender;
            uint8 passRequestStatus; // 0 - pending, 1 - approved, 2 - rejected
        }

        struct Passenger {
            uint256 passID;
            string passName;
            address passWalletAddress;
            string passHomeAddress;
            string passEMail;
            string passVehicleName;
            string passVehicleNumber;
            string passVehicleDetailsHash;
            string passGender;
            string passReview;
            uint256 passRidesHosted;
            uint256 passRidesTaken;
        }

        mapping(uint256 => PassengerRequest) public passengerRequests;
        mapping(uint256 => Passenger) public passengers;
        uint256 public numPassRequests;
        uint256 public numPassengers;

        event PassengerRequestApproved(uint256 passRequestID, string passVehicleDetailsHash);
        event PassengerRequestRejected(uint256 passRequestID, string passVehicleDetailsHash);

        function addPassengerRequest(
            string memory _passName,
            address _passWalletAddress,
            string memory _passHomeAddress,
            string memory _passEMail,
            string memory _passVehicleName,
            string memory _passVehicleNumber,
            string memory _passVehicleDetailsHash,
            string memory _passGender
        ) public {
            numPassRequests++;
            passengerRequests[numPassRequests] = PassengerRequest({
                passRequestID: numPassRequests,
                passName: _passName,
                passWalletAddress: _passWalletAddress,
                passHomeAddress: _passHomeAddress,
                passEMail: _passEMail,
                passVehicleName: _passVehicleName,
                passVehicleNumber: _passVehicleNumber,
                passVehicleDetailsHash: _passVehicleDetailsHash,
                passGender: _passGender,
                passRequestStatus: 0
            });
        }

        function approvePassengerRequest(uint256 _passRequestID /*string memory  _currentDate*/) public {
            require(passengerRequests[_passRequestID].passRequestID != 0, "Request not found");
            require(passengerRequests[_passRequestID].passRequestStatus == 0, "Request already processed");

            passengerRequests[_passRequestID].passRequestStatus = 1;
            addPassenger(passengerRequests[_passRequestID]);

            emit PassengerRequestApproved(_passRequestID, passengerRequests[_passRequestID].passVehicleDetailsHash);
        }

        function rejectPassengerRequest(uint256 _passRequestID) public {
            require(passengerRequests[_passRequestID].passRequestID != 0, "Request not found");
            require(passengerRequests[_passRequestID].passRequestStatus == 0, "Request already processed");

            passengerRequests[_passRequestID].passRequestStatus = 2;

            emit PassengerRequestRejected(_passRequestID, passengerRequests[_passRequestID].passVehicleDetailsHash);
        }

        function addPassenger(PassengerRequest memory request) internal {
            numPassengers++;
            passengers[numPassengers] = Passenger({
                passID: numPassengers,
                passName: request.passName,
                passWalletAddress: request.passWalletAddress,
                passHomeAddress: request.passHomeAddress,
                passEMail: request.passEMail,
                passVehicleName: request.passVehicleName,
                passVehicleNumber: request.passVehicleNumber,
                passVehicleDetailsHash: request.passVehicleDetailsHash,
                passGender: request.passGender,
                passReview: "",
                passRidesHosted: 0,
                passRidesTaken: 0
            });
        }

        function getPassRequestDetails(uint256 _passRequestID) public view returns (PassengerRequest memory) {
            return passengerRequests[_passRequestID];
        }

        function getPassDetails(uint256 _passID) public view returns (Passenger memory) {
            return passengers[_passID];
        }

        function getnumPassRequests() public view returns (uint256) {
            return numPassRequests;
        }

        function getnumPassengers() public view returns (uint256) {
            return numPassengers;
        }
    }
