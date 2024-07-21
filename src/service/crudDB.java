package service;

import vo.Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class crudDB{
    static ResultSet rs = null;
    static PreparedStatement pstmt = null;

    public void showDB(Connection con){
        String query = "SELECT * FROM boardField";
        try {
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                System.out.println(rs.getInt("bno") + "\t\t\t\t"
                        + rs.getString("bwriter") + "\t\t\t"
                        + rs.getString("bdate") + "\t\t\t"
                        + rs.getString("btitle"));
            }
        } catch (SQLException e) {
            return;
        }
    }

    public boolean create(Connection con, Board board) {
        if(board.getBtitle().isEmpty() || board.getBwriter().isEmpty() || board.getBcontent().isEmpty()) {
            System.out.println("글을 쓰세요.");
            return false;
        }

        Date date = new Date();

        String query = "INSERT INTO boardField(btitle,bcontent,bwriter,bdate)"
                + "VALUES(?,?,?,?)";
        try {
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, board.getBtitle());
            pstmt.setString(2, board.getBcontent());
            pstmt.setString(3, board.getBwriter());
            board.setBdateDB(date);
            pstmt.setString(4, board.getBdate());

            pstmt.executeUpdate();

            close(con);
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public boolean read(Connection con, int bno) {
        String query = "SELECT * FROM boardField WHERE bno = " + bno;
        try {
            pstmt = con.prepareStatement(query);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                do {
                    System.out.println("##############################################");
                    System.out.println("번호 : " + rs.getString("bno"));
                    System.out.println("제목 : " + rs.getString("btitle"));
                    System.out.println("내용 : " + rs.getString("bcontent"));
                    System.out.println("작성자 : " + rs.getString("bwriter"));
                    System.out.println("날짜 : " + rs.getString("bdate"));
                    System.out.println("##############################################");
                } while (rs.next());
            }
            else{
                close(con);
                return false;
            }
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public void update(Connection con, Board board){
        String query = new StringBuilder().append("UPDATE boardField SET ")
                .append("btitle = ? ,")
                .append("bcontent = ? ,")
                .append("bwriter = ? ")
                .append("WHERE bno = ")
                .append(board.getBno()).toString();
        try {
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, board.getBtitle());
            pstmt.setString(2, board.getBcontent());
            pstmt.setString(3, board.getBwriter());

            pstmt.executeUpdate();

            close(con);
        } catch (SQLException e){
            return;
        }
    }

    public void delete(Connection con, int bno){
        String query = "DELETE FROM boardField WHERE bno = " + bno;
        try {
            pstmt = con.prepareStatement(query);
            pstmt.executeUpdate();
            close(con);
        } catch (SQLException e){
            return ;
        }
    }

    public void deleteAll(Connection con){
        String query = "TRUNCATE TABLE boardField";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.executeUpdate();
            close(con);
        } catch (SQLException e){
            System.out.println("실패");
        }
    }

    public static void close(Connection con) throws SQLException {
        pstmt.close();
        rs.close();
        con.close();
    }
}
