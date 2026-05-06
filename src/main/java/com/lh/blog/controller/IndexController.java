package com.lh.blog.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.lh.blog.pojo.Comments;
import com.lh.blog.pojo.Contents;
import com.lh.blog.service.CommentsService;
import com.lh.blog.service.ContentsService;
import com.lh.blog.service.TypesService;
import com.lh.blog.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/index")
public class IndexController {
    @Autowired
    private ContentsService conService;
    @Autowired
    private CommentsService comService;
    @Autowired
    private TypesService typeService;
    @Autowired
    private UsersService usersService;
    @RequestMapping("/getindex")
    @ResponseBody
    public Map<String, Object> queryContentsByPage(@RequestParam(value = "curr",defaultValue = "1") int curr, HttpServletRequest request) {
        Map<String, Object> map = conService.querycontentsByPageIndex(curr);
        map.put("newContent",conService.queryNewcontentsByPage(1));
        map.put("newComment",comService.queryNewCommentsByPage(1));
        map.put("types",typeService.list());
        return map;
    }

    @RequestMapping("/getcontent/{cid}")

    public String queryContentBy(@PathVariable("cid") int cid, HttpServletRequest request) {
        //System.out.println(cid);
        //comService.updateById();
        //查文章
        Contents con=conService.queryConByCid(cid);
        conService.updateById(new Contents(cid,con.getReadingcount()+1));
        request.setAttribute("content",con);
        //查文章评论
//        System.out.println(comService.queryAllByCid(cid));
        request.setAttribute("comment",comService.queryAllByCid(cid));
        //查文章上一篇，下一篇
        request.setAttribute("shang",conService.queryUpConByCid(cid));
        request.setAttribute("xia",conService.queryDuConByCid(cid));


        return "archives";
    }

    @RequestMapping("/getcount")
    @ResponseBody
    public Map<String, Object> querygetcount(HttpServletRequest request) {
        Map<String, Object> map =new HashMap<>();

        map.put("comcount",comService.count());
        map.put("comdaycount",comService.queryDayCount());

        map.put("usercount",usersService.count());
        map.put("userdaycount",usersService.queryDayCount());

        map.put("concount",conService.count());
        map.put("condaycount",conService.queryDayCount());


        map.put("redcount",conService.queryRedCount());
//        map.put("reddaycount",conService.queryDayRedCount());
        return map;
    }
}
