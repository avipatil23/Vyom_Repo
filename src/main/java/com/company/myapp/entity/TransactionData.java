package com.company.myapp.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.company.myapp.service.ProcessServiceImpl.ProcessOperation;
import com.company.myapp.service.ProcessServiceImpl.Status;

@Entity
@Table(name = "Transaction_Data")
public class TransactionData {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long Id;

	@Column(name = "Transaction_Number")
	private String transactionNumber;

	@Column(name = "Transaction_Type")
	private ProcessOperation transactionType;

	@Column(name = "Transaction_Date")
	private Date transactionDate;

	@Column(name = "Status")
	private Status status;

	@Column(name = "Changed_By")
	private String changedBy;

	@Column(name = "Changed_On")
	private Date changedOn;

	public String getTransactionNumber() {
		return this.transactionNumber;
	}

	public void setTransactionNumber(String transactionNumber) {
		this.transactionNumber = transactionNumber;
	}

	public ProcessOperation getTransactionType() {
		return this.transactionType;
	}

	public void setTransactionType(ProcessOperation transactionType) {
		this.transactionType = transactionType;
	}

	public Date getTransactionDate() {
		return this.transactionDate;
	}

	public void setTransactionDate(Date transactionDate) {
		this.transactionDate = transactionDate;
	}

	public Status getStatus() {
		return this.status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getChangedBy() {
		return this.changedBy;
	}

	public void setChangedBy(String changedBy) {
		this.changedBy = changedBy;
	}

	public Date getChangedOn() {
		return this.changedOn;
	}

	public void setChangedOn(Date changedOn) {
		this.changedOn = changedOn;
	}

}
