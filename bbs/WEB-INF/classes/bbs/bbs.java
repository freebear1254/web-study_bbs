package bbs;

public class bbs {
	private int bbsID;
	private String userID;
	private String bbsTitle;
	private String bbsDate;
	private String bbsContents;
	private int bbsAvailable;
	private int hit;
	private int good;
	private int bad;
	private int parentBbsID;
	
	
	
	public int getHit() {
		return hit;
	}
	public int getParentBbsID() {
		return parentBbsID;
	}
	public void setParentBbsID(int parentBbsID) {
		this.parentBbsID = parentBbsID;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getBad() {
		return bad;
	}
	public void setBad(int bad) {
		this.bad = bad;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContents() {
		return bbsContents;
	}
	public void setBbsContents(String bbsContents) {
		this.bbsContents = bbsContents;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
}
