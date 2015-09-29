package sdu.edu.scene.dto;

/**
 * Created by yuechenglei on 2015/9/15.
 */
public class ListBean {
    int id;
    String title;
    String content;

    public void setContent(String content) {
        this.content = content;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {

        return content;
    }

    public String getTitle() {
        return title;
    }

    public int getId() {

        return id;
    }

    public ListBean(int id, String title, String content) {
        this.id = id;

        this.title = title;
        this.content = content;
    }
}
