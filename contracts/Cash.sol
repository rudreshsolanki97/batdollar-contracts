// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./common/ERC20Burnable.sol";

import "./common/Operator.sol";

contract Cash is ERC20Burnable, Operator {
    /**
     * @notice Constructs the Bat True Dollar ERC-20 contract.
     */
    constructor() public ERC20("Bat True Dollar", "BTD") {
        // Mints 1 Bat True Dollar to contract creator for initial pool setup
        _mint(msg.sender, 1 ether);
    }

    /**
     * @notice Operator mints basis cash to a recipient
     * @param recipient_ The address of recipient
     * @param amount_ The amount of basis cash to mint to
     * @return whether the process has been done
     */
    function mint(address recipient_, uint256 amount_) public onlyOperator returns (bool) {
        uint256 balanceBefore = balanceOf(recipient_);
        _mint(recipient_, amount_);
        uint256 balanceAfter = balanceOf(recipient_);

        return balanceAfter > balanceBefore;
    }

    function burn(uint256 amount) public override {
        super.burn(amount);
    }

    function burnFrom(address account, uint256 amount) public override onlyOperator {
        super.burnFrom(account, amount);
    }

    function governanceRecoverUnsupported(IERC20 _token, uint256 _amount, address _to) external onlyOperator {
        _token.transfer(_to, _amount);
    }
}