//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimeLockedVault {
    address public immutable i_owner;
    address public immutable i_backupAddress;   // what if the owner loses his private key? 


    uint lockVaultUntil;

    constructor(uint lockPeriod, address backupAddress) {
        i_owner = msg.sender;
        lockVaultUntil = lockPeriod + block.timestamp;
        i_backupAddress = backupAddress;
    }

    modifier onlyOwner {
        require(msg.sender == i_owner);
        _;
    }

    event NewDeposit(uint amount, uint depositedAt);
    event earlyWithdrawlAttempt(uint timestamp, uint amount);

    function deposit() external payable onlyOwner {
        require(msg.value > 0, 'must deposit some eth');
        emit NewDeposit(msg.value, block.timestamp);
    }

    function getVaultBalance() external view onlyOwner returns (uint) {
        return address(this).balance;
    }

    function extendLockPeriod(uint secondsLonger) external onlyOwner {
        lockVaultUntil += secondsLonger;
    }

    function timeRemaining() external view onlyOwner returns (uint){
        return lockVaultUntil- block.timestamp;
    }

    event EtherWithdrawn(uint amount);

    struct Withdrawal {
        uint amount;
        uint timestamp;
    }

    Withdrawal[] withdrawals;


    function withdraw(uint _amount) external onlyOwner { 

        if(block.timestamp < lockVaultUntil) {
            emit earlyWithdrawlAttempt(block.timestamp, _amount);
        }

        require(block.timestamp > lockVaultUntil, 'cannot access wallet yet');
        require(_amount<= address(this).balance/10);

        //allow only 10% of vault money to be withdrawn every hour.

        if(withdrawals.length > 0){
            Withdrawal memory lastWithdrawal = withdrawals[withdrawals.length-1];
            require(block.timestamp >= lastWithdrawal.timestamp + 1 hours);
        }

        (bool withdrawn, ) = i_owner.call{value: _amount}('');
        require(withdrawn);

        Withdrawal memory withdrawal = Withdrawal({
            amount: _amount,
            timestamp: block.timestamp
        });
        withdrawals.push(withdrawal);

        emit EtherWithdrawn(_amount);
    }

    function destoryVault() external onlyOwner {
        require (block.timestamp > lockVaultUntil, 'vault is still collecting asset');
        require (address(this).balance == 0, 'vault still has assets');

        //for safety reasons if owner loses private key, transafer address(this).balance to backup! 
        selfdestruct(payable(i_backupAddress));
    }
}