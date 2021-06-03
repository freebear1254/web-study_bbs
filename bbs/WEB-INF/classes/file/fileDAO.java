package file;
import java.sql.*;
import config.configBbsDb;
import java.io.File;
import java.nio.file.FileAlreadyExistsException;
import java.util.ArrayList;


public class fileDAO {
	private Connection conn = null;
	private PreparedStatement pstm = null;
	private ResultSet rs = null;
	private Statement stmt = null;

	configBbsDb configBbsDb = new configBbsDb();

	public fileDAO() {
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
	}
	public int upload(String fileName , String fileRealName ,int bbsID){
		String sql = "INSERT INTO file VALUES (?,?,?)";
		try {
		pstm = conn.prepareStatement(sql);
		pstm.setInt(1, bbsID);
		pstm.setString(2,fileName);
		pstm.setNString(3, fileRealName);
		
		return pstm.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return -1;
		
	}	//upload
	
	public ArrayList<fileDTO> getFile (int bbsID) {
		ArrayList<fileDTO> file = new ArrayList();
		
		String sql = "SELECT * From file WHERE bbsID = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, bbsID);
			rs = pstm.executeQuery();
			while(rs.next()) {
				fileDTO fileDTO = new fileDTO();
				fileDTO.setBbsID(rs.getInt("bbsID"));
				fileDTO.setFileName(rs.getString("fileName"));
				fileDTO.setFileRealName(rs.getString("fileRealName"));
				file.add(fileDTO);				
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}		
		return file;
	}

}