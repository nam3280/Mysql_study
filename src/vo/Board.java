package vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Board {
  private int bno;
  private String btitle;
  private String bcontent;
  private String bwriter;
  private String bdate;

  public int getBno() {
    return bno;
  }

  public String getBtitle() {
    return btitle;
  }

  public String getBcontent() {
    return bcontent;
  }

  public String getBwriter() {
    return bwriter;
  }

  public String getBdate() {
    return bdate;
  }

  public void setBdateDB(Date bdate) {
    SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/d");

    this.bdate = date.format(bdate);
  }

  public void setBno(int bno) {
    this.bno = bno;
  }

  public void setBtitle(String btitle) {
    this.btitle = btitle;
  }

  public void setBcontent(String bcontent) {
    this.bcontent = bcontent;
  }

  public void setBwriter(String bwriter) {
    this.bwriter = bwriter;
  }
}
