package com.survey;

public class SurveyDTO {
	
	int surveyID;
	String userID;
	String lectureName;
	String professorName;
	int lectureYear;
	String semesterDivide;
	String lectureDivide;
	String surveyTitle;
	String surveyContent;
	String totalScore;
	String creditScore;
	String comfortableScore;
	String lectureScore;
	int likeCount;
	
	public SurveyDTO() {
		
	}
	
	public SurveyDTO(int surveyID, String userID, String lectureName, String professorName, int lectureYear,
			String semesterDivide, String lectureDivide, String surveyTitle, String surveyContent, String totalScore,
			String creditScore, String comfortableScore, String lectureScore, int likeCount) {
		this.surveyID = surveyID;
		this.userID = userID;
		this.lectureName = lectureName;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.lectureDivide = lectureDivide;
		this.surveyTitle = surveyTitle;
		this.surveyContent = surveyContent;
		this.totalScore = totalScore;
		this.creditScore = creditScore;
		this.comfortableScore = comfortableScore;
		this.lectureScore = lectureScore;
		this.likeCount = likeCount;
	}
	public int getSurveyID() {
		return surveyID;
	}
	public void setSurveyID(int surveyID) {
		this.surveyID = surveyID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public int getLectureYear() {
		return lectureYear;
	}
	public void setLectureYear(int lectureYear) {
		this.lectureYear = lectureYear;
	}
	public String getSemesterDivide() {
		return semesterDivide;
	}
	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}
	public String getLectureDivide() {
		return lectureDivide;
	}
	public void setLectureDivide(String lectureDivide) {
		this.lectureDivide = lectureDivide;
	}
	public String getSurveyTitle() {
		return surveyTitle;
	}
	public void setSurveyTitle(String surveyTitle) {
		this.surveyTitle = surveyTitle;
	}
	public String getSurveyContent() {
		return surveyContent;
	}
	public void setSurveyContent(String surveyContent) {
		this.surveyContent = surveyContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getCreditScore() {
		return creditScore;
	}
	public void setCreditScore(String creditScore) {
		this.creditScore = creditScore;
	}
	public String getComfortableScore() {
		return comfortableScore;
	}
	public void setComfortableScore(String comfortableScore) {
		this.comfortableScore = comfortableScore;
	}
	public String getLectureScore() {
		return lectureScore;
	}
	public void setLectureScore(String lectureScore) {
		this.lectureScore = lectureScore;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
}
