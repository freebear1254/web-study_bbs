package file;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;

/**
 * Servlet implementation class downloadAction
 */
@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String fileName = request.getParameter("file");
		String bbsID = request.getParameter("bbsID");
		String directory = "C:\\Users\\LG\\Desktop\\upload\\"+bbsID; //this.getServletContext().getRealPath("/upload");
		File file = new File(directory + "/"+fileName);//-> file 객체에 file 의 정보(directory + name)
		
		String mimeType = getServletContext().getMimeType(file.toString());//mimeType 를 가져와서 검사
		if(mimeType == null) {
			response.setContentType("application/octet-stream");//없으면 application/octet-stream (이진타입 기본값) 으로지정
		}
		String downloadName = null;
		
		if(request.getHeader("user-agnet").indexOf("MSIE") == -1) {
			downloadName = new String(fileName.getBytes("utf-8"),"8859_1");
		}else {
			downloadName = new String(fileName.getBytes("EUC-KR"),"8859_1");			
		}// 브라우저별 인코딩 타입에 대해 설정
		
		
		response.setHeader("Content-Disposition","attachment;filename=\""
				+downloadName + "\";"); 
		
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		byte b[] = new byte [1024];
		int data = 0;
		
		while ((data = (fileInputStream.read(b,0,b.length))) !=-1) {
			servletOutputStream.write(b,0,data);
		}
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
		
	}


}
