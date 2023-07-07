package com.stagemate.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.stagemate.member.model.vo.Member;

public interface AdminDao2 {
	List<Member> listMember2(SqlSession session,int cPage,int numPerpage);
	
	int selectMemberCount(SqlSession session);
}
