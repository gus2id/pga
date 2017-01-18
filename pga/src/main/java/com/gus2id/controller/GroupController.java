package com.gus2id.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class GroupController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/group")
	public String group(ModelMap modelMap) {
		List<Map<String, Object>> result = sqlSession.selectList("pga.user.selectUser");
		modelMap.addAttribute("member", result);
		return "group";
	}

	@RequestMapping("/group2")
	public String group2(String state, String gameId, ModelMap modelMap) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (state != null) {
			params.put("state", state);
		}
		if (!StringUtils.isEmpty(gameId)) {
			params.put("gameId", gameId);
			List<Map<String, Object>> groupMembers = sqlSession.selectList("pga.group.selectGroupMembers", params);
			modelMap.addAttribute("groupMembers", groupMembers);
		}
		
		List<Map<String, Object>> searchRegion = sqlSession.selectList("pga.user.selectRegion");
		List<Map<String, Object>> result = sqlSession.selectList("pga.user.selectUser", params);
		List<Map<String, Object>> games = sqlSession.selectList("pga.game.selectAllGame");
		List<Map<String, Object>> clubNames = sqlSession.selectList("pga.user.selectAllClub");
		modelMap.addAttribute("member", result);
		modelMap.addAttribute("games", games);
		modelMap.addAttribute("region", searchRegion);
		modelMap.addAttribute("clubNames", clubNames);
		return "group2";
	}
	
	@RequestMapping("/ajax/group")
	@ResponseBody
	public Map<String, Object> ajaxGroup(String gameId) {
		Map<String, Object> modelMap = new HashMap<>();
		Map<String, Object> params = new HashMap<String, Object>();
		if (!StringUtils.isEmpty(gameId)) {
			params.put("gameId", gameId);
			List<Map<String, Object>> groupMembers = sqlSession.selectList("pga.group.selectGroupMembers", params);
			modelMap.put("groupMembers", groupMembers);
		}
		
		List<Map<String, Object>> searchRegion = sqlSession.selectList("pga.user.selectRegion");
		List<Map<String, Object>> result = sqlSession.selectList("pga.user.selectUser", params);
		List<Map<String, Object>> games = sqlSession.selectList("pga.game.selectAllGame");
		modelMap.put("member", result);
		modelMap.put("games", games);
		modelMap.put("region", searchRegion);
		
		return modelMap;
	}
	
	@RequestMapping("/ajax/allclub")
	@ResponseBody
	public Map<String, Object> ajaxAllclub() {
		List<Map<String, Object>> clubNames = sqlSession.selectList("pga.user.selectAllClub");
		Map<String, Object> result = new HashMap<>();
		result.put("clubs", clubNames);
		return result;
	}
	
	@RequestMapping("/group/search")
	@ResponseBody
	public Map<String, Object> search(String region, String clubName, ModelMap modelMap) {
		modelMap.clear();
		Map<String, Object> params = new HashMap<String, Object>();
		if (!StringUtils.isEmpty(region)) {
			params.put("region", region);
		}
		if (!StringUtils.isEmpty(clubName)) {
			params.put("clubName", clubName);
		}
		List<Map<String, Object>> result = sqlSession.selectList("pga.user.selectUser", params);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("member", result);
		return resultMap;		
	}
	
	@RequestMapping("/group/save")
	@ResponseBody
	public void save(@RequestParam(required = false) String gameId, @RequestParam String gameName, @RequestParam String groupMembers) {
		Map<String, Object> params = new HashMap<>();
		if (StringUtils.isEmpty(gameId)) {
			params.put("gameName", gameName);
			sqlSession.insert("pga.game.insertGame", params);
		} else {
			params.put("gameId", gameId);
		}
		params.put("groupMembers", groupMembers);
		sqlSession.delete("pga.group.deleteGroupMembers", params);
		sqlSession.insert("pga.group.insertGroupMembers", params);
	}
	
	@RequestMapping("/namePlate")
	public String namePlate(@RequestParam String gameId, ModelMap modelMap) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("gameId", gameId);
		Map<String, Object> groupMembers = sqlSession.selectOne("pga.group.selectGroupMembers", params);
		modelMap.addAttribute("allMember", sqlSession.selectList("pga.user.selectUser", params));
		
		modelMap.addAttribute("groupMembers", groupMembers);
		
		List<Map<String, Object>> searchRegion = sqlSession.selectList("pga.user.selectRegion");
		Map<String, Object> game = sqlSession.selectOne("pga.game.selectGame", params);
		modelMap.addAttribute("game", game);
		modelMap.addAttribute("region", searchRegion);
		return "namePlate";
	}
	
	@RequestMapping("/mealTicket")
	public String mealTicket(@RequestParam String gameId, @RequestParam Integer count, ModelMap modelMap) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("gameId", gameId);
		// Map<String, Object> groupMembers = sqlSession.selectOne("pga.group.selectGroupMembers", params);
		// modelMap.addAttribute("count", groupMembers.get("group_members").toString().split(",").length + 10);
		modelMap.addAttribute("count", count);
		return "mealTicket";
	}

	@RequestMapping("/printTable")
	public String printTable(@RequestParam String gameId, ModelMap modelMap) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("gameId", gameId);
		Map<String, Object> groupMembers = sqlSession.selectOne("pga.group.selectGroupMembers", params);
		modelMap.addAttribute("members", groupMembers);
		modelMap.addAttribute("allMember", sqlSession.selectList("pga.user.selectUser", params));
		return "printTable";
	}
	
	@RequestMapping("/user/add")
	public void addUser(@RequestParam Map<String, Object> map) {
		@SuppressWarnings("unused")
		Integer memberSeq = sqlSession.selectOne("pga.user.selectMaxMemberSeq");
		map.put("memberSeq", memberSeq);
		sqlSession.insert("pga.user.insertUser", map);
	}
	
	@RequestMapping("/user/disabled")
	@ResponseBody
	public void userDisable(Integer userSeq) {
		sqlSession.update("pga.user.updateDisableUser", userSeq);
	}
	
	@RequestMapping("/user/enabled")
	@ResponseBody
	public void userEnable(Integer userSeq) {
		sqlSession.update("pga.user.updateEnableUser", userSeq);
	}
	
	@RequestMapping("/user/getDisabledMember")
	@ResponseBody
	public Map<String, Object> getDisabledMember(ModelMap modelMap) {
		Map<String, Object> result = new HashMap<>();
		result.put("disabledMember", sqlSession.selectList("pga.user.selectDisableMember"));
		return result;
	}
}
