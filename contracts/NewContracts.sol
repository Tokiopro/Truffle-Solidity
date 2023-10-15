// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleBank {
    // 各アドレスの残高をマッピングで管理
    mapping(address => uint256) public balances;

    // コントラクトオーナー
    address public owner;

    // イベントの定義
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // コンストラクタ: コントラクトをデプロイしたアドレスをオーナーとして設定
    constructor() {
        owner = msg.sender;
    }

    // デポジット機能
    function deposit() public payable {
        // 0より大きい金額がデポジットされていることを確認
        require(msg.value > 0, "Amount should be greater than 0");

        // 残高を更新
        balances[msg.sender] += msg.value;

        // イベントを発火
        emit Deposited(msg.sender, msg.value);
    }

    // 引き出し機能
    function withdraw(uint256 amount) public {
        // 残高が要求された金額以上であることを確認
        require(balances[msg.sender] >= amount, "Not enough balance");

        // 残高を更新
        balances[msg.sender] -= amount;

        // Ether を送信
        payable(msg.sender).transfer(amount);

        // イベントを発火
        emit Withdrawn(msg.sender, amount);
    }

    // コントラクトに保持されている合計残高を取得
    function getTotalBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
