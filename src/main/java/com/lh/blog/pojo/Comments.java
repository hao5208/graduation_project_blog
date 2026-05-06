package com.lh.blog.pojo;

import com.baomidou.mybatisplus.annotation.*;

import java.util.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.io.Serializable;

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
@TableName("comments")
public class Comments implements Serializable {

    private static final long serialVersionUID = 1L;
    @TableId(value = "coid",type = IdType.AUTO)
      private Integer coid;

    private Integer cid;

    private String name;

    private String mail;
//    @TableField(exist = false)
    private String text;
//    @TableField(exist = false)

//    @TableField(value = "create_time", fill = FieldFill.INSERT)

    //@Getter
    @JsonFormat(pattern ="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
  // @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date created;
//    private Timestamp created;
    private Integer status;
    @TableField(exist = false)
    private Contents contents;
//
//private String title;

    public Comments(Integer cid, String name, String mail, String text, Date created, Integer status) {
        this.cid = cid;
        this.name = name;
        this.mail = mail;
        this.text = text;
        this.created = created;
        this.status = status;
    }

    /**
     * 修改状态
     * @param coid
     * @param status
     */
    public Comments(Integer coid, Integer status) {
        this.coid = coid;
        this.status = status;
    }
}
