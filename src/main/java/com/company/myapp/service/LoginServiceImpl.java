package com.company.myapp.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.company.myapp.common.CommonUtility;
import com.company.myapp.dao.LoginDao;
import com.company.myapp.dao.TransactionDataDao;
import com.company.myapp.dto.ProcessMetaDataDto;
import com.company.myapp.dto.UserDto;
import com.company.myapp.entity.TransactionData;
import com.company.myapp.service.ProcessServiceImpl.ProcessOperation;
import com.company.myapp.service.ProcessServiceImpl.Status;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	@Autowired
	@Qualifier("loginDao")
	LoginDao loginDao;

	@Autowired
	@Qualifier("transactionDataDao")
	private TransactionDataDao transactionDataDao;

	@Autowired
	CommonUtility commonUtility;

	public enum UserOperation {
		CREATEUSER, UPDATEUSER, DELETEUSER
	}

	@Transactional
	public UserDto validateUser(String userID, String password)
			throws Exception {
		try {
			UserDto userDto = null;
			Integer userId = this.loginDao.validateUser(userID, password);

			if (userId != null) {
				userDto = this.loginDao.getUserDetails(userId);

			}
			return userDto;
		} catch (Exception e) {

			throw e;
		}
	}

	@Transactional
	public UserDto getUserInfo(String userName) throws Exception {
		try {
			UserDto userDto = null;
			Integer userId = this.loginDao.getUserID(userName);

			if (userId != null) {
				userDto = this.loginDao.getUserDetails(userId);

			}
			return userDto;
		} catch (Exception e) {

			throw e;
		}
	}

	public void changePassword(String oldPassword, String conPassword,
			String newPassword, Integer userID) {

	}

	public List<ProcessMetaDataDto> listProcessMetatData() throws Exception {
		try {

			return this.loginDao.listProcessMetatData();
		} catch (Exception e) {
			throw e;
		}
	}

	public Map<String, Integer> getProcessCount(String pType) throws Exception {
		try {
			return this.loginDao.getProcessCount(pType);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public Double getProCount(String pType) throws Exception {
		try {
			return this.loginDao.getProCount(pType);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public Double getErrCount(String pType) throws Exception {
		try {
			return this.loginDao.getErrCount(pType);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public Double getUnProCount(String pType) throws Exception {
		try {
			return this.loginDao.getUnProCount(pType);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	@Transactional
	public void saveUser(String fName, String lName, String uName,
			String address, String gender, String pwd, String role,
			String[] processName, String loggedInUser) throws Exception {
		try {
			UserDto userDto = new UserDto();
			userDto.setFirstName(fName);
			userDto.setLastName(lName);
			userDto.setUserName(uName);
			userDto.setAddress(address);
			userDto.setGender(gender);
			userDto.setPassword(pwd);
			userDto.setRole(role);

			Integer userID = this.loginDao.saveUser(userDto);

			// Save Transaction Data
			TransactionData transactionData = new TransactionData();
			transactionData.setTransactionNumber(
					this.commonUtility.generateTransactionNumber());
			transactionData.setTransactionType(ProcessOperation.CREATEPROCESS);
			transactionData.setChangedBy(loggedInUser);
			transactionData.setStatus(Status.COMPLETED);
			this.transactionDataDao.savetransactionData(transactionData);

			System.out.println("userID = " + userID);
			this.loginDao.createUserProcessTable();
			this.loginDao.insertIntoUserProcess(userID, processName);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public List<ProcessMetaDataDto> listProcessNameByUser(Integer userID)
			throws Exception {
		try {
			List<ProcessMetaDataDto> lstMetaDataDto = this.loginDao
					.listProcessNameByUser(userID);
			return lstMetaDataDto;
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public List<ProcessMetaDataDto> listProcessMetatData1(String type)
			throws Exception {
		List<ProcessMetaDataDto> lstMetaDataDto = this.loginDao
				.listProcessNameByUser1(type);
		return lstMetaDataDto;
	}

	public List<ProcessMetaDataDto> listProcessNameByUser1(String type,
			Integer userID) throws Exception {
		List<ProcessMetaDataDto> lstMetaDataDto = this.loginDao
				.listProcessNameByUser1(type, userID);
		return lstMetaDataDto;
	}

	public List<Map<String, Object>> getProcessNames(UserDto userDto)
			throws Exception {
		return this.loginDao.getProcessNames(userDto);
	}

	public Map<String, Map<String, Integer>> getStatusCount() throws Exception {
		return this.loginDao.getStatusCount();
	}

	public List<String> listUserNames() throws Exception {
		// TODO Auto-generated method stub
		return this.loginDao.getUserNames();
	}

	public UserDto listUserData(String uName) throws Exception {

		Map<String, Object> userDataMap = this.loginDao.getUserData(uName);

		UserDto userData = new UserDto();

		userData.setFirstName(userDataMap.get("FirstName").toString());
		userData.setLastName(userDataMap.get("LastName").toString());
		userData.setAddress(userDataMap.get("Address").toString());
		userData.setGender(userDataMap.get("Gender").toString());
		userData.setPassword(userDataMap.get("Password").toString());
		userData.setRole(userDataMap.get("Role").toString());
		userData.setUserName(userDataMap.get("UserName").toString());
		userData.setUserID(
				Integer.parseInt(userDataMap.get("UserID").toString()));

		return userData;
	}

	public List<String> listUserProcessData(int userId) throws Exception {

		return this.loginDao.getProcessByUserId(userId);
	}

	public void updateUserData(String fName, String lName, String uName,
			String address, String gender, String pwd, String role,
			String[] processName, int userID, String loggedInUser)
			throws Exception {
		try {

			List<String> processList = new ArrayList<String>();

			for (int i = 0; i < processName.length; i++) {

				processList.add(processName[i]);
			}

			UserDto userDto = new UserDto();
			userDto.setFirstName(fName);
			userDto.setLastName(lName);
			userDto.setUserName(uName);
			userDto.setAddress(address);
			userDto.setGender(gender);
			userDto.setPassword(pwd);
			userDto.setRole(role);
			userDto.setUserID(userID);
			// userDto.setProcessList(processList);
			System.out.println("userDto:" + userDto);

			this.loginDao.updateUser(userDto, processList);

			// Save Transaction Data
			TransactionData transactionData = new TransactionData();
			transactionData.setTransactionNumber(
					this.commonUtility.generateTransactionNumber());
			transactionData.setTransactionType(ProcessOperation.CREATEPROCESS);
			transactionData.setChangedBy(loggedInUser);
			transactionData.setStatus(Status.COMPLETED);
			this.transactionDataDao.savetransactionData(transactionData);

		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}

	}
}
