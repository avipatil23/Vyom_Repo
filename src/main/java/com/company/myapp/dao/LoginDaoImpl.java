package com.company.myapp.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.jdbc.support.rowset.ResultSetWrappingSqlRowSet;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import com.company.myapp.controller.LoginController;
import com.company.myapp.dto.ProcessMetaDataDto;
import com.company.myapp.dto.UserDto;
import com.company.myapp.rowmapper.UserDetailsRowMapper;

@Repository("loginDao")
public class LoginDaoImpl implements LoginDao {

	private static Logger logger = Logger.getLogger(LoginController.class);

	@Autowired
	@Qualifier("dataSource")
	private DataSource dataSource;
	private NamedParameterJdbcTemplate jdbcTemplate = null;

	private NamedParameterJdbcTemplate getJdbcTemplate() {
		if (jdbcTemplate == null) {
			jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
		}
		return jdbcTemplate;
	}

	private JdbcTemplate jdbcTemplateObject;

	public void setDataSource() {
		this.jdbcTemplateObject = new JdbcTemplate(dataSource);
	}
	// private JdbcTemplate jdbcTemplate;

	public Integer validateUser(String userID, String password) throws Exception {
		Integer userId = null;
		
		logger.info("Validating User");
		
		try {
			String sql = "SELECT * FROM UserData WHERE  UserName=? AND Password=?";
			setDataSource();
			SqlRowSet results = jdbcTemplateObject.queryForRowSet(sql, new Object[] { userID, password });
			ResultSet rs = ((ResultSetWrappingSqlRowSet) results).getResultSet();
			UserDto userDto = null;
			try {
				while (rs.next()) {
					userDto = new UserDto();
					userId = Integer.parseInt(rs.getString("UserID"));
					userDto.setUserID(userId);
				}
			} catch (Exception e) {
				logger.info(e);
		
			}
		} catch (Exception e) {
			logger.info(e);
		}
		return userId;
	}

	public Integer getUserID(String userName) throws Exception {
		Integer userId = null;
		
		logger.info("Validating User");
		
		try {
			String sql = "SELECT * FROM UserData WHERE  UserName=?";
			setDataSource();
			SqlRowSet results = jdbcTemplateObject.queryForRowSet(sql, new Object[] { userName});
			ResultSet rs = ((ResultSetWrappingSqlRowSet) results).getResultSet();
			UserDto userDto = null;
			try {
				while (rs.next()) {
					userDto = new UserDto();
					userId = Integer.parseInt(rs.getString("UserID"));
					userDto.setUserID(userId);
				}
			} catch (Exception e) {
				logger.info(e);
		
			}
		} catch (Exception e) {
			logger.info(e);
		}
		return userId;
	}
	
	public UserDto getUserDetails(Integer userID) throws Exception {
		UserDto userDto = null;
		try {
			String sql = "SELECT * FROM UserData WHERE  UserID=?";
			/*
			 * String sql = "SELECT u.*, up.ProcessName FROM UserData u " +
			 * "INNER JOIN UserProcessData up ON up.UserID = u.UserID " +
			 * "WHERE  u.UserID="+userID;
			 */

			logger.info("Getting user information for: "+userID);
			JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
			userDto = jdbcTemplate.queryForObject(sql, new Object[] { userID }, new UserDetailsRowMapper());
		} catch (Exception e) {
			logger.info(e);
		}
		return userDto;
	}

