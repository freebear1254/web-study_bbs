package bbs;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;
import config.configBbsDb;



public class userDAO {
	private Connection conn = null;
	private PreparedStatement pstm = null;
	private ResultSet rs = null;
	private Statement stmt = null;
	
	configBbsDb configBbsDb = new configBbsDb();

	public userDAO() {
		try {
			String dbURL = configBbsDb.getDbURL();
			String dbID = configBbsDb.getDbID();
			String dbPassword = configBbsDb.getDbPassword();

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("mysql 접속 success");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}// DB 커넥션

	public int login(String userID, String userPassword) {
		try {

			String sql = "SELECT userPassword FROM user WHERE userID = ?";
			pstm = conn.prepareStatement(sql);
			System.out.println("error 확인중");
			pstm.setString(1, userID); 

			rs = pstm.executeQuery();
			boolean isTrue = rs.next();
			System.out.println(isTrue);

			if (isTrue) {
				if (rs.getString(1).equals(userPassword)) {
					return 1;// 로그인 성공
				}else return 0; // 패스워드 다름
			}return -1;// 없는 ID

		} catch (Exception e) {
			System.out.println(e.toString());

			return -2; //DB 접속 에러

		}finally {
			try {
				if(rs != null) rs.close();
				if(pstm != null)pstm.close();
				if(conn != null)conn.close();
			} catch (Exception e2) {
				System.out.println(e2.toString());
			}
		}
	}//login()
	
	public int join(String userID, String userPassword, String userName , String userEmail, String userAddr, int zipcode) {
		try {
			String sql ="INSERT INTO user VALUE(?,?,?,?,?,?)";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1,userID);
			pstm.setString(2,userPassword);
			pstm.setString(3,userName);
			pstm.setString(4,userEmail);
			pstm.setString(5,userAddr);
			pstm.setInt(6,zipcode);
			
			pstm.executeUpdate();
			
			return 1;//insert successs
			
		} catch (Exception e) {	
			System.out.println("join() : "+e.toString());
			return -1;// 
		}
	}//join
	
	public int checkID(String userID) {
		int isDoubleID;
		try {
			String sql = "SELECT userID From user WHERE userID = ?";
			pstm= conn.prepareStatement(sql);
			pstm.setString(1, userID);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				isDoubleID=0;//
			}else isDoubleID =1;// 
						
		} catch (Exception e) {
			System.out.println("checkID : "+e.toString());
			isDoubleID = -1; //
		}
		
