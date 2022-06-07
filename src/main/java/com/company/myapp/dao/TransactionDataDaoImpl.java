package com.company.myapp.dao;

import java.sql.Types;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.company.myapp.entity.TransactionData;

@Repository("transactionDataDao")
public class TransactionDataDaoImpl implements TransactionDataDao {

	@Autowired
	@Qualifier("dataSource")
	private DataSource dataSource;

	private NamedParameterJdbcTemplate jdbcTemplate = null;

	private static final String insertSql =

			"INSERT INTO TRANSACTIONDATA (" +

					" Transaction_Number, " +

					" Transaction_Type, " +

					" changedBy, " +

					" status) " +

					"VALUES (?, ?, ?, ?)";

	private NamedParameterJdbcTemplate getJdbcTemplate() {
		if (this.jdbcTemplate == null) {
			this.jdbcTemplate = new NamedParameterJdbcTemplate(this.dataSource);
		}
		return this.jdbcTemplate;
	}

	private JdbcTemplate jdbcTemplateObject;

	public void setDataSource() {
		this.jdbcTemplateObject = new JdbcTemplate(this.dataSource);
	}

	@Transactional
	public void savetransactionData(TransactionData transactionData) {
		JdbcTemplate template = new JdbcTemplate(this.dataSource);

		// define query arguments
		Object[] params = new Object[] { transactionData.getTransactionNumber(),
				transactionData.getTransactionType(),
				transactionData.getChangedBy(), transactionData.getStatus() };

		// define SQL types of the arguments
		int[] types = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR };

		// execute insert query to insert the data
		// return number of row / rows processed by the executed query
		int row = template.update(insertSql, params, types);
		System.out.println(row + " row inserted.");

	}
}
