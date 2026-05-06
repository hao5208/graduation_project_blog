package com.lh.blog.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.lh.blog.pojo.Comments;
import com.lh.blog.service.CommentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  评论
 *  前端控制器
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
@Controller
@RequestMapping("/comments")
public class CommentsController {
    @Autowired
    private CommentsService service;


    @RequestMapping("/getcomments")
    public String queryCommentsByPage(@RequestParam(value = "curr",defaultValue = "1") int curr, HttpServletRequest request) {
        Map<String, Object> map = service.queryCommentsByPage(curr);
        request.setAttribute("pages",map.get("pages"));
        request.setAttribute("counts",map.get("counts"));
        request.setAttribute("curr",curr);
        request.setAttribute("records",(List)(map.get("records")));
        return "comments";
    }

    @RequestMapping("/getcidComments")
    public String queryCidCommentsByPage(@RequestParam(value = "cid") int cid, HttpServletRequest request) {
        List<Comments> cs=service.list(new QueryWrapper<Comments>().eq("cid",cid));
        request.setAttribute("records",cs);
       return "cidcomments";
    }

    @RequestMapping("/getusercomments")
    public String queryUserCommentsByPage(@RequestParam(value = "curr",defaultValue = "1") int curr, HttpServletRequest request) {
        Map<String, Object> map = service.queryUserCommentsByPage(curr, (String) request.getSession().getAttribute("username"));
        request.setAttribute("pages",map.get("pages"));
        request.setAttribute("counts",map.get("counts"));
        request.setAttribute("curr",curr);
        request.setAttribute("records",(List)(map.get("records")));
        return "usercomments";
    }

    /**
     * 添加评论
     * @param comments
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public String insert(@RequestBody Comments comments){

       // System.out.println(comments);

        //设置评论时间为系统时间
        comments.setCreated(new Date());
        //设置coid为1，自动递增
        comments.setCoid(1);
        //评论状态默认显示1
        comments.setStatus(1);
        return service.save(comments)?"success":"error";
    }


    /**
     * 更新评论
     * @param
     * @return
     */
    @PostMapping("/update")
    @ResponseBody
    public String update(@RequestBody Comments comments){
        return service.updateById(comments)?"success":"error";
    }

    /**
     * 更新状态
     * @param
     * @return
     */
    @PostMapping("/updatestatic")
    @ResponseBody
    public String updatestatic(@RequestBody Comments comments){
        if (comments.getStatus()==0){
            comments.setStatus(1);
            return service.updateById(comments)?"success":"error";
        }else {
            comments.setStatus(0);
            return service.updateById(comments)?"success":"error";
        }

    }



    @RequestMapping("/delete/{coid}")
    @ResponseBody
    public String delete(@PathVariable("coid") int coid){
        return service.removeById(coid)?"success":"error";
    }

    @RequestMapping("/delcids")
    @ResponseBody
    public String delcids(@RequestBody List<Integer> coids){
        System.out.println(coids);
       // service.removeByIds(coids);

        return service.removeByIds(coids)?"success":"error";
    }


}

