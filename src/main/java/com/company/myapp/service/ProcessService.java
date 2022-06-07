package com.company.myapp.service;

import java.util.List;
import java.util.Map;

import org.springframework.util.MultiValueMap;

import com.company.myapp.dto.ProcessDto;
import com.company.myapp.dto.ProcessMetaDataDto;

public interface ProcessService {

	public String createProcessMetaData(String userNme, String processName,
			String[] fieldName, String[] dataType, String[] length)
			throws Exception;

	public Map<String, Object> viewProcessByID(Integer pID, String name)
			throws Exception;

	public List<ProcessDto> listProcessData(String id, String status)
			throws Exception;

	public List<ProcessMetaDataDto> listProcessMetatData() throws Exception;

	public void updateProcess(String id, String appNo, String aCode,
			String bCode, String premium, String payType, String productType,
			String status, String pType) throws Exception;

	public List<Map<String, Object>> getProcessData(String pType, String status)
			throws Exception;

	public List<String> getColumnProcessNames(String processName)
			throws Exception;

	void updateProcess(String userName,
			MultiValueMap<String, String> requestParams) throws Exception;

	List<Map<String, Object>> getProcessColumns(String pType) throws Exception;

}
