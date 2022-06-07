package com.company.myapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.company.myapp.dao.TransactionDataDao;
import com.company.myapp.entity.TransactionData;

@Service("tranasactionDataService")
public class TransactionDataServiceImpl implements TranasactionDataService {

	@Autowired
	@Qualifier("transactionDataDao")
	TransactionDataDao transactionDataDao;

	@Transactional
	public void saveTransactionData(TransactionData transactionData) {
		this.transactionDataDao.savetransactionData(transactionData);
	}

}
