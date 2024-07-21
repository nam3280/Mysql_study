import dao.Connect;
import service.crudDB;
import vo.Board;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class BoardExample {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        Connect connect = new Connect();
        crudDB crudDB = new crudDB();
        Board board = new Board();

        boolean stopBoard = true;
        while (stopBoard) {
            try {
                if (connect.setConnection(connect.getConnection())) {
                    System.out.println("[게시물 목록]");
                    System.out.println("--------------------------------------------------");
                    System.out.println("no\t\twriter\t\t\tdate\t\t\t\ttitle");
                    System.out.println("--------------------------------------------------");
                    crudDB.showDB(connect.getConnection());
                    System.out.println("--------------------------------------------------");
                    System.out.println("메인 메뉴 : 1. Create | 2. Read | 3. Clear | 4. Exit");
                    System.out.print("메뉴 선택: ");
                    int selectMenu = Integer.parseInt(br.readLine());

                    switch (selectMenu) {
                        case 1:
                            System.out.print("제목 : ");
                            board.setBtitle(br.readLine());
                            System.out.print("내용 : ");
                            board.setBcontent(br.readLine());
                            System.out.print("작성자 : ");
                            board.setBwriter(br.readLine());

                            if (crudDB.create(connect.getConnection(), board))
                                System.out.println("입력 성공");
                            else
                                System.out.println("입력 실패");
                            break;
                        case 2:
                            System.out.println("[게시물 읽기]");
                            System.out.print("bno : ");
                            board.setBno(Integer.parseInt(br.readLine()));
                            if (crudDB.read(connect.getConnection(), board.getBno())) {
                                System.out.println("보조 메뉴 : 1. Update | 2. Delete | 3. List");
                                switch (Integer.parseInt(br.readLine())) {
                                    case 1:
                                        System.out.println("[수정 내용 입력]");
                                        System.out.print("제목 : ");
                                        board.setBtitle(br.readLine());
                                        System.out.print("내용 : ");
                                        board.setBcontent(br.readLine());
                                        System.out.print("작성자 : ");
                                        board.setBwriter(br.readLine());
                                        System.out.println("--------------------------------------------------");
                                        System.out.println("보조 메뉴 : 1. OK | 2. Cancel");
                                        System.out.print("메뉴 선택 : ");
                                        if (Integer.parseInt(br.readLine()) == 1)
                                            crudDB.update(connect.getConnection(), board);
                                        break;
                                    case 2:
                                        crudDB.delete(connect.getConnection(), board.getBno());
                                        break;
                                    default:
                                        break;
                                }
                            }
                            break;
                        case 3:
                            System.out.println("보조 메뉴 : 1. OK | 2. Cancel");
                            System.out.print("메뉴 선택 : ");
                            if (Integer.parseInt(br.readLine()) == 1)
                                crudDB.deleteAll(connect.getConnection());
                            break;
                        case 4: stopBoard = false; break;
                        default: break;
                    }
                }
            } catch (IOException e) {
                System.out.println("에러");
            } catch (NumberFormatException e) {
                System.out.println("메뉴 선택을 하세요.");
            }
        }
    }
}


