package com.stagemate.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.stagemate.member.model.vo.Member;

public class AdminDaoImpl2 implements AdminDao2 {

	@Override
	public List<Member> listMember2(SqlSession session, int cPage, int numPerpage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("admin.searchMember",null,rb);
	}
	@Override
	public int selectMemberCount(SqlSession session) {
		return session.selectOne("admin.selectMemberCount");
	}

}
