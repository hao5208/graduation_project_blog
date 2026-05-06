package com.lh.blog.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.lh.blog.pojo.Comments;
import com.lh.blog.pojo.Contents;
import com.lh.blog.service.ContentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
@Controller
@RequestMapping("/contents")
public class ContentsController {
    @Autowired
    private ContentsService service;

    @RequestMapping("/getcontents")
    public String queryContentsByPage(@RequestParam(value = "curr",defaultValue = "1") int curr, HttpServletRequest request) {
        Map<String, Object> map = service.querycontentsByPage(curr);
        request.setAttribute("pages",map.get("pages"));
        request.setAttribute("counts",map.get("counts"));
        request.setAttribute("curr",curr);
        request.setAttribute("records",(List)(map.get("records")));
        return "contents";
    }

//根据用户id查文章
    @RequestMapping("/getusercontents")
    public String queryUserContentsByPage(@RequestParam(value = "curr",defaultValue = "1") int curr, HttpServletRequest request) {
//        System.out.println("----------------------------00");
        //System.out.println(request.getSession().getAttribute("userid"));
        int userid= (int) request.getSession().getAttribute("userid");
//        System.out.println(userid);
        Map<String, Object> map = service.queryusercontentsByPage(curr,userid);
        request.setAttribute("pages",map.get("pages"));
        request.setAttribute("counts",map.get("counts"));
        request.setAttribute("curr",curr);
        request.setAttribute("records",(List)(map.get("records")));
        return "usercontents";
    }

    @PostMapping("/add")
    @ResponseBody
    public String insert(@RequestBody Contents contents){
        contents.setCreated(new Date());
        contents.setModified(new Date());
        contents.setReadingcount(0);
        contents.setStatus(1);
    return  service.save(contents)?"success":"error";
    }

    @PostMapping("/update")
    @ResponseBody
    public String update(@RequestBody Contents contents){
        contents.setModified(new Date());
       return service.updateById(contents)?"success":"error";
    }

    @PostMapping("/updatestatic")
    @ResponseBody
    public String updatestatic(@RequestBody Contents contents){
        if (contents.getStatus()==0){
            contents.setStatus(1);
            return service.updateById(contents)?"success":"error";
        }else {
            contents.setStatus(0);
            return service.updateById(contents)?"success":"error";
        }

    }



    @RequestMapping("/delete/{cid}")
    @ResponseBody
    public String delete(@PathVariable("cid") int cid){
        return service.removeById(cid)?"success":"error";
    }

    @RequestMapping("/delcids")
    @ResponseBody
    public String delcids(@RequestBody List<Integer> cids){
//        System.out.println(cids);
        // service.removeByIds(cids);

        return service.removeByIds(cids)?"success":"error";
    }
    //更新文章
    @RequestMapping("/updatesel/{cid}")
    public String updatesel(@PathVariable("cid") int cid, HttpServletRequest request){
       Contents cs= service.queryConByCid(cid);
        request.setAttribute("con",cs);
        return "setcontent";
    }

    //类别id查文章
    @RequestMapping("/getcontentByMid/{mid}")
    public String querycontentByMid(@PathVariable("mid") int mid, HttpServletRequest request) {
        request.setAttribute("contents",service.queryConByType(mid));
        return "selcontents";
    }

    //用户id查文章
    @RequestMapping("/getcontentByUid/{uid}")
    public String querycontentByUid(@PathVariable("uid") int uid, HttpServletRequest request) {
        request.setAttribute("contents",service.queryConByUser(uid));
        System.out.println("-------------------------------------------------------------------");
        System.out.println(service.queryConByUser(uid));
        return "selcontents";
    }

    /**
     * 标题模糊查询文章
     * @param title
     * @param request
     * @return
     */
    @RequestMapping("/selcontentlike")
    public String queryContentsBylike(@RequestParam(value = "title") String title, HttpServletRequest request) {
//        Map<String, Object> map = service.querycontentsByPage(curr);

        request.setAttribute("contents",service.query().like("title",title).list());
//        request.setAttribute("pages",map.get("pages"));
//        request.setAttribute("counts",map.get("counts"));
//        request.setAttribute("curr",curr);
//        request.setAttribute("records",(List)(map.get("records")));
        return "selcontents";
    }
}

