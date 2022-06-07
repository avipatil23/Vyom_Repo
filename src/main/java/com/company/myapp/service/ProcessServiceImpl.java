package com.company.myapp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import com.company.myapp.common.CommonUtility;
import com.company.myapp.dao.ProcessDao;
import com.company.myapp.dao.TransactionDataDao;
import com.company.myapp.dto.ProcessDto;
import com.company.myapp.dto.ProcessMetaDataDto;
import com.company.myapp.entity.TransactionData;

@Service("processService")
public class ProcessServiceImpl implements ProcessService {

	@Autowired
	@Qualifier("processDao")
	private ProcessDao processDao;

	@Autowired
	@Qualifier("transactionDataDao")
	private TransactionDataDao transactionDataDao;

	@Autowired
	CommonUtility commonUtility;

	public enum ProcessOperation {
		CREATEPROCESS, UPDATEPROCESS
	}

	public enum Status {
		COMPLETED, FAILED
	}

	@Transactional
	public String createProcessMetaData(String userName, String ProcessName,
			String[] fieldNames, String[] Datatypes, String[] length)
			throws Exception {
		try {
			String validate = this.processDao.validateProcessName(ProcessName);
			System.out.println("validate = " + validate);
			String result = null;
			if ((validate != null) && !validate.isEmpty()
					&& (validate.length() > 0)) {
				result = "Process Name already exist..";
			} else {

				this.processDao.createMetaDataTables();
				this.processDao.insertFieldMetaData(ProcessName, fieldNames,
						Datatypes, length);
				this.processDao.createProcessTable(ProcessName, fieldNames,
						Datatypes, length);
				this.processDao.createAuditProcessTable(ProcessName, fieldNames,
						Datatypes, length);
				this.processDao.createSqlTrigger(ProcessName, fieldNames,
						Datatypes, length);

				// Save Transaction Data
				TransactionData transactionData = new TransactionData();
				transactionData.setTransactionNumber(
						this.commonUtility.generateTransactionNumber());
				transactionData
						.setTransactionType(ProcessOperation.CREATEPROCESS);
				transactionData.setChangedBy(userName);
				transactionData.setStatus(Status.COMPLETED);
				this.transactionDataDao.savetransactionData(transactionData);

				result = "";
			}
			return result;
		} catch (Exception e) {
			// e.printStackTrace();

			// Save Transaction Data
			TransactionData transactionData = new TransactionData();
			transactionData.setTransactionNumber(
					this.commonUtility.generateTransactionNumber());
			transactionData.setTransactionType(ProcessOperation.CREATEPROCESS);
			transactionData.setChangedBy(userName);
			transactionData.setStatus(Status.FAILED);
			this.transactionDataDao.savetransactionData(transactionData);

			throw e;
		}
	}

	public Map<String, Object> viewProcessByID(Integer pID, String name)
			throws Exception {
		try {
			return this.processDao.viewProcessByID(pID, name);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public List<ProcessDto> listProcessData(String pType, String status)
			throws Exception {
		try {
			return this.processDao.listProcessData(pType, status);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public List<ProcessMetaDataDto> listProcessMetatData() throws Exception {
		try {
			return this.processDao.listProcessMetatData();
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	@Transactional
	public void updateProcess(String id, String appNo, String aCode,
			String bCode, String premium, String payType, String productType,
			String status, String pType) throws Exception {
		try {
			ProcessDto processDto = new ProcessDto();
			if (pType.equals("NAV")) {
				processDto.setReqID(id);
				processDto.setApplicationNo(appNo);
				processDto.setAreaCode(aCode);
				processDto.setBankCode(bCode);
			} else if (pType.equals("Termclaim")) {
				processDto.setPolicyNo(id);
				processDto.setAddress(aCode);
				processDto.setName(appNo);
				processDto.setAge(bCode);
			}
			processDto.setPayType(payType);
			processDto.setPremium(premium);
			processDto.setProducttype(productType);
			processDto.setStatus(status);
			this.processDao.updateProcess(processDto, pType);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public List<Map<String, Object>> getProcessData(String pType, String status)
			throws Exception {
		try {
			return this.processDao.getProcessData(pType, status);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	public List<String> getColumnProcessNames(String processName)
			throws Exception {
		try {
			return this.processDao.getColumnNames(processName);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}

	@Transactional(isolation = Isolation.SERIALIZABLE)
	public void updateProcess(String userName,
			MultiValueMap<String, String> requestParams) throws Exception {
		try {
			this.processDao.updateProcess(requestParams);

			// Save Transaction Data
			TransactionData transactionData = new TransactionData();
			transactionData.setTransactionNumber(
					this.commonUtility.generateTransactionNumber());
			transactionData.setTransactionType(ProcessOperation.UPDATEPROCESS);
			transactionData.setChangedBy(userName);
			transactionData.setStatus(Status.COMPLETED);
			this.transactionDataDao.savetransactionData(transactionData);
		} catch (Exception e) {
			// e.printStackTrace();

			// Save Transaction Data
			TransactionData transactionData = new TransactionData();
			transactionData.setTransactionNumber(
					this.commonUtility.generateTransactionNumber());
			transactionData.setTransactionType(ProcessOperation.CREATEPROCESS);
			transactionData.setChangedBy(userName);
			transactionData.setStatus(Status.FAILED);
			this.transactionDataDao.savetransactionData(transactionData);

			throw e;
		}
	}

	public List<Map<String, Object>> getProcessColumns(String pType)
			throws Exception {
		try {
			return this.processDao.getProcessColumns(pType);
		} catch (Exception e) {
			// e.printStackTrace();
			throw e;
		}
	}
}