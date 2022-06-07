package com.company.myapp.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.company.myapp.dao.LoginDao;
import com.company.myapp.dto.UserDto;
import com.company.myapp.service.LoginService;
import com.company.myapp.service.ProcessService;

@Controller
public class ProcessController {

	private static Logger logger = Logger.getLogger(ProcessController.class);

	@Autowired
	@Qualifier("processService")
	private ProcessService processService;

	@Autowired
	@Qualifier("loginDao")
	LoginDao loginDao;

	@Autowired
	@Qualifier("loginService")
	private LoginService loginService;

	@RequestMapping("listProcess.do")
	protected ModelAndView getProcess(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("pType") String pType,
			@RequestParam("status") String status,
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In List Process Data Controller");
		ModelAndView model = null;
		if (null != request.getSession(false)) {
			try {
				if (status.contains(",")) {
					String[] parts = status.split(",");
					status = parts[0];
				}
				pType = (pType == null ? "" : pType);
				status = (status == null ? "" : status);
				/* model = new ModelAndView("listProcess"); */
				model = new ModelAndView("listProcess_Demo");
				/*
				 * List<ProcessDto> lstProcessDto = new ArrayList<ProcessDto>();
				 * 
				 * lstProcessDto = processService.listProcessData(pType,status);
				 */
				List<Map<String, Object>> processData = this.processService
						.getProcessData(pType, status);

				model.addObject("processData", processData);
				// model.addObject("lstProcessDto", lstProcessDto);
				model.addObject("pType", pType);
				model.addObject("status", status);
				model.addObject("nsec", nsec);
			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);
				// e.printStackTrace();
				throw e;
			}
		} else {
			model = new ModelAndView("session");
		}
		return model;
	}

	@RequestMapping("createProcess.do")
	protected ModelAndView saveProcess(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("msg") String msg,
			@RequestParam("str") String str, @RequestParam("nsec") String nsec)
			throws Exception {
		logger.info("In Create Process Controller");
		ModelAndView model = new ModelAndView("createProcess");
		model.addObject("msg", msg);
		model.addObject("str", str);
		model.addObject("nsec", nsec);
		return model;
	}

	@RequestMapping("/validateProcessName.do")
	protected ModelAndView validateProcessName(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("ProcessName") String processName,
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In validate Process Name");
		ModelAndView mv = null;
		String str = null;
		UserDto userDto = (UserDto) request.getSession()
				.getAttribute("userDto" + nsec + "");
		String processes[] = new String[1];
		processes[0] = processName;

		if (null != request.getSession(false)) {

			System.out.println("ProcessName:" + processes[0]);
		}
		List<Map<String, Object>> processNames = this.loginService
				.getProcessNames(userDto);
		String msg = "Process Name already exist";
		ModelAndView modelAndView = new ModelAndView("createProcess");
		System.out.println(userDto.getRole());
		modelAndView.addObject(userDto);
		modelAndView.addObject("nsec", nsec);
		modelAndView.addObject(userDto);
		modelAndView.addObject("msg", msg);
		return modelAndView;

	}

	@RequestMapping("editProcess.do")
	protected ModelAndView editProcess(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ID") Integer pID,
			@RequestParam("pType") String pType,
			@RequestParam("status") String status,
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In Edit Process Controller");
		ModelAndView model = null;
		if (null != request.getSession(false)) {
			try {
				Map<String, Object> processRecord = this.processService
						.viewProcessByID(pID, pType);
				List<Map<String, Object>> processColsDetails = this.processService
						.getProcessColumns(pType);
				List<String> processColumnNames = this.processService
						.getColumnProcessNames(pType);

				/*
				 * for (Map<String, Object> map : processCols) { for
				 * (Map.Entry<StrprocessColsing, Object> entry : map.entrySet())
				 * { String key = entry.getKey(); Object value =
				 * entry.getValue();
				 * System.out.println("key = "+key+" value = "+value); } }
				 */

				model = new ModelAndView("editNavNew");
				System.out.println("processColsDetails" + processColsDetails);

				model.addObject("pType", pType);
				model.addObject("ID", pID);
				model.addObject("status", status);
				model.addObject("processRecord", processRecord);
				model.addObject("processColumnNames", processColumnNames);
				model.addObject("processColsDetails", processColsDetails);
				model.addObject("nsec", nsec);
			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);
				// e.printStackTrace();
				throw e;
			}
		} else {
			model = new ModelAndView("session");
		}
		return model;
	}

	@RequestMapping("saveProcess.do")
	protected String saveProcess1(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("ProcessName") String processName,
			@RequestParam("FieldName") String fieldName[],
			@RequestParam("dataType") String dataType[],
			@RequestParam("Length") String length[],
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In Save Process Controller");
		ModelAndView mv = null;
		String str = null;
		UserDto userDto = (UserDto) request.getSession()
				.getAttribute("userDto" + nsec + "");
		String processes[] = new String[1];
		processes[0] = processName;

		if (null != request.getSession(false)) {
			try {
				System.out.println("len:" + fieldName.length);
				for (int i = 0; i < fieldName.length; i++) {
					System.out.println(
							"fieldName : " + fieldName[i] + " dataType : "
									+ dataType[i] + " length : " + length[i]);
				}

				str = this.processService.createProcessMetaData(
						userDto.getUserName(), processName, fieldName, dataType,
						length);
				this.loginDao.insertIntoUserProcess(userDto.getUserID(),
						processes);
				mv = new ModelAndView();
				mv.addObject("nsec", nsec);
			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);
				// e.printStackTrace();
				throw e;
			}
		} else {
			new ModelAndView("session");
		}
		if (str.equals("")) {
			System.out.println("1 str = " + str);
			return "redirect:/createProcess.do?nsec=" + nsec
					+ "&str=&msg=New process has been created successfully...!";
		} else {
			System.out.println("2 str = " + str);
			return "redirect:/createProcess.do?nsec=" + nsec + "&msg=&str="
					+ str;
		}
	}

	@RequestMapping("updateProcess_old.do")
	protected void updateProcess(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("reqID") String id,
			@RequestParam("appNo") String appNo,
			@RequestParam("aCode") String aCode,
			@RequestParam("bCode") String bCode,
			@RequestParam("premium") String premium,
			@RequestParam("payType") String payType,
			@RequestParam("productType") String productType,
			@RequestParam("status") String status,
			@RequestParam("pType") String pType) throws Exception {
		logger.info("In Update Process Controller");
		if (null != request.getSession(false)) {
			try {
				this.processService.updateProcess(id, appNo, aCode, bCode,
						premium, payType, productType, status, pType);
			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);
				// e.printStackTrace();
				throw e;
			}
		} else {
			new ModelAndView("session");
		}
	}

	@RequestMapping("updateProcess.do")
	protected String updateProcessNew(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam MultiValueMap<String, String> requestParams,
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In Update Process Controller");
		String pType = requestParams.get("pType").toString();
		if (null != request.getSession(false)) {
			try {
				// System.out.println("In Update");

				UserDto userDto = (UserDto) request.getSession()
						.getAttribute("userDto" + nsec + "");

				ModelAndView mv = new ModelAndView("listProcess");
				pType = pType.replaceAll("\\[", "").replaceAll("\\]", "");
				mv.addObject("pType", pType);
				System.out.println("requestParams = " + requestParams);
				this.processService.updateProcess(userDto.getUserName(),
						requestParams);
				mv.addObject("status", "Processed");
				mv.addObject("nsec", nsec);

			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);
				// e.printStackTrace();
				throw e;
			}
		} else {
			new ModelAndView("session");
		}
		return "redirect:/listProcess.do?pType=" + pType + "&status=All&nsec="
				+ nsec;
	}

	@RequestMapping("testProcess.do")
	protected ModelAndView updateProcess2(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("nsec") String nsec)
			throws Exception {
		ModelAndView model = new ModelAndView("welcome");
		model.addObject("nsec", nsec);
		return model;
	}

}