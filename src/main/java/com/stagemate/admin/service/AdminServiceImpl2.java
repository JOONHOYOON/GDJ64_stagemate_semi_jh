package com.stagemate.admin.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.stagemate.admin.model.dao.AdminDao2;
import com.stagemate.admin.model.dao.AdminDaoImpl2;
import com.stagemate.member.model.vo.Member;
import static com.stagemate.common.SessionTemplate.getSession;

public class AdminServiceImpl2 implements AdminService2 {
	private AdminDao2 dao=new AdminDaoImpl2();

	@Override
	public List<Member> listMember2(int cPage, int numPerpage) {
		SqlSession session=getSession();
		List<Member> members=dao.listMember2(session, cPage, numPerpage);
		session.close();
		return members;
	}
	
	@Override
	public int selectMemberCount() {
		SqlSession session=getSession();
		int count=dao.selectMemberCount(session);
		session.close();
		return count;
	}

}
