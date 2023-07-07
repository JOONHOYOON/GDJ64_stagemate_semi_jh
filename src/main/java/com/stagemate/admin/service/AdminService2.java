package com.stagemate.admin.service;

import java.util.List;

import com.stagemate.member.model.vo.Member;

public interface AdminService2 {
	
	List<Member> listMember2(int cPage,int numPerpage);	
	int selectMemberCount();

}
