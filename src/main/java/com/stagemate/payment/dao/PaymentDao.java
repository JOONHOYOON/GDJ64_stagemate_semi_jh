package com.stagemate.payment.dao;

import static com.stagemate.common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.stagemate.common.PropertiesGenerator;
import com.stagemate.event.model.vo.Seat;
import com.stagemate.payment.model.vo.EventOrder;
import com.stagemate.payment.model.vo.Payment;
import com.stagemate.payment.model.vo.PrdOrder;
import com.stagemate.payment.model.vo.PrdOrderDetail;
import com.stagemate.store.dao.StoreDao;

public class PaymentDao {
	
	String path=StoreDao.class.getResource("/sql/payment/payment.properties").getPath();
	private final Properties sql;
	
	public PaymentDao() {
		sql = PropertiesGenerator.by(path);
	}
	
	private EventOrder getEventOrder(ResultSet rs) throws SQLException{
		return EventOrder.builder()
			.rsvNo(rs.getString("RSV_NO"))
			.esNo(rs.getString("ES_NO"))
			.rsvDate(rs.getDate("RSV_DATE"))
			.rsvPrice(rs.getInt("RSV_PRICE"))
			.memberId(rs.getString("MEMBER_ID"))
			.paymentNo(rs.getString("PAYMENT_NO"))
			.orderStatus(rs.getString("ORDER_STATUS"))
			.build();
			
	}
	
	private Seat getSeat(ResultSet rs) throws SQLException {
		return Seat.builder()
				.seatNo(rs.getString("SEAT_NO"))
				.isReserved(rs.getString("IS_RESERVED").charAt(0))
				.slvNo(rs.getString("SLV_NO"))
				.seatRow(rs.getString("SEAT_ROW").charAt(0))
				.seatCol(rs.getInt("SEAT_COL"))
				.eventNo(rs.getString("EVENT_NO"))
				.build();
	}
	
	public int insertPayment(Connection conn,Payment p) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertPayment"));
			pstmt.setString(1, p.getPaymentNo());
			pstmt.setInt(2, p.getPaymentPrice());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public int insertEventOrder(Connection conn,EventOrder eo) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertEventOrder"));
			pstmt.setString(1, eo.getEsNo());
			pstmt.setInt(2, eo.getRsvPrice());
			pstmt.setString(3, eo.getMemberId());
			pstmt.setString(4, eo.getPaymentNo());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public int updateMusicalSeatRes(Connection conn,String row,int col,String eventNo,String choiceday) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateMusicalSeatRes"));
			pstmt.setString(1, eventNo);
			pstmt.setString(2, choiceday);
			pstmt.setString(3, row);
			pstmt.setInt(4, col);
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	public int updateActSeatRes(Connection conn,String row,int col,String eventNo,String choiceday) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateActSeatRes"));
			pstmt.setString(1, eventNo);
			pstmt.setString(2, choiceday);
			pstmt.setString(3, row);
			pstmt.setInt(4, col);
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	public int updateConcertSeatRes(Connection conn,String row,int col,String eventNo,String choiceday) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateConcertSeatRes"));
			pstmt.setString(1, eventNo);
			pstmt.setString(2, choiceday);
			pstmt.setString(3, row);
			pstmt.setInt(4, col);
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public EventOrder selectEventOrder(Connection conn,String paymentNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		EventOrder eventOrder=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectEventOrder"));
			pstmt.setString(1, paymentNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				eventOrder=getEventOrder(rs);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return eventOrder;
	}
	
	public Seat selectMusicalSeatNo(Connection conn,String row,int col,String eventNo,String esNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Seat seat=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectMusicalSeatNo"));
			pstmt.setString(1, eventNo);
			pstmt.setString(2, row);
			pstmt.setInt(3, col);
			pstmt.setString(4, esNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				seat=getSeat(rs);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return seat;
	}
	public Seat selectActSeatNo(Connection conn,String row,int col,String eventNo,String esNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Seat seat=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectActSeatNo"));
			pstmt.setString(1, eventNo);
			pstmt.setString(2, row);
			pstmt.setInt(3, col);
			pstmt.setString(4, esNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				seat=getSeat(rs);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return seat;
	}
	public Seat selectConcertSeatNo(Connection conn,String row,int col,String eventNo,String esNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Seat seat=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectConcertSeatNo"));
			pstmt.setString(1, eventNo);
			pstmt.setString(2, row);
			pstmt.setInt(3, col);
			pstmt.setString(4, esNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				seat=getSeat(rs);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return seat;
	}
	
	public int insertEventOrderDetail(Connection conn,String rsvNo,String seatNo) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertEventOrderDetail"));
			pstmt.setString(1, rsvNo);
			pstmt.setString(2, seatNo);
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int insertPrdOrder(Connection conn, PrdOrder po) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertPrdOrder"));
			pstmt.setString(1, po.getDlvId());
			pstmt.setString(2, po.getPaymentNo());
			pstmt.setString(3, po.getMemberId());
			pstmt.setString(4, po.getShipMsg());
			pstmt.setInt(5, po.getTotalPrice());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int insertPrdOrderDetail(Connection conn, PrdOrderDetail pod) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertPrdOrderDetail"));
			pstmt.setString(1, pod.getOrderNo());
			pstmt.setInt(2, pod.getProductNo());
			pstmt.setInt(3, pod.getOrderAmt());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public String selectOrderNo(Connection conn) {
		 PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String orderNo = null;
		    try {
		        pstmt = conn.prepareStatement(sql.getProperty("selectOrderNo"));
		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		            orderNo = rs.getString("order_no");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        close(rs);
		        close(pstmt);
		    }
		    return orderNo;
	}

	public PrdOrder selectPrdOrderByOrderNo(Connection conn, String orderNo) {
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 PrdOrder po = null;
		 System.out.println("dao에서 출력하는 orderNo:"+orderNo);
		    try {
		        pstmt = conn.prepareStatement(sql.getProperty("selectPrdOrderByOrderNo"));
		        pstmt.setString(1, orderNo);
		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		        	po=getPrdOrder(rs);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        close(rs);
		        close(pstmt);
		    }
		    return po;
	}

	private PrdOrder getPrdOrder(ResultSet rs) throws SQLException {
		return PrdOrder.builder()
        		.orderNo(rs.getString("ORDER_NO"))
        		.dlvId(rs.getString("DLV_ID"))
        		.paymentNo(rs.getString("PAYMENT_NO"))
        		.memberId(rs.getString("MEMBER_ID"))
        		.shipMsg(rs.getString("SHIP_MSG"))
        		.totalPrice(rs.getInt("TOTAL_PRICE"))
        		.orderStatus(rs.getString("ORDER_STATUS"))
        		.orderDate(rs.getDate("ORDER_DATE"))
        		.build();
	}
	
	
}
