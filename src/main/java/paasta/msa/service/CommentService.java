package paasta.msa.service;

import java.util.List;
import java.util.Map;

public interface CommentService {

	public Map<String, Object> getCommentCount(Map<String, String> paramMap) throws Exception;
	
	public Map<String, Object> getCommentList(Map<String, String> paramMap) throws Exception;
	
	public Map<String, Object> postComment(Map<String, String> paramMap) throws Exception;

	public Map<String, Object> putComment(Map<String, String> paramMap) throws Exception;

	public Map<String, Object> deleteComment(Map<String, String> paramMap) throws Exception;

}
