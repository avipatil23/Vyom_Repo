package com.company.myapp.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.company.myapp.dto.UserDto;


public class UserDetailsRowMapper implements RowMapper<UserDto> {
	
	public UserDto mapRow(ResultSet rs, int rowNum) throws SQLException{
		UserDto userDto = new UserDto();

		userDto.setUserID(rs.getInt("UserID"));
		userDto.setFirstName(rs.getString("FirstName"));
		userDto.setLastName(rs.getString("LastName"));
		userDto.setUserName(rs.getString("UserName"));
		userDto.setPassword(rs.getString("Password"));
		userDto.setAddress(rs.getString("Address"));
		userDto.setGender(rs.getString("Gender"));
		userDto.setRole(rs.getString("Role"));
		
		return userDto;
	}
}