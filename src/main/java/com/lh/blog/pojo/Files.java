package com.lh.blog.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;

import lombok.*;

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
@TableName("files")
public class Files implements Serializable {

    private static final long serialVersionUID = 1L;
    @TableId(value = "fid",type = IdType.AUTO)
      private Integer fid;

    private String name;

    private String type;

    private Integer uid;

    private String link;

    private Users users;

    public Files(String name, String type, Integer uid, String link) {
        this.name = name;
        this.type = type;
        this.uid = uid;
        this.link = link;
    }
}
