package com.survey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DatabaseUtil;

public class SurveyDAO {
	
	public int write(SurveyDTO surveyDTO) {
		String SQL = "INSERT INTO SURVEY VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, surveyDTO.getUserID());
			pstmt.setString(2, surveyDTO.getLectureName());
			pstmt.setString(3, surveyDTO.getProfessorName());
			pstmt.setInt(4, surveyDTO.getLectureYear());
			pstmt.setString(5, surveyDTO.getSemesterDivide());
			pstmt.setString(6, surveyDTO.getLectureDivide());
			pstmt.setString(7, surveyDTO.getSurveyTitle());
			pstmt.setString(8, surveyDTO.getSurveyContent());
			pstmt.setString(9, surveyDTO.getTotalScore());
			pstmt.setString(10, surveyDTO.getCreditScore());
			pstmt.setString(11, surveyDTO.getComfortableScore());
			pstmt.setString(12, surveyDTO.getLectureScore());

			return pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return -1; //database error
		
	}
	
}
