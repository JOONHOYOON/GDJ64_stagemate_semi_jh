package com.stagemate.deliveryAddress.dao;

import static com.stagemate.common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.stagemate.common.AESEncryptor;
import com.stagemate.common.PropertiesGenerator;
import com.stagemate.deliveryAddress.model.vo.DlvAdress;


public class DlvAddressDao {
	String path=DlvAddressDao.class.getResource("/sql/dlv/dlvsql.properties").getPath();
	private final Properties sql;
	
	public DlvAddressDao() {
		sql = PropertiesGenerator.by(path);
	}

	public List<DlvAdress> selectDlvAddressById(Connection conn, String memberId) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<DlvAdress> dlvList=new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectDlvAddressById"));
			pstmt.setString(1, memberId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				dlvList.add(getDlv(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		System.out.println(dlvList);
		return dlvList;
	}

	private DlvAdress getDlv(ResultSet rs) throws SQLException {
		String phone = rs.getString("dlv_phone");
		
		try {
			phone = AESEncryptor.decrypt(rs.getString("dlv_phone"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return  DlvAdress.builder()
					.dlvId(rs.getString("dlv_id"))
					.memberId(rs.getString("member_id"))
					.dlvPerson(rs.getString("dlv_person"))
					.dlvNm(rs.getString("dlv_nm"))
					.dlvPhone(phone)
					.dlvAddress(rs.getString("dlv_address"))
					.isDefaultDlv(rs.getString("is_default_dlv").charAt(0))
					.build();
	}

	public int insertDlvAddress(Connection conn, DlvAdress newAddress, int seqNo) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertDlvAddress"));
			pstmt.setString(1, "DLV_"+seqNo+"_"+newAddress.getMemberId());
			pstmt.setString(2, newAddress.getMemberId());
			pstmt.setString(3, newAddress.getDlvPerson());
			pstmt.setString(4, newAddress.getDlvNm());
			pstmt.setString(5, AESEncryptor.encrypt(newAddress.getDlvPhone()));
			pstmt.setString(6, newAddress.getDlvAddress());
			pstmt.setString(7, String.valueOf(newAddress.getIsDefaultDlv()));
			result=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int selectDlvSeqNo(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int seqNo=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectDlvSeqNo"));
			rs=pstmt.executeQuery();
			if(rs.next()) {
				seqNo=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return seqNo;
	}

	public DlvAdress selectDlvAddressByDlvId(Connection conn, String dlvId) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		DlvAdress d=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectDlvAddressByDlvId"));
			pstmt.setString(1, dlvId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				d=getDlv(rs);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return d;
	}

	public int updateDlvAddress(Connection conn, DlvAdress newAddress, String dlvId) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateDlvAddress"));
			pstmt.setString(1, newAddress.getMemberId());
			pstmt.setString(2, newAddress.getDlvPerson());
			pstmt.setString(3, newAddress.getDlvNm());
			pstmt.setString(4, AESEncryptor.encrypt(newAddress.getDlvPhone()));
			pstmt.setString(5, newAddress.getDlvAddress());
			pstmt.setString(6, String.valueOf(newAddress.getIsDefaultDlv()));
			pstmt.setString(7, dlvId);
			result=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteDlvAddress(Connection conn, String dlvId) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("deleteDlvAddress"));
			pstmt.setString(1, dlvId);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	
	
}
