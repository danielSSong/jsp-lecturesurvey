package com.likey;

public class LikeyDTO {

	String userID;
	int surveyID;
	String userIP;
	
	public LikeyDTO() {

	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getSurveyID() {
		return surveyID;
	}
	public void setSurveyID(int surveyID) {
		this.surveyID = surveyID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	public LikeyDTO(String userID, int surveyID, String userIP) {
		super();
		this.userID = userID;
		this.surveyID = surveyID;
		this.userIP = userIP;
	}
	
	
}
