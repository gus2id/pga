package com.gus2id.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GameController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/gameResult")
	public String gameResult(Integer gameId, ModelMap modelMap) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("gameId", gameId);
		List<Map<String, Object>> games = sqlSession.selectList("pga.game.selectAllGame");
		List<Map<String, Object>> members = sqlSession.selectList("pga.user.selectUser", params);
		modelMap.addAttribute("games", games);
		modelMap.addAttribute("members", members);
		return "gameResult";
	}
}
