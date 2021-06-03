package config;

public class configBbsDb {
	private	String dbURL = "jdbc:mysql://localhost:3306/DBNAME?useUnicode=true&characterEncoding=UTF8&useSSL=false";
	private	String dbID = "";
	private	String dbPassword ="";
	
	public String getDbURL() {
		return dbURL;
	}
	public String getDbID() {
		return dbID;
	}
	public String getDbPassword() {
		return dbPassword;
	}
}
