package banking;

import java.math.BigDecimal;

public class Transaction {
    private int transactionId;
    private String transactionTime;
    private String transactionType;
    private BigDecimal amount;
    private BigDecimal balance;
    private String username;
    private String toUser; // Add this attribute

    public Transaction(int transactionId, String transactionTime, String transactionType, BigDecimal amount, BigDecimal balance, String username, String toUser) {
        this.transactionId = transactionId;
        this.transactionTime = transactionTime;
        this.transactionType = transactionType;
        this.amount = amount;
        this.balance = balance;
        this.username = username;
        this.toUser = toUser; // Initialize this attribute
    }

    // Getters and setters

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public String getTransactionTime() {
        return transactionTime;
    }

    public void setTransactionTime(String transactionTime) {
        this.transactionTime = transactionTime;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getToUser() {
        return toUser;
    }

    public void setToUser(String toUser) {
        this.toUser = toUser;
    }
}
