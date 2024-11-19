package com.example.jsp_file.dao;

import com.example.jsp_file.bean.BoardVO;
import com.example.jsp_file.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    Connection conn = null;
    PreparedStatement stmt = null;


    String board_insert = "insert into board (title, writer, content) values (?,?,?)";
    String board_update = "update board set title=?, writer=?, content=? where seq=?";
    String board_delete = "delete from board where seq=?";
    String board_get = "select * from board where seq=?";
    String board_list = "select * from board order by seq desc";

    public int insertBoard(BoardVO vo) {
        int result = 0;
        try {
            conn = JDBCUtil.getConnection();
            if (conn == null) {
                System.out.println("DB 연결 오류!");
                return 0;
            }

            System.out.println("===> JDBC로 insertBoard() 기능 처리");
            stmt = conn.prepareStatement(board_insert);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn); // 연결 해제
        }
        return result;
    }

    public List<BoardVO> getBoardList() {
        List<BoardVO> boardList = new ArrayList<>();
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(board_list);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setId(rs.getInt("seq"));  // seq는 id로 매핑
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setCnt(rs.getInt("cnt"));
                board.setRegdate(rs.getTimestamp("regdate"));
                boardList.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return boardList;
    }

    public BoardVO getBoard(int seq) {
        BoardVO board = null;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(board_get);
            stmt.setInt(1, seq);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                board = new BoardVO();
                board.setId(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setCnt(rs.getInt("cnt"));
                board.setRegdate(rs.getTimestamp("regdate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return board;
    }

    public int updateBoard(BoardVO vo) {
        int result = 0;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(board_update);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setInt(4, vo.getId());
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return result;
    }

    public int deleteBoard(int seq) {
        int result = 0;
        String sql = "DELETE FROM board WHERE seq = ?";
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, seq);
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return result;
    }
}
