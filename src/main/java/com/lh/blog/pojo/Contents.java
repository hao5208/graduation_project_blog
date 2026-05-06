package com.lh.blog.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * <p>
 * 
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@EqualsAndHashCode(callSuper = false)
@TableName("contents")
public class Contents implements Serializable {

    private static final long serialVersionUID = 1L;
    @TableId(value = "cid",type = IdType.AUTO)
      private Integer cid;

    private String title;

    private String text;

    private Integer type;

    private Integer uid;
    @JsonFormat(pattern ="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date created;
    @JsonFormat(pattern ="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date modified;

    private Integer readingcount;

    private Integer status;
    @TableField(exist = false)
    private Types types;
    @TableField(exist = false)
    private Users users;

    public Contents(String title, String text, Integer type, Integer uid, Date created, Date modified, Integer readingcount, Integer status) {
        this.title = title;
        this.text = text;
        this.type = type;
        this.uid = uid;
        this.created = created;
        this.modified = modified;
        this.readingcount = readingcount;
        this.status = status;
    }

    public Contents(Integer cid, Integer readingcount) {
        this.cid = cid;
        this.readingcount = readingcount;
    }
}
