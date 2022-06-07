package com.company.myapp.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.company.myapp.common.CommonUtility;
import com.company.myapp.dto.ProcessMetaDataDto;
import com.company.myapp.dto.UserDto;
import com.company.myapp.service.LdapService;
import com.company.myapp.service.LoginService;

@Controller
public class LoginController {

	private static Logger logger = Logger.getLogger(LoginController.class);

	@Autowired
	@Qualifier("loginService")
	LoginService loginService;

	@Autowired
	@Qualifier("ldapService")
	LdapService ldapService;

	@Autowired
	CommonUtility commonUtilityService;

	@RequestMapping("/login.do")
	protected ModelAndView welcomePage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Login");

		ModelAndView model = new ModelAndView("newLogin");
		model.addObject("msg", "Welcome to my Application");
		return model;
	}

	@RequestMapping("/validateUser.do")
	public ModelAndView validateEmp(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("userID") String userID,
			@RequestParam("password") String password,
			@RequestParam("pType") String pType,
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In Validate for userID: " + userID);

		Boolean ldap = false;

		try {
			ModelAndView modelAndView = null;

			if (ldap) {
				if (null != request.getSession(false)) {
					UserDto userDto = this.loginService.getUserInfo(userID);
					String userName = this.ldapService.getUserDetails(userID,
							password);
					if ((userDto == null) || (userName == null)) {
						modelAndView = new ModelAndView("newLogin");
						modelAndView.addObject("validationFail",
								"User Id or Password Is Incorrect. Kindly Try Again...");
					} else {
						request.getSession().setAttribute("userDto" + nsec + "",
								userDto);
						userDto = (UserDto) request.getSession()
								.getAttribute("userDto" + nsec + "");
						List<ProcessMetaDataDto> lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

						List<Map<String, Object>> listOfProcess = this.loginService
								.getProcessNames(userDto);
						Map<String, Map<String, Integer>> statusCount = this.loginService
								.getStatusCount();

						if (userDto.getRole().equalsIgnoreCase("Admin")) {
							lstMetaDataDto = this.loginService
									.listProcessMetatData();
						}
						if (userDto.getRole().equalsIgnoreCase("User")) {
							lstMetaDataDto = this.loginService
									.listProcessNameByUser(userDto.getUserID());
						}

						modelAndView = new ModelAndView("dashboard");

						if (pType.equals("new")) {
							pType = lstMetaDataDto.get(0).getpName();

							Double processedCount = this.loginService
									.getProCount(pType);
							Double errorCount = this.loginService
									.getErrCount(pType);
							Double unprocessedCnt = this.loginService
									.getUnProCount(pType);

							Double totalCount = processedCount + errorCount
									+ unprocessedCnt;

							Double process = 0.0;
							Double error = 0.0;
							Double unprocess = 0.0;

							Integer percentError = 0;
							Integer percentProcessed = 0;
							Integer percentUnprocessed = 0;
							if (percentError != 0) {
								error = ((errorCount * 100) / totalCount);
								percentError = (int) Math.round(error);
							} else if (percentProcessed != 0) {
								process = ((processedCount * 100) / totalCount);
								percentProcessed = (int) Math.round(process);
							} else if (percentUnprocessed != 0) {
								unprocess = ((unprocessedCnt * 100)
										/ totalCount);
								percentUnprocessed = (int) Math
										.round(unprocess);
							} else if (totalCount != 0) {
								error = ((errorCount * 100) / totalCount);
								percentError = (int) Math.round(error);
								process = ((processedCount * 100) / totalCount);
								percentProcessed = (int) Math.round(process);
								unprocess = ((unprocessedCnt * 100)
										/ totalCount);
								percentUnprocessed = (int) Math
										.round(unprocess);
							}

							String str = "p";
							modelAndView.addObject("pType", pType);
							modelAndView.addObject("aErr",
									str.concat(percentError.toString()));
							modelAndView.addObject("aProcess",
									str.concat(percentProcessed.toString()));
							modelAndView.addObject("aUnprocess",
									str.concat(percentUnprocessed.toString()));
							modelAndView.addObject("totalCount",
									(int) Math.round(totalCount));
							modelAndView.addObject("pCount",
									(int) Math.round(processedCount));
							modelAndView.addObject("eCount",
									(int) Math.round(errorCount));
							modelAndView.addObject("unPCount",
									(int) Math.round(unprocessedCnt));
							modelAndView.addObject("Error", percentError);
							modelAndView.addObject("Processed",
									percentProcessed);
							modelAndView.addObject("Unprocessed",
									percentUnprocessed);
							modelAndView.addObject("listOfProcess",
									listOfProcess);
							modelAndView.addObject("statusCount", statusCount);
						}
						modelAndView.addObject("lstMetaDataDto",
								lstMetaDataDto);
						modelAndView.addObject("nsec", nsec);
					}
				} else {
					modelAndView = new ModelAndView("session");
				}
				return modelAndView;

			} else {

				if (null != request.getSession(false)) {
					UserDto userDto = this.loginService.validateUser(userID,
							password);
					String userName = this.ldapService.getUserDetails(userID,
							password);
					if ((userDto == null) && (userName == null)) {
						modelAndView = new ModelAndView("newLogin");
						modelAndView.addObject("validationFail",
								"User Id or Password Is Incorrect. Kindly Try Again...");
					} else {
						request.getSession().setAttribute("userDto" + nsec + "",
								userDto);
						userDto = (UserDto) request.getSession()
								.getAttribute("userDto" + nsec + "");
						List<ProcessMetaDataDto> lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

						List<Map<String, Object>> listOfProcess = this.loginService
								.getProcessNames(userDto);
						Map<String, Map<String, Integer>> statusCount = this.loginService
								.getStatusCount();

						if (userDto.getRole().equalsIgnoreCase("Admin")) {
							lstMetaDataDto = this.loginService
									.listProcessMetatData();
						}
						if (userDto.getRole().equalsIgnoreCase("User")) {
							lstMetaDataDto = this.loginService
									.listProcessNameByUser(userDto.getUserID());
						}

						modelAndView = new ModelAndView("dashboard");

						if (pType.equals("new")) {
							pType = lstMetaDataDto.get(0).getpName();

							Double processedCount = this.loginService
									.getProCount(pType);
							Double errorCount = this.loginService
									.getErrCount(pType);
							Double unprocessedCnt = this.loginService
									.getUnProCount(pType);

							Double totalCount = processedCount + errorCount
									+ unprocessedCnt;

							Double process = 0.0;
							Double error = 0.0;
							Double unprocess = 0.0;

							Integer percentError = 0;
							Integer percentProcessed = 0;
							Integer percentUnprocessed = 0;
							if (percentError != 0) {
								error = ((errorCount * 100) / totalCount);
								percentError = (int) Math.round(error);
							} else if (percentProcessed != 0) {
								process = ((processedCount * 100) / totalCount);
								percentProcessed = (int) Math.round(process);
							} else if (percentUnprocessed != 0) {
								unprocess = ((unprocessedCnt * 100)
										/ totalCount);
								percentUnprocessed = (int) Math
										.round(unprocess);
							} else if (totalCount != 0) {
								error = ((errorCount * 100) / totalCount);
								percentError = (int) Math.round(error);
								process = ((processedCount * 100) / totalCount);
								percentProcessed = (int) Math.round(process);
								unprocess = ((unprocessedCnt * 100)
										/ totalCount);
								percentUnprocessed = (int) Math
										.round(unprocess);
							}

							String str = "p";
							modelAndView.addObject("pType", pType);
							modelAndView.addObject("aErr",
									str.concat(percentError.toString()));
							modelAndView.addObject("aProcess",
									str.concat(percentProcessed.toString()));
							modelAndView.addObject("aUnprocess",
									str.concat(percentUnprocessed.toString()));
							modelAndView.addObject("totalCount",
									(int) Math.round(totalCount));
							modelAndView.addObject("pCount",
									(int) Math.round(processedCount));
							modelAndView.addObject("eCount",
									(int) Math.round(errorCount));
							modelAndView.addObject("unPCount",
									(int) Math.round(unprocessedCnt));
							modelAndView.addObject("Error", percentError);
							modelAndView.addObject("Processed",
									percentProcessed);
							modelAndView.addObject("Unprocessed",
									percentUnprocessed);
							modelAndView.addObject("listOfProcess",
									listOfProcess);
							modelAndView.addObject("statusCount", statusCount);
						}
						modelAndView.addObject("lstMetaDataDto",
								lstMetaDataDto);
						modelAndView.addObject("nsec", nsec);
					}
				} else {
					modelAndView = new ModelAndView("session");
				}
				return modelAndView;

			}

		} catch (Exception e) {
			HttpSession session = request.getSession();
			session.invalidate();
			logger.error("Exception : " + e.getMessage(), e);
			// e.printStackTrace();
			throw e;
		}
	}

	@RequestMapping("dashboard.do")
	protected ModelAndView registerProcess(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("pType") String pType,
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In Dashboard Controller");
		ModelAndView model = null;
		if (null != request.getSession(false)) {
			UserDto userDto = (UserDto) request.getSession()
					.getAttribute("userDto" + nsec + "");
			try {
				model = new ModelAndView("dashboard");

				List<ProcessMetaDataDto> lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();
				List<Map<String, Object>> listOfProcess = this.loginService
						.getProcessNames(userDto);
				Map<String, Map<String, Integer>> statusCount = this.loginService
						.getStatusCount();

				if (userDto.getRole().equalsIgnoreCase("Admin")) {
					lstMetaDataDto = this.loginService.listProcessMetatData();
				}
				if (userDto.getRole().equalsIgnoreCase("User")) {
					lstMetaDataDto = this.loginService
							.listProcessNameByUser(userDto.getUserID());
				}

				if (pType.equals("new")) {
					pType = lstMetaDataDto.get(0).getpName();

					Double processedCount = this.loginService
							.getProCount(pType);
					Double errorCount = this.loginService.getErrCount(pType);
					Double unprocessedCnt = this.loginService
							.getUnProCount(pType);

					Double totalCount = processedCount + errorCount
							+ unprocessedCnt;

					Double process = 0.0;
					Double error = 0.0;
					Double unprocess = 0.0;

					Integer percentError = 0;
					Integer percentProcessed = 0;
					Integer percentUnprocessed = 0;
					if (percentError != 0) {
						error = ((errorCount * 100) / totalCount);
						percentError = (int) Math.round(error);
					} else if (percentProcessed != 0) {
						process = ((processedCount * 100) / totalCount);
						percentProcessed = (int) Math.round(process);
					} else if (percentUnprocessed != 0) {
						unprocess = ((unprocessedCnt * 100) / totalCount);
						percentUnprocessed = (int) Math.round(unprocess);
					} else if (totalCount != 0) {
						error = ((errorCount * 100) / totalCount);
						percentError = (int) Math.round(error);
						process = ((processedCount * 100) / totalCount);
						percentProcessed = (int) Math.round(process);
						unprocess = ((unprocessedCnt * 100) / totalCount);
						percentUnprocessed = (int) Math.round(unprocess);
					}

					String str = "p";
					model.addObject("pType", pType);
					model.addObject("aErr",
							str.concat(percentError.toString()));
					model.addObject("aProcess",
							str.concat(percentProcessed.toString()));
					model.addObject("aUnprocess",
							str.concat(percentUnprocessed.toString()));
					model.addObject("totalCount", (int) Math.round(totalCount));
					model.addObject("pCount", (int) Math.round(processedCount));
					model.addObject("eCount", (int) Math.round(errorCount));
					model.addObject("unPCount",
							(int) Math.round(unprocessedCnt));
					model.addObject("Error", percentError);
					model.addObject("Processed", percentProcessed);
					model.addObject("Unprocessed", percentUnprocessed);
					model.addObject("listOfProcess", listOfProcess);
					model.addObject("statusCount", statusCount);

				} else {
					Double processedCount = this.loginService
							.getProCount(pType);
					Double errorCount = this.loginService.getErrCount(pType);
					Double unprocessedCnt = this.loginService
							.getUnProCount(pType);

					Double totalCount = processedCount + errorCount
							+ unprocessedCnt;

					Double process = 0.0;
					Double error = 0.0;
					Double unprocess = 0.0;

					Integer percentError = 0;
					Integer percentProcessed = 0;
					Integer percentUnprocessed = 0;
					if (percentError != 0) {
						error = ((errorCount * 100) / totalCount);
						percentError = (int) Math.round(error);
					} else if (percentProcessed != 0) {
						process = ((processedCount * 100) / totalCount);
						percentProcessed = (int) Math.round(process);
					} else if (percentUnprocessed != 0) {
						unprocess = ((unprocessedCnt * 100) / totalCount);
						percentUnprocessed = (int) Math.round(unprocess);
					} else if (totalCount != 0) {
						error = ((errorCount * 100) / totalCount);
						percentError = (int) Math.round(error);
						process = ((processedCount * 100) / totalCount);
						percentProcessed = (int) Math.round(process);
						unprocess = ((unprocessedCnt * 100) / totalCount);
						percentUnprocessed = (int) Math.round(unprocess);
					}

					String str = "p";
					model.addObject("pType", pType);
					model.addObject("aErr",
							str.concat(percentError.toString()));
					model.addObject("aProcess",
							str.concat(percentProcessed.toString()));
					model.addObject("aUnprocess",
							str.concat(percentUnprocessed.toString()));
					model.addObject("totalCount", (int) Math.round(totalCount));
					model.addObject("pCount", (int) Math.round(processedCount));
					model.addObject("eCount", (int) Math.round(errorCount));
					model.addObject("unPCount",
							(int) Math.round(unprocessedCnt));
					model.addObject("Error", percentError);
					model.addObject("Processed", percentProcessed);
					model.addObject("Unprocessed", percentUnprocessed);
					model.addObject("listOfProcess", listOfProcess);
					model.addObject("statusCount", statusCount);

				}
				model.addObject("lstMetaDataDto", lstMetaDataDto);
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

	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("nsec") String nsec)
			throws Exception {
		logger.info("In Logout Controller");
		ModelAndView modelAndView = null;
		try {
			HttpSession session = request.getSession();
			for (Enumeration e = session.getAttributeNames(); e
					.hasMoreElements();) {
				String attribName = (String) e.nextElement();
				if (attribName.contains(nsec)) {
					session.removeAttribute(attribName);
				}
			}
			modelAndView = new ModelAndView("newLogin");
		} catch (Exception e) {
			logger.error("Exception : " + e.getMessage(), e);
			// e.printStackTrace();
			throw e;
		}
		return modelAndView;
	}

	@RequestMapping("changePassword.do")
	protected ModelAndView changePassword(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("In Change Password Controller");
		ModelAndView model = new ModelAndView("changePassword");
		return model;
	}

	@RequestMapping("/updatePassword.do")
	public void updatePassword(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("oldPassword") String oldPassword,
			@RequestParam("newPassword") String newPassword,
			@RequestParam("conPassword") String conPassword,
			@RequestParam("userID") Integer UserID) throws Exception {

		logger.info("Change Password for UserID: " + UserID);
		if (null != request.getSession(false)) {
			try {
				this.loginService.changePassword(oldPassword, conPassword,
						newPassword, UserID);
				// response.sendRedirect("home.do");
			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);
				throw e;
			}
		} else {
			new ModelAndView("session");
		}
	}

	@RequestMapping("createUser.do")
	protected ModelAndView userCreation(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("nsec") String nsec,
			@RequestParam("msg") String msg) throws Exception {
		logger.info("In Create User Controller");
		/* ModelAndView model = new ModelAndView("test"); */
		ModelAndView model = new ModelAndView("createUser");
		List<ProcessMetaDataDto> lstProMetaData = this.loginService
				.listProcessMetatData();
		model.addObject("lstProMetaData", lstProMetaData);
		model.addObject("nsec", nsec);
		model.addObject("msg", msg);
		return model;
	}

	@RequestMapping("saveUser.do")
	public ModelAndView saveUser(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("fName") String fName,
			@RequestParam("lName") String lName,
			@RequestParam("uName1") String uName,
			@RequestParam("address") String address,
			@RequestParam("gender") String gender,
			@RequestParam("pwd") String pwd, @RequestParam("role") String role,
			@RequestParam("pName") String[] processName,
			@RequestParam("nsec") String nsec) throws Exception {
		logger.info("In Save User Controller");
		ModelAndView model = new ModelAndView("createUser");
		UserDto userData = new UserDto();
		String msg = null;
		List<ProcessMetaDataDto> lstProMetaData = this.loginService
				.listProcessMetatData();
		if (null != request.getSession(false)) {

			try {
				UserDto userDto = (UserDto) request.getSession()
						.getAttribute("userDto" + nsec + "");
				List<String> loginUsernames = this.loginService.listUserNames();
				Boolean flag = true;
				for (int i = 0; i <= loginUsernames.size(); i++) {
					if (loginUsernames.get(i).equals(uName)) {
						System.out.println("User name is already exit");
						msg = "User Name is already exist";

						flag = false;

						userData.setFirstName(fName);
						userData.setLastName(lName);
						userData.setUserName(uName);
						userData.setAddress(address);
						userData.setGender(gender);
						userData.setPassword(pwd);
						userData.setRole(role);
						System.out.println(userData.getGender());
						break;
					}
				}

				if (flag) {
					this.loginService.saveUser(fName, lName, uName, address,
							gender, pwd, role, processName,
							userDto.getUserName());
				}

			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);

				throw e;
			}

			model.addObject("lstProMetaData", lstProMetaData);
			model.addObject("userData", userData);
			model.addObject("msg", msg);
			model.addObject("nsec", nsec);
			model.addObject("lstProcessNames", processName);

		} else {
			new ModelAndView("session");
		}

		return model;

		// return "redirect:/createUser.do?nsec="+nsec+"&msg=New user has been
		// created successfully...!";
	}

	@RequestMapping("updateUser.do")
	protected ModelAndView updatePUser(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("nsec") String nsec,
			@RequestParam("userName") String uName,
			@RequestParam("msg") String msg) throws Exception {

		UserDto userDto = (UserDto) request.getSession()
				.getAttribute("userDto" + nsec + "");
		UserDto userData = null;
		List<String> lstProcessNames = null;

		ModelAndView model = new ModelAndView("updateUser");

		List<String> lstUserNameData = this.loginService.listUserNames();

		List<ProcessMetaDataDto> lstProMetaData = this.loginService
				.listProcessMetatData();

		if (!(uName).equals("New")) {
			userData = this.loginService.listUserData(uName);

			lstProcessNames = this.loginService
					.listUserProcessData(userData.getUserID());

		}

		model.addObject("lstProMetaData", lstProMetaData);
		model.addObject("nsec", nsec);
		model.addObject("lstUserNameData", lstUserNameData);
		model.addObject("userData", userData);
		model.addObject("lstProcessNames", lstProcessNames);
		model.addObject("uName", uName);
		model.addObject("msg", msg);

		return model;
	}

	@RequestMapping("updateUserData.do")
	public String updateUserData(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("fName") String fName,
			@RequestParam("lName") String lName,
			@RequestParam("uName1") String uName,
			@RequestParam("address") String address,
			@RequestParam("gender") String gender,
			@RequestParam("pwd") String pwd, @RequestParam("role") String role,
			@RequestParam("pName") String[] processName,
			@RequestParam("nsec") String nsec,
			@RequestParam("UserID") int userID) throws Exception {

		logger.info("In Save User Controller");
		if (null != request.getSession(false)) {
			try {
				UserDto userDto = (UserDto) request.getSession()
						.getAttribute("userDto" + nsec + "");

				if (!uName.equals("New")) {
					this.loginService.updateUserData(fName, lName, uName,
							address, gender, pwd, role, processName, userID,
							userDto.getUserName());
				}
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
		return "redirect:/updateUser.do?userName=New&nsec=" + nsec
				+ "&msg=User info updated successfully...!";
	}

	@RequestMapping("session.do")
	protected ModelAndView session(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("In Change Password Controller");
		ModelAndView model = new ModelAndView("session");
		return model;
	}

	@RequestMapping("processList.do")
	protected void processList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("nsec") String nsec,
			@RequestParam("type") String type) throws Exception {
		if (null != request.getSession(false)) {
			try {
				System.out.println("type = " + type);
				logger.info("In Process List Controller");
				UserDto userDto = (UserDto) request.getSession()
						.getAttribute("userDto" + nsec + "");

				List<ProcessMetaDataDto> lstMetaDataDto = new ArrayList<ProcessMetaDataDto>();

				if (userDto.getRole().equalsIgnoreCase("Admin")) {
					lstMetaDataDto = this.loginService
							.listProcessMetatData1(type);
				}
				if (userDto.getRole().equalsIgnoreCase("End User")) {
					lstMetaDataDto = this.loginService
							.listProcessNameByUser1(type, userDto.getUserID());
				}
			} catch (Exception e) {
				HttpSession session = request.getSession();
				session.invalidate();
				logger.error("Exception : " + e.getMessage(), e);
				throw e;
			}
		} else {
			new ModelAndView("session");
		}
	}
}