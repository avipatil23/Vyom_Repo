package com.company.myapp.common;

import static org.apache.commons.text.CharacterPredicates.DIGITS;
import static org.apache.commons.text.CharacterPredicates.LETTERS;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.apache.commons.text.RandomStringGenerator;
import org.springframework.stereotype.Service;

import com.company.myapp.entity.TransactionData;

@Service
public class CommonUtility {

	private static final String TRANSACTION_NUMBER_DATE_FORMAT = "yyMMddHHmm";

	private Date systemDate;

	/**
	 * This method generates a unique transaction number
	 * 
	 * @return
	 */
	public synchronized String generateTransactionNumber() {
		final Timestamp createdOn = this.getSystemDateTimeStamp();
		final SimpleDateFormat df = new SimpleDateFormat(
				TRANSACTION_NUMBER_DATE_FORMAT);
		final String date = df.format(createdOn);
		final RandomStringGenerator generator = new RandomStringGenerator.Builder()
				.withinRange('0', 'z').filteredBy(LETTERS, DIGITS).build(); // Generate
																			// five
																			// random
																			// characters
																			// between
																			// range
																			// 0-9a-zA-Z

		final String transactionNumber = date + generator.generate(5);
		return transactionNumber;
	}

	public Timestamp getSystemDateTimeStamp() {
		this.systemDate = new Date(System.currentTimeMillis());
		System.out.println(this.systemDate.getTime());
		return new Timestamp(this.systemDate.getTime());
	}

	public Date getSystemDate() {
		this.systemDate = new Date(System.currentTimeMillis());
		System.out.println(this.systemDate.getTime());
		return this.systemDate;
	}

	public void saveTransactionData(TransactionData transactionData) {

	}
}
