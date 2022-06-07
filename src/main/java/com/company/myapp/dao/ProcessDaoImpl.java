package com.company.myapp.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import com.company.myapp.dto.ProcessDto;
import com.company.myapp.dto.ProcessMetaDataDto;

@Repository("processDao")
public class ProcessDaoImpl implements ProcessDao {

	@Autowired
	@Qualifier("dataSource")
	private DataSource dataSource;

	private NamedParameterJdbcTemplate jdbcTemplate = null;

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
	public void createMetaDataTables() throws Exception {
		String processMetaDataSql = "create table ProcessMetaData(ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,ProcessName varchar(50))";
		String fieldMetaDataSql = "create table FieldMetaData(ID Int,FieldName varchar(50),DataType varchar(50),length int,FOREIGN KEY(ID) REFERENCES ProcessMetaData(ID))";
		String Name = null;
		try {
			Name = this.getQueryResult(
					"select name from SYS.tables where tables.name='ProcessMetaData'");
			// System.out.println("Process Table Name:"+Name);
			if (Name != null) {
				System.out.println("Table is already exist");
			} else {
				this.jdbcTemplateObject.execute(processMetaDataSql);
			}

			Name = this.getQueryResult(
					"select name from SYS.tables where tables.name='FieldMetaData'");

			if (Name != null) {
				System.out.println("Table is already exist");
			} else {
				this.jdbcTemplateObject.execute(fieldMetaDataSql);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public String getQueryResult(String sql) throws Exception {
		try {
			this.setDataSource();
			return this.jdbcTemplateObject.query(sql,
					new ResultSetExtractor<String>() {

						public String extractData(ResultSet rs)
								throws SQLException, DataAccessException {
							return rs.next() ? rs.getString(1) : null;
						}
					});
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	@Transactional
	public void insertFieldMetaData(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception {
		try {
			String insertProcessMetaDataQuery = "insert INTO" + " "
					+ "ProcessMetaData" + " " + "(ProcessName)" + " " + "Values"
					+ "(" + "'" + ProcessName + "'" + ")";
			this.jdbcTemplateObject.execute(insertProcessMetaDataQuery);
			String getSQLQuery = "select ID from ProcessMetaData where ProcessName="
					+ "'" + ProcessName + "'";
			Integer id = this.jdbcTemplateObject.queryForObject(getSQLQuery,
					int.class);
			String sqlReqID = "INSERT INTO FieldMetaData VALUES(" + id
					+ ",'ReqID','String',20)";
			this.jdbcTemplateObject.execute(sqlReqID);
			for (int i = 0; i <= (fieldNames.length - 1); i++) {
				String insertFieldMetaDataQuery = "INSERT INTO" + " "
						+ "FieldMetaData" + " " + "VALUES" + "(" + "'" + id
						+ "'" + "," + "'" + fieldNames[i] + "'" + "," + "'"
						+ Datatypes[i] + "'" + "," + "'" + length[i] + "'"
						+ ")";
				this.jdbcTemplateObject.execute(insertFieldMetaDataQuery);
			}
			String sqlStatus = "INSERT INTO FieldMetaData VALUES(" + id
					+ ",'Status','String',20)";
			this.jdbcTemplateObject.execute(sqlStatus);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	@Transactional
	public void createProcessTable(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception {
		try {
			String sqlQuery = this.buildSqlQuery(ProcessName, fieldNames,
					Datatypes, length);
			this.jdbcTemplateObject.execute(sqlQuery);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	@Transactional
	public void createAuditProcessTable(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception {
		try {
			String sqlQuery = this.buildAuditSqlQuery(ProcessName, fieldNames,
					Datatypes, length);
			this.jdbcTemplateObject.execute(sqlQuery);

			String triggerScript = this.createSqlTrigger(ProcessName,
					fieldNames, Datatypes, length);

			this.jdbcTemplateObject.execute(triggerScript);

		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public String createSqlTrigger(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception {
		StringBuilder stringBuilder = null;
		try {

			String sql = "CREATE TRIGGER UPD_AUDIT_" + ProcessName + " ON "
					+ ProcessName + " AFTER UPDATE \n " + "AS \n "
					+ "INSERT INTO AUDIT_" + ProcessName
					+ " ( CRUD, UPDATE_TIME, ID, Status, Error_Msg ";

			stringBuilder = new StringBuilder(sql);
			for (int i = 0; i <= (fieldNames.length - 1); i++) {
				stringBuilder.append(", " + fieldNames[i]);
			}
			stringBuilder.append(
					") SELECT 'U',CURRENT_TIMESTAMP, ReqID, Status, Error_Msg");

			for (int i = 0; i <= (fieldNames.length - 1); i++) {
				stringBuilder.append(", " + fieldNames[i]);
			}

			stringBuilder.append(" FROM DELETED \n GO;");
			System.out.println("SQL = " + stringBuilder.toString());
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return stringBuilder.toString();

	}

	public String buildSqlQuery(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception {
		StringBuilder stringBuilder = null;
		try {
			String sql = "CREATE TABLE " + "\"" + ProcessName + "\""
					+ "(ReqID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, ";
			stringBuilder = new StringBuilder(sql);
			for (int i = 0; i <= (fieldNames.length - 1); i++) {
				if (Datatypes[i].equals("Integer")) {

					stringBuilder.append("\"" + fieldNames[i] + "\"");

					stringBuilder.append(" bigint");
				}
				if (Datatypes[i].equals("String")) {

					stringBuilder.append("\"" + fieldNames[i] + "\"");

					stringBuilder.append(" varchar(" + length[i] + ")");
				}
				if ((i + 1) < fieldNames.length) {
					stringBuilder.append(",");
				}
			}
			stringBuilder
					.append(",Status varchar(25), Error_Msg varchar(5000))");
			System.out.println("SQL = " + stringBuilder.toString());
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return stringBuilder.toString();

	}

	public String buildAuditSqlQuery(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception {
		StringBuilder stringBuilder = null;
		try {
			String sql = "CREATE TABLE " + "\"" + "Audit_" + ProcessName + "\""
					+ "(ReqID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, CRUD varchar(1),UPDATE_TIME datetime, ID INT,";
			stringBuilder = new StringBuilder(sql);
			for (int i = 0; i <= (fieldNames.length - 1); i++) {
				if (Datatypes[i].equals("Integer")) {

					stringBuilder.append("\"" + fieldNames[i] + "\"");

					stringBuilder.append(" bigint");
				}
				if (Datatypes[i].equals("String")) {

					stringBuilder.append("\"" + fieldNames[i] + "\"");

					stringBuilder.append(" varchar(" + length[i] + ")");
				}
				if ((i + 1) < fieldNames.length) {
					stringBuilder.append(",");
				}
			}
			stringBuilder
					.append(",Status varchar(25), Error_Msg varchar(5000))");
			System.out.println("SQL = " + stringBuilder.toString());
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return stringBuilder.toString();

	}

	public Map<String, Object> viewProcessByID(Integer ID, String processName)
			throws Exception {
		String sql = null;
		Map<String, Object> processRecords = null;
		Map<String, String> namedParameters = new HashMap<String, String>();
		try {
			sql = "SELECT * FROM " + "\"" + processName + "\"" + " WHERE ReqID="
					+ ID;
			List<Map<String, Object>> rows = this.getJdbcTemplate()
					.queryForList(sql, namedParameters);
			processRecords = rows.get(0);
		} catch (Exception e) {

			throw e;
		}
		return processRecords;
	}

	public List<ProcessDto> listProcessData(String processName, String status)
			throws Exception {
		List<ProcessDto> lstProcessDto = new ArrayList<ProcessDto>();
		String sql = "";
		try {
			if (status.equals("Both")) {
				sql = "SELECT * FROM " + "\"" + processName + "\"" + "";
			} else {
				sql = "SELECT * FROM " + "\"" + processName + "\""
						+ " WHERE Status='" + status + "'";
			}
			Map<String, String> namedParameters = new HashMap<String, String>();
			List<Map<String, Object>> rows = this.getJdbcTemplate()
					.queryForList(sql, namedParameters);
			for (Map<String, Object> row : rows) {
				ProcessDto processDto = new ProcessDto();
				if (processName.equals("NAV")) {
					processDto.setReqID((String) (row.get("ReqID")));
					processDto.setApplicationNo((String) (row.get("AppNo")));
					processDto.setAreaCode((String) (row.get("AreaCode")));
					processDto.setBankCode((String) (row.get("BankCode")));
				} else if (processName.equals("Termclaim")) {
					processDto.setPolicyNo((String) (row.get("PolicyNumber")));
					processDto.setName((String) (row.get("Name")));
					processDto.setAge((String) (row.get("Age")));
					processDto.setAddress((String) (row.get("Address")));
				}
				processDto.setProducttype((String) (row.get("ProductType")));
				processDto.setPayType((String) (row.get("PayType")));
				processDto.setPremium((String) (row.get("Premium")));
				processDto.setStatus((String) (row.get("Status")));

				lstProcessDto.add(processDto);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return lstProcessDto;
	}

	public List<ProcessMetaDataDto> listProcessMetatData() throws Exception {
		List<ProcessMetaDataDto> lstMetaDataDto = null;
		try {
			String sql = "SELECT * FROM ProcessMetaData ORDER BY ProcessName";
			Map<String, String> namedParameters = new HashMap<String, String>();
			lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

			List<Map<String, Object>> rows = this.getJdbcTemplate()
					.queryForList(sql, namedParameters);
			for (Map<String, Object> row : rows) {
				ProcessMetaDataDto processMetaDataDto = new ProcessMetaDataDto();
				processMetaDataDto.setpID((Integer) (row.get("ID")));
				processMetaDataDto.setpName((String) (row.get("ProcessName")));

				lstMetaDataDto.add(processMetaDataDto);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return lstMetaDataDto;
	}

	public void updateProcess(ProcessDto processDto, String pType)
			throws Exception {
		try {
			String updateSql = null;
			if (pType.equals("NAV")) {
				updateSql = "UPDATE NAV SET ReqID = :reqID, "
						+ "AppNo = :applicationNo, " + "AreaCode = :areaCode, "
						+ "BankCode = :bankCode, " + "Premium = :premium, "
						+ "ProductType = :producttype, "
						+ "PayType = :payType, " + "Status = :status "
						+ "WHERE ReqID = :reqID";
			} else if (pType.equals("TermClaim")) {
				updateSql = "UPDATE Termclaim SET PolicyNumber = :policyNo, "
						+ "Name = :name, " + "Address = :address, "
						+ "age = :age, " + "Premium = :premium, "
						+ "ProductType = :producttype, "
						+ "PayType = :payType, " + "Status = :status "
						+ "WHERE PolicyNumber = :policyNo";
			}
			SqlParameterSource namParameterSource = new BeanPropertySqlParameterSource(
					processDto);
			this.getJdbcTemplate().update(updateSql, namParameterSource);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public List<Map<String, Object>> getProcessData(String processName,
			String status) throws Exception {
		List<Map<String, Object>> processData = null;
		String sql = "";
		try {
			if (status.equals("All")) {
				sql = "SELECT * FROM " + "\"" + processName + "\""
						+ " ORDER BY ReqID ASC";
			} else {
				sql = "SELECT * FROM " + "\"" + processName + "\""
						+ " WHERE Status='" + status + "'";
			}
			Map<String, String> namedParameters = new HashMap<String, String>();
			processData = this.getJdbcTemplate().queryForList(sql,
					namedParameters);

		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return processData;
	}

	public List<String> getColumnNames(String processName) throws Exception {
		List<String> processCol = null;
		try {
			this.setDataSource();
			String sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME ='"
					+ "\"" + processName + "\"" + "'";
			processCol = this.jdbcTemplateObject.queryForList(sql,
					String.class);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return processCol;
	}

	@Transactional(isolation = Isolation.SERIALIZABLE)
	public void updateProcess(MultiValueMap<String, String> requestParams)
			throws Exception {
		try {
			this.setDataSource();
			String str = this.buildUpdateSqlQuery(requestParams);
			this.jdbcTemplateObject.execute(str);
		} catch (Exception e) {

			throw e;
		}

	}

	public String buildUpdateSqlQuery(
			MultiValueMap<String, String> requestParams) throws Exception {

		String pName = requestParams.get("pType").toString();
		String processName = "\"" + pName + "\"";

		String sql = "UPDATE " + processName + " SET Status='Unprocessed', ";// ++"
																				// WHERE
																				// ReqID="+requestParams.get("ReqID");
		String sql1 = "";
		String str1 = "";
		try {
			StringBuilder stringBuilder = new StringBuilder(sql1);
			requestParams.remove("pType");
			String reqId = requestParams.get("ReqID").toString();
			requestParams.remove("ReqID");
			requestParams.remove("Status");
			requestParams.remove("nsec");
			int i = 1;
			for (String key : requestParams.keySet()) {
				stringBuilder.append("\"" + key + "\"");
				stringBuilder.append("=").append(requestParams.get(key));

				if (requestParams.size() != i) {
					stringBuilder.append(",");
				}
				i++;
				// System.out.println("keys = "+requestParams.get(key));
			}

			stringBuilder.append(" WHERE ReqID=" + reqId);
			String str = stringBuilder.toString();

			System.out.println("str:" + str);
			str = str.replaceAll("\\[", "'").replaceAll("\\]", "'");
			str1 = sql.replaceAll("\\[", "").replaceAll("\\]", "");
			str1 = str1.concat(str);
			// System.out.println("string sql = "+str1);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return str1;
	}

	public List<Map<String, Object>> getProcessColumns(String processName)
			throws Exception {
		String sql = null;
		// Map<String,Object> processCols = null;
		List<Map<String, Object>> rows = null;
		Map<String, String> namedParameters = new HashMap<String, String>();
		try {
			sql = "select f.FieldName,f.DataType,f.length from FieldMetaData f "
					+ "inner join ProcessMetaData p ON p.ID = f.ID "
					+ "where p.ProcessName = " + "'" + processName + "'";
			rows = this.getJdbcTemplate().queryForList(sql, namedParameters);
			// processCols=rows.get(0);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return rows;
	}

	public String validateProcessName(String processName) throws Exception {
		try {
			String sql = "SELECT TOP 1 ProcessName FROM ProcessMetaData WHERE ProcessName = '"
					+ "\"" + processName + "\"" + "'";
			String name = this.getQueryResult(sql);
			return name;
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}
}