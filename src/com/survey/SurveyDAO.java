package com.survey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
			pstmt.setString(1, surveyDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, surveyDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, surveyDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, surveyDTO.getLectureYear());
			pstmt.setString(5, surveyDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, surveyDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, surveyDTO.getSurveyTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, surveyDTO.getSurveyContent().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, surveyDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, surveyDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, surveyDTO.getComfortableScore().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, surveyDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\r\n", "<br>"));

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return -1; // database error

	}

	public ArrayList<SurveyDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
		if (lectureDivide.equals("ALL")) {
			lectureDivide = "";
		}
		
		ArrayList<SurveyDTO> surveyList = null;
		
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			if(searchType.equals("Latest")) {
				SQL = "SELECT * FROM SURVEY WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, surveyTitle, surveyContent) LIKE " + 
			"? ORDER BY surveyID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if (searchType.equals("Like")) {
				SQL = "SELECT * FROM SURVEY WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, surveyTitle, surveyContent) LIKE " + 
			"? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + lectureDivide + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			surveyList = new ArrayList<SurveyDTO>();

			while (rs.next()) {
				SurveyDTO survey = new SurveyDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)
				);
				surveyList.add(survey);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return surveyList;

	}

	
	public int like(String surveyID) {
		String SQL = "UPDATE SURVEY SET likeCount = likeCount + 1 WHERE surveyID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(surveyID));
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
		return -1; // database error
	}
	
	public int delete(String surveyID) {
		String SQL = "DELETE FROM SURVEY WHERE surveyID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(surveyID));
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
		return -1; // database error
	}
	
	public String getUserID(String surveyID) {
		String SQL = "SELECT userID FROM SURVEY WHERE surveyID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(surveyID));
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
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
		return null; // not existed
	}
}