	public List<ProcessMetaDataDto> listProcessMetatData() throws Exception {
		List<ProcessMetaDataDto> lstMetaDataDto = null;
		try {
			String sql = "SELECT * FROM ProcessMetaData ORDER BY ProcessName";
			Map<String, String> namedParameters = new HashMap<String, String>();

			lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

			List<Map<String, Object>> rows = getJdbcTemplate().queryForList(sql, namedParameters);
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

	public List<ProcessMetaDataDto> listProcessNameByUser(Integer userID) throws Exception {
		List<ProcessMetaDataDto> lstMetaDataDto = null;
		try {
			String sql = "SELECT up.ProcessName FROM UserProcessData up "+ "INNER JOIN UserData u ON u.UserID=up.UserID " + "WHERE up.UserID = " + userID+" ORDER BY up.ProcessName ";
			Map<String, String> namedParameters = new HashMap<String, String>();

			lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

			List<Map<String, Object>> rows = getJdbcTemplate().queryForList(sql, namedParameters);
			for (Map<String, Object> row : rows) {
				ProcessMetaDataDto processMetaDataDto = new ProcessMetaDataDto();
				// processMetaDataDto.setpID((Integer)(row.get("ID")));
				processMetaDataDto.setpName((String) (row.get("ProcessName")));

				lstMetaDataDto.add(processMetaDataDto);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return lstMetaDataDto;
	}

	public Map<String, Integer> getProcessCount(String processName) throws Exception {
		String str = null;
		Integer str1 = null;
		Map<String, Integer> map = new HashMap<String, Integer>();
		try {
			String sql = "SELECT Status, COUNT(Status) as 'Count' FROM " + "\"" + processName + "\""
					+ " GROUP BY Status";
			setDataSource();
			SqlRowSet results = jdbcTemplateObject.queryForRowSet(sql);
			ResultSet rs = ((ResultSetWrappingSqlRowSet) results).getResultSet();

			while (rs.next()) {
				str = rs.getString("Status");
				str1 = Integer.parseInt(rs.getString("Count"));

				map.put(str, str1);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return map;
	}

	public Double getProCount(String processName) throws Exception {
		Double processCount = 0.0;
		try {
			String sql = "SELECT COUNT(Status) as 'Count' FROM " + "\"" + processName + "\""
					+ " WHERE Status='Processed'";
			setDataSource();
			SqlRowSet results = jdbcTemplateObject.queryForRowSet(sql);
			ResultSet rs = ((ResultSetWrappingSqlRowSet) results).getResultSet();

			while (rs.next()) {
				processCount = Double.parseDouble(rs.getString("Count"));

			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return processCount;
	}

	public Double getErrCount(String processName) throws Exception {
		Double errorCount = 0.0;
		try {
			String sql = "SELECT COUNT(Status) as 'Count' FROM " + "\"" + processName + "\"" + " WHERE Status='Error'";
			setDataSource();
			SqlRowSet results = jdbcTemplateObject.queryForRowSet(sql);
			ResultSet rs = ((ResultSetWrappingSqlRowSet) results).getResultSet();

			while (rs.next()) {
				errorCount = Double.parseDouble(rs.getString("Count"));

			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return errorCount;
	}

	public Double getUnProCount(String processName) throws Exception {
		Double unProCount = 0.0;
		try {
			String sql = "SELECT COUNT(Status) as 'Count' FROM " + "\"" + processName + "\""
					+ " WHERE Status='Unprocessed'";
			setDataSource();
			SqlRowSet results = jdbcTemplateObject.queryForRowSet(sql);
			ResultSet rs = ((ResultSetWrappingSqlRowSet) results).getResultSet();

			while (rs.next()) {
				unProCount = Double.parseDouble(rs.getString("Count"));

			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return unProCount;
	}

	public Integer saveUser(final UserDto userDto) throws Exception {
		final Integer userID;
		try {
			final PreparedStatementCreator psc = new PreparedStatementCreator() {
				public PreparedStatement createPreparedStatement(final Connection connection) throws SQLException {
					final PreparedStatement ps = connection
							.prepareStatement("INSERT INTO UserData(FirstName,LastName,UserName,Address,Gender,"
									+ "Password,Role) VALUES(?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
					ps.setString(1, userDto.getFirstName());
					ps.setString(2, userDto.getLastName());
					ps.setString(3, userDto.getUserName());
					ps.setString(4, userDto.getAddress());
					ps.setString(5, userDto.getGender());
					ps.setString(6, userDto.getPassword());
					ps.setString(7, userDto.getRole());

					return ps;
				}
			};
			// The newly generated key will be saved in this object
			final KeyHolder holder = new GeneratedKeyHolder();
			setDataSource();
			jdbcTemplateObject.update(psc, holder);

			userID = holder.getKey().intValue();
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return userID;
	}

	public void createUserProcessTable() throws Exception {
		String sql = "CREATE TABLE UserProcessData(ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,"
				+ "ProcessName varchar(50),UserID int FOREIGN KEY REFERENCES UserData(UserID))";
		String Name = null;
		try {
			Name = getQueryResult("select name from SYS.tables where tables.name='UserProcessData'");
			System.out.println("Process Table Name:" + Name);
			if (Name != null) {
				System.out.println("Table is already exist");
			} else {
				jdbcTemplateObject.execute(sql);
				System.out.println("Table created successfuly");
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public String getQueryResult(String sql) throws Exception {
		try {
			setDataSource();
			return jdbcTemplateObject.query(sql, new ResultSetExtractor<String>() {
				public String extractData(ResultSet rs) throws SQLException, DataAccessException {
					return rs.next() ? rs.getString(1) : null;
				}
			});
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public void insertIntoUserProcess(Integer userID, String[] processName) throws Exception {
		try {
			for (int i = 0; i <= processName.length - 1; i++) {
				String sql = "INSERT INTO UserProcessData(UserID,ProcessName) VALUES(" + userID + ",'" + processName[i]
						+ "')";
				System.out.println("Insert Query:" + sql);
				jdbcTemplateObject.execute(sql);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public UserDto getProcessList(Integer userId) throws Exception {
	
		return null;
	}

	public List<ProcessMetaDataDto> listProcessNameByUser1(String type) throws Exception {
		List<ProcessMetaDataDto> lstMetaDataDto = null;
		try {
			String sql = "SELECT * FROM ProcessMetaData " + "WHERE ProcessName LIKE '" + type
					+ "%' ORDER BY ProcessName";
			Map<String, String> namedParameters = new HashMap<String, String>();

			lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

			List<Map<String, Object>> rows = getJdbcTemplate().queryForList(sql, namedParameters);
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

	public List<ProcessMetaDataDto> listProcessNameByUser1(String type, Integer userID) throws Exception {
		List<ProcessMetaDataDto> lstMetaDataDto = null;
		try {
			String sql = "SELECT up.ProcessName FROM UserProcessData up "
					+ "INNER JOIN UserData u ON u.UserID=up.UserID " + "WHERE up.UserID = " + userID
					+ " AND ProcessName LIKE '" + type + "%'";
			Map<String, String> namedParameters = new HashMap<String, String>();

			lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

			List<Map<String, Object>> rows = getJdbcTemplate().queryForList(sql, namedParameters);
			for (Map<String, Object> row : rows) {
				ProcessMetaDataDto processMetaDataDto = new ProcessMetaDataDto();
				// processMetaDataDto.setpID((Integer)(row.get("ID")));
				processMetaDataDto.setpName((String) (row.get("ProcessName")));

				lstMetaDataDto.add(processMetaDataDto);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return lstMetaDataDto;
	}

	public Map<String, Map<String, Integer>> getStatusCount() {

		Map<String, Integer> mapofStatus = null;
		Map<String, Map<String, Integer>> mapofProcess = new HashMap<String, Map<String, Integer>>();

		String processSql = "select ProcessName from ProcessMetaData";
		List<String> listOfProcessNames = jdbcTemplateObject.queryForList(processSql, String.class);

		for (int i = 0; i < listOfProcessNames.size(); i++) {
			mapofStatus = new HashMap<String, Integer>();
			try {
				mapofStatus.put("Error", (int) Math.round(getErrCount(listOfProcessNames.get(i).toString())));
				mapofStatus.put("Processed", (int) Math.round(getProCount(listOfProcessNames.get(i).toString())));
				mapofStatus.put("unProcessed", (int) Math.round(getUnProCount(listOfProcessNames.get(i).toString())));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			mapofProcess.put(listOfProcessNames.get(i).toString(), mapofStatus);
		}
	
		return mapofProcess;
	}

	@SuppressWarnings("null")
	public List<Map<String, Object>> getProcessNames(UserDto userDto) {
		List<Map<String, Object>> listOfProcess;
		if (userDto.getRole().equals("Admin")) {
			String sql = "select u.firstName,u.lastName,up.ProcessName,up.UserID from UserProcessData up inner join UserData u on u.UserID = up.UserID  order by u.firstName asc";
			listOfProcess = jdbcTemplateObject.queryForList(sql);
			
		} else {
			
			String sql = "select ProcessName from UserProcessData where UserID =" + userDto.getUserID();
			listOfProcess = jdbcTemplateObject.queryForList(sql);
			
		}

		return listOfProcess;
	}

	public List<String> getUserNames() throws Exception {
		String userNameSql = "Select UserName from UserData";

		return jdbcTemplateObject.queryForList(userNameSql, String.class);
	}

	public Map<String, Object> getUserData(String uName) throws Exception {
		String userdataSql = "Select * from UserData where UserName=" + "'" + uName + "'";
				return jdbcTemplateObject.queryForMap(userdataSql);
	}

	public List<String> getProcessByUserId(int userId) throws Exception {
		String processSql = "select ProcessName from UserProcessData where UserID="+userId+" "
				+ "order by ProcessName";
	
		List<String> processMapList=jdbcTemplateObject.queryForList(processSql,String.class);
		return processMapList;
	}

	public Integer updateUser(UserDto userDto, List<String> processList) throws Exception {
		final Integer userID;
		List<String> colNames1 = new ArrayList<String>();
		Map<String, Object> colNames = new HashMap<String, Object>();
		UserDto userDBDto = getUserDetails(userDto.getUserID());

		try {

			if (!(userDto.getFirstName().equals(userDBDto.getFirstName())))
				colNames.put("FirstName", userDto.getFirstName());
			if (!(userDto.getLastName().equals(userDBDto.getLastName())))
				colNames.put("LastName", userDto.getLastName());
			if (!(userDto.getPassword().equals(userDBDto.getPassword())))
				colNames.put("Password", userDto.getPassword());
			if (!(userDto.getRole().equals(userDBDto.getRole())))
				colNames.put("Role", userDto.getRole());
			if (!(userDto.getAddress().equals(userDBDto.getAddress())))
				colNames.put("Address", userDto.getAddress());
			if (!(userDto.getGender().equals(userDBDto.getGender())))
				colNames.put("Gender", userDto.getGender());
			if (!(userDto.getUserName().equals(userDBDto.getUserName())))
				colNames.put("UserName", userDto.getUserName());

			if (!colNames.isEmpty()) {
				String updateQuery = buildUpdateQuery(colNames, userDto);

		/*		final PreparedStatementCreator psc = new PreparedStatementCreator() {
					public PreparedStatement createPreparedStatement(final Connection connection) throws SQLException {
						final PreparedStatement ps = connection.prepareStatement(updateQuery);
						return ps;
					}
				};*/
				
				setDataSource();
				jdbcTemplateObject.update(updateQuery);

			}

			List<String> dbprocessList = getProcessByUserId(userDto.getUserID());

			for (int i = 0; i < dbprocessList.size(); i++) {

				if (!processList.contains(dbprocessList.get(i))) {
					String deleteProcessSql = "DELETE FROM UserProcessData WHERE ProcessName=" + "'"
							+ dbprocessList.get(i) + "'" + "and UserID=" + userDto.getUserID();
					System.out.println("deleteProcessSql=" + deleteProcessSql);
					jdbcTemplateObject.execute(deleteProcessSql);
					
				} else {

					processList.remove(dbprocessList.get(i));
				}
				
			}
			String insertNewProcessesSql = null;
			StringBuilder sb = null;

			if (!processList.isEmpty()) {

				System.out.println("Add processes List:" + processList);				
				
				int i = 0;
				for (String process : processList) {

					if (i == 0) {
						insertNewProcessesSql = "INSERT INTO UserProcessData VALUES (" +"'"+process+"'" + ","
								+ userDto.getUserID() + ")";
						sb = new StringBuilder(insertNewProcessesSql);
						i = 1;
										
					} else {

						sb.append("," + "(" + "'"+process+"'" + "," + userDto.getUserID() + ")");
						System.out.println("insertNewProcessesSql:" + sb.toString());
					}
						
				}
				sb.append(";");
				System.out.println("insertNewProcessesSql:" + sb.toString());
				setDataSource();
				
				jdbcTemplateObject.execute(sb.toString());
			}

			

		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
		return null;
	}

	public String buildUpdateQuery(Map<String, Object> colNames, UserDto userDto) {

		String updateQuery = "UPDATE UserData SET ";
		StringBuilder sb = new StringBuilder(updateQuery);
		int i=colNames.size();

		for (Entry<String, Object> colName : colNames.entrySet()) {

			sb.append(" [" + colName.getKey() + "]=" + "'"+colNames.get(colName.getKey())+"'");
			
	

			if (i>1)
				sb.append(",");
			
			i--;
		}

		sb.append(" WHERE UserID = " + userDto.getUserID());

		System.out.println("Update Query:" + sb.toString());

		return sb.toString();

	}
}