package com.company.myapp.dao;

import java.util.List;
import java.util.Map;

import com.company.myapp.dto.ProcessMetaDataDto;
import com.company.myapp.dto.UserDto;

public interface LoginDao {

	public Integer validateUser(String userID, String password)throws Exception;
	public Integer getUserID(String userName)throws Exception;
	public UserDto getUserDetails(Integer userId)throws Exception;
	public List<ProcessMetaDataDto> listProcessMetatData()throws Exception;
	public Map<String, Integer> getProcessCount(String pType)throws Exception;
	public Double getProCount(String pType)throws Exception;
	public Double getErrCount(String pType)throws Exception;
	public Double getUnProCount(String pType)throws Exception;
	public Integer saveUser(UserDto userDto) throws Exception;
	public void createUserProcessTable() throws Exception;
	public void insertIntoUserProcess(Integer userID, String[] processName) throws Exception;
	public List<ProcessMetaDataDto> listProcessNameByUser(Integer userID)throws Exception;
	public UserDto getProcessList(Integer userId)throws Exception;
	public List<ProcessMetaDataDto> listProcessNameByUser1(String type)throws Exception;
	public List<ProcessMetaDataDto> listProcessNameByUser1(String type, Integer userID)throws Exception;
	public List<Map<String, Object>> getProcessNames(UserDto userDto)throws Exception;
	public Map<String, Map<String, Integer>> getStatusCount()throws Exception;
	public List<String> getUserNames()throws Exception;
	public Map<String,Object> getUserData(String uName)throws Exception;
	public List<String> getProcessByUserId(int userId)throws Exception;
	public Integer updateUser(UserDto userDto,List<String> processList) throws Exception;
	
}
