package com.company.myapp.service;

import java.util.List;
import java.util.Map;

import com.company.myapp.dto.ProcessMetaDataDto;
import com.company.myapp.dto.UserDto;

public interface LoginService {

	public UserDto validateUser(String userID, String password)
			throws Exception;

	public UserDto getUserInfo(String userName) throws Exception;

	public void changePassword(String oldPassword, String conPassword,
			String newPassword, Integer userID) throws Exception;

	public List<ProcessMetaDataDto> listProcessMetatData() throws Exception;

	public Map<String, Integer> getProcessCount(String pType) throws Exception;

	public Double getProCount(String pType) throws Exception;

	public Double getErrCount(String pType) throws Exception;

	public Double getUnProCount(String pType) throws Exception;

	public void saveUser(String fName, String lName, String uName,
			String address, String gender, String pwd, String role,
			String[] processName, String loggedInUser) throws Exception;

	public List<ProcessMetaDataDto> listProcessNameByUser(Integer userID)
			throws Exception;

	public List<ProcessMetaDataDto> listProcessMetatData1(String type)
			throws Exception;

	public List<ProcessMetaDataDto> listProcessNameByUser1(String type,
			Integer userID) throws Exception;

	public List<Map<String, Object>> getProcessNames(UserDto userDto)
			throws Exception;

	public Map<String, Map<String, Integer>> getStatusCount() throws Exception;

	public List<String> listUserNames() throws Exception;

	public UserDto listUserData(String uName) throws Exception;

	public List<String> listUserProcessData(int userId) throws Exception;

	public void updateUserData(String fName, String lName, String uName,
			String address, String gender, String pwd, String role,
			String[] processName, int userID, String loggedInUser)
			throws Exception;
}