		return isDoubleID;
	}// checkID
	
	public Vector<user> userView(String sessionUserID) {
		
		Vector<user> userViewVector = new Vector<user>();
		try {
			
			String sql = "SELECT * FROM user WHERE userID = ? ";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, sessionUserID);
			rs = pstm.executeQuery();			
			
			while (rs.next()) {
				user user = new user();
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserAddr(rs.getString("userAddr"));
				user.setUserName(rs.getString("userName"));
				user.setZipcode(rs.getInt("zipcode"));
				userViewVector.add(user);
			}
			
			
		} catch (Exception e) {
			System.out.println("userView : "+e.toString());
		}
		return userViewVector;
	
	}//userView
	
	public int changeUserInfo(String userID, String userPassword , String userName, String userEmail, String userAddr, int zipcode) {
		
		try {
			String sql = "UPDATE user SET userPassword = ? , userName = ? , userEmail =? ,userAddr =? ,zipcode =? WHERE userID = ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, userPassword);
			pstm.setString(2, userName);
			pstm.setString(3, userEmail);
			pstm.setString(4, userAddr);
			pstm.setInt(5, zipcode);
			pstm.setString(6, userID);
			
			pstm.executeUpdate();
			
			return 1;//user info chaged
		} catch (Exception e) {
			System.out.println("chageUserInfo : "+e.toString());
			return -1; //Error
		}

	}//changeUserInfo
	
	public String getDate() {
		String sql = "SELECT now()";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("getData() : "+e.toString());			
		}
		return "";//db error		
	}//getDate
	
	public int getNext() {
		String sql = "SELECT bbsID FROM bbs ORDER by bbsID DESC";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getInt(1)+1;
			}return 1;
			} catch (Exception e) {
			System.out.println("getNext() : "+e.toString());
			}
		return -1;//db erroer
	}// getNext
	
	public int write(int bbsID,String userID, String bbsTitle ,String bbsContents,int parentBbsID) {
		String sql = "INSERT INTO bbs VALUES (?,?,?,?,?,1,0,0,0,?)";
				
		try {			
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, bbsID);
			pstm.setString(2, userID);
			pstm.setString(3, bbsTitle);
			pstm.setString(4, getDate());
			pstm.setString(5, bbsContents);
			pstm.setInt(6, parentBbsID);
			
			pstm.executeUpdate();
			return 1;
		} catch (Exception e) {
			System.out.println("write() :"+e.toString());
			
		}
		return -1;// DB error
	}//write();
	
	public ArrayList<bbs> getList(int pageNumber,int listLimit, String searchSql){
		
		ArrayList<bbs> bbsList =new ArrayList<bbs>();
		String sql = "SELECT * FROM bbs WHERE bbsAvailable = 1 AND parentBbsID = 0 "+searchSql+" ORDER BY bbsID DESC LIMIT ? OFFSET ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, listLimit);
			pstm.setInt(2,(pageNumber-1)*listLimit);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				bbs bbs = new bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setUserID(rs.getString("userID"));				
				bbs.setBbsTitle(rs.getString("bbsTitle").replaceAll("(?i)<script", "&lt;script"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				bbs.setHit(rs.getInt("hit"));
				bbs.setBad(rs.getInt("bad"));
				bbs.setGood(rs.getInt("good"));
				bbsList.add(bbs);				
			}
		} catch (Exception e) {
			System.out.println("ArrayList() : "+e.toString());
		}
		return bbsList;
	}//getList();
	
	public boolean isNextPage(int pageNumber,int listLimit,String searchSql) {
		
		String sql = "SELECT * FROM bbs WHERE bbsAvailable = 1 AND parentBbsID = 0 "+searchSql+" ORDER BY bbsID DESC LIMIT ? OFFSET ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, listLimit);
			pstm.setInt(2,(pageNumber-1)*listLimit);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			System.out.println("nextPage() : "+e.toString());
		}
		return false;
	}//isNextPage
	
	public void plusHit(int bbsID) {
		String sql = "UPDATE bbs SET hit = hit + 1 WHERE bbsID = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, bbsID);			
			pstm.executeUpdate();			
			
		} catch (Exception e) {
			System.out.println("plusHit() "+ e.toString());
		}
	}
	
	
	public ArrayList<bbs> getBbsView(int bbsID) {
		ArrayList<bbs> bbsView =new ArrayList<bbs>();
		String sql = "SELECT * FROM bbs WHERE bbsID = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, bbsID);			
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				bbs bbs = new bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsTitle(rs.getString("bbsTitle").replaceAll("(?i)<script", "&lt;script"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				if (rs.getString("bbsContents")!=null){
					bbs.setBbsContents(rs.getString("bbsContents").replaceAll("(?i)<script", "&lt;script"));
				}else {bbs.setBbsContents("null");}				
				bbs.setHit(rs.getInt("hit"));
				bbs.setBad(rs.getInt("bad"));
				bbs.setGood(rs.getInt("good"));
				bbsView.add(bbs);				
			}
		} catch (Exception e) {
			System.out.println("ArrayList() : "+e.toString());
		}
		return bbsView;		
	}//getBbsview
	
	public int deleteBbs(int bbsID) {
		String sql = "UPDATE bbs SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, bbsID);			
			pstm.executeUpdate();			
			
			return 1;
		} catch (Exception e) {
			System.out.println("deleteBbs() "+ e.toString());
		}return-1;
		
		
	}//deleteBbs
	public int modifyBbs(String bbsTitle, String bbsContents , int bbsID) {
		String sql = "UPDATE bbs SET bbsTitle =?, bbsContents = ? WHERE bbsID =?";
		try {			
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, bbsTitle);
			pstm.setString(2, bbsContents);
			pstm.setInt(3, bbsID);
			
			pstm.executeUpdate();
			return 1;
		} catch (Exception e) {
			System.out.println("modifyBbs :"+e.toString());			
		}
		return -1;
	}//modifyBbs();
	
	public void badAction(int bbsID) {
		String sql = "UPDATE bbs SET bad = bad+1 WHERE bbsID = ?";
		try {			
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1,bbsID);
			
			pstm.executeUpdate();			
		} catch (Exception e) {
			System.out.println("badAction :"+e.toString());			
		}
	}//badAction()
	public void goodAction(int bbsID) {
		String sql = "UPDATE bbs SET good = good +1 WHERE bbsID = ?";
		try {			
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1,bbsID);
			
			pstm.executeUpdate();			
		} catch (Exception e) {
			System.out.println("goodAction :"+e.toString());			
		}
	}//badAction()
public ArrayList<bbs> getCommentList(int bbsID){
		
		ArrayList<bbs> bbsComentList =new ArrayList<bbs>();
		String sql = "SELECT * FROM bbs WHERE bbsAvailable = 1 AND parentBbsID = ? ORDER BY bbsID DESC ";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, bbsID);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				bbs bbs = new bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setUserID(rs.getString("userID"));				
				bbs.setBbsTitle(rs.getString("bbsTitle").replaceAll("(?i)<script", "&lt;script"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsContents(rs.getString("bbsContents").replaceAll("(?i)<script", "&lt;script"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				bbs.setHit(rs.getInt("hit"));
				bbs.setBad(rs.getInt("bad"));
				bbs.setGood(rs.getInt("good"));
				bbsComentList.add(bbs);				
			}
		} catch (Exception e) {
			System.out.println("ArrayList() : "+e.toString());
		}
		return bbsComentList;
	}//getCommentList();
public int countComment(int bbsID) {
	int count =0;
	String sql = "SELECT COUNT(*) FROM bbs WHERE parentBbsID = ?";
	try {
		pstm = conn.prepareStatement(sql);
		pstm.setInt(1, bbsID);
		rs = pstm.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
	} catch (Exception e) {
		System.out.println("countComment() " + e.toString());
	}return count;
}
	
}
