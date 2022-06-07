package com.company.myapp.dao;

import java.util.List;
import java.util.Map;

import org.springframework.util.MultiValueMap;

import com.company.myapp.dto.ProcessDto;
import com.company.myapp.dto.ProcessMetaDataDto;

public interface ProcessDao {

	public void createMetaDataTables() throws Exception;

	public void insertFieldMetaData(String processName, String[] fieldNames,
			String[] datatypes, String[] length) throws Exception;

	public void createProcessTable(String processName, String[] fieldNames,
			String[] datatypes, String[] length) throws Exception;

	public Map<String, Object> viewProcessByID(Integer pID, String name)
			throws Exception;

	public List<ProcessDto> listProcessData(String id, String status)
			throws Exception;

	public List<ProcessMetaDataDto> listProcessMetatData() throws Exception;

	public void updateProcess(ProcessDto processDto, String pType)
			throws Exception;

	public List<Map<String, Object>> getProcessData(String pType, String status)
			throws Exception;

	public List<String> getColumnNames(String processName) throws Exception;

	public void updateProcess(MultiValueMap<String, String> requestParams)
			throws Exception;

	public List<Map<String, Object>> getProcessColumns(String pType)
			throws Exception;

	public String validateProcessName(String processName) throws Exception;

	public void createAuditProcessTable(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception;

	String createSqlTrigger(String ProcessName, String[] fieldNames,
			String[] Datatypes, String[] length) throws Exception;

}
