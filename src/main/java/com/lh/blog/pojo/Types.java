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
@TableName("types")
public class Types implements Serializable {

    private static final long serialVersionUID = 1L;
    @TableId(value = "mid",type = IdType.AUTO)
      private Integer mid;

    private String name;

    private String description;

    private Integer parent;


}
