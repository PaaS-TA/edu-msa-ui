package paasta.msa.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import paasta.msa.common.CommonUtil;
import paasta.msa.service.CommentService;

/**
 * @author Jae Young Im
 *
 */
@Controller
public class CommentController {

	@Resource(name = "commentService")
	private CommentService commentService;

	private static String SUCCESS = "SUCCESS";
	
	@RequestMapping(value = "/comments", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getComments(@RequestParam(required = true) Integer boardSeq) {
		
		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, Object> result = new HashMap<String, Object>();


		paramMap.put("boardSeq", boardSeq.toString());
		// Select CommentList
		try {
			result = commentService.getCommentList(paramMap);
		} catch (Exception e) {
			result.put("result", "ERROR");
			result.put("errMsg", e.getMessage());
			e.printStackTrace();
		}
		
		return result;
	}

	@RequestMapping(value = "/comments", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> postComment(@RequestParam Map<String, String> paramMap) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();

		// parameter Setting
		try {

			String comment = paramMap.get("comment");
			String writeUserId = paramMap.get("writeUserId");
			String writeUserName = paramMap.get("writeUserName");
			
			// null String check
			if(CommonUtil.isEmptyString(comment)) {
				throw new Exception("????????? ????????? ?????? ??????????????????.");
			} else if(CommonUtil.isEmptyString(writeUserId)) {
				throw new Exception("????????? ID??? ?????? ??????????????????.");
			} else if(CommonUtil.isEmptyString(writeUserName)) {
				throw new Exception("????????? ?????? ?????? ??????????????????.");
			}

		} catch (Exception e) {
			result.put("result", "ERROR");
			result.put("errMsg", e.getMessage());
			e.printStackTrace();

			return result;
		}
		
		try {
			
			result = commentService.postComment(paramMap);
			if(!SUCCESS.equals(result.get("result"))) {
				throw new Exception("????????? ????????? ?????????????????????.");
			}
			
			resultData.put("commentSeq", paramMap.get("commentSeq"));

		} catch (Exception e) {
			result.put("result", "ERROR");
			result.put("errMsg", e.getMessage());
			e.printStackTrace();
		}
		
		return result;
	}

	@RequestMapping(value = "/updateComment")
	@ResponseBody
	public Map<String, Object> putComment(@RequestParam Map<String, String> paramMap) {
		
		Map<String, Object> result = new HashMap<String, Object>();

		// parameter Setting
		try {

			String comment = paramMap.get("comment");
			
			// ?????? ?????? Data??? ?????? ??????
			if(CommonUtil.isEmptyString(comment)) {
				throw new Exception("????????? ?????? ?????? ????????????.");
			}
			
		} catch (Exception e) {
			result.put("result", "ERROR");
			result.put("errMsg", e.getMessage());
			e.printStackTrace();

			return result;
		}
		
		try {
			result = commentService.putComment(paramMap);
			if(!SUCCESS.equals(result.get("result"))) {
				throw new Exception("????????? ????????? ?????????????????????.");
			}
			
		} catch (Exception e) {
			result.put("result", "ERROR");
			result.put("errMsg", e.getMessage());
			e.printStackTrace();
		}
		
		return result;
	}

	@RequestMapping(value = "/deleteComment")
	@ResponseBody
	public Map<String, Object> deleteComment(@RequestParam Map<String, String> paramMap) {
		
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			result = commentService.deleteComment(paramMap);
			if(!SUCCESS.equals(result.get("result"))) {
				throw new Exception("????????? ????????? ?????????????????????.");
			}
			
		} catch (Exception e) {
			result.put("result", "ERROR");
			result.put("errMsg", e.getMessage());
			e.printStackTrace();
		}
		
		return result;
	}

}
