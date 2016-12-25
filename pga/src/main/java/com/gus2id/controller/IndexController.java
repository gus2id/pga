package com.gus2id.controller;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(path = {"/test", "/"})
	public String index(ModelMap modelMap) {
		List<Map<String, Object>> result = sqlSession.selectList("pga.user.selectUser");
		modelMap.addAttribute("memberCount", result.size());
		return "index";
	}
}
