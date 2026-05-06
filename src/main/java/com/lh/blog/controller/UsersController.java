package com.lh.blog.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lh.blog.pojo.Contents;
import com.lh.blog.pojo.Types;
import com.lh.blog.pojo.Users;
import com.lh.blog.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
@Controller
@RequestMapping("/users")
public class UsersController {
    int pagesize=10;

    @Autowired
    private UsersService service;

    @RequestMapping("/login")
//    @ResponseBody
    public String login(Users user, HttpServletRequest request, HttpSession session) {
        int res=service.login(user);
        System.out.println(user);
        if (res==3){
            Users uuu=service.seluser(user.getUsername());
            //用户名
            session.setAttribute("username",uuu.getUsername());
            //用户id
            session.setAttribute("userid",uuu.getUid());
            //用户邮箱
            session.setAttribute("mail",uuu.getMail());
            //用户组
            session.setAttribute("ugroup",uuu.getUgroup());

            return "index";
        }else if (res==1){
            request.setAttribute("msg","无此账户");
            return "error";
        }else if (res==0){
            request.setAttribute("msg","账户已被封禁，禁止登录");
            return "error";
        }else{
            request.setAttribute("msg","密码错误");
            return "error";
        }


    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "index";
    }
    @RequestMapping("/adminlogin")
//    @ResponseBody
    public String adminlogin(Users user, HttpServletRequest request, HttpSession session) {
        int res=service.login(user);
        System.out.println(user);
        if (res==3){
            session.setAttribute("username",user.getUsername());
            return "index";
        }else if (res==1){
            request.setAttribute("msg","无此账户");
            return "error";
        }else{
            request.setAttribute("msg","密码错误");
            return "error";
        }


    }


    @RequestMapping("/getusers")
    public String queryUsersByPage(@RequestParam(value = "curr", defaultValue = "1") int curr, HttpServletRequest request)
    {
        Page<Users> p=new Page<>(curr,pagesize);
        IPage<Users> info =service.getBaseMapper().selectPage(p,null);
        request.setAttribute("pages",info.getPages());
        request.setAttribute("counts",info.getTotal());
        request.setAttribute("curr", curr);
        request.setAttribute("records",info.getRecords() );
        return "users";
    }
    @PostMapping("/add")
    @ResponseBody
    public String addUser(@RequestBody Users users) {
        if (users.getUgroup()==""){
            users.setUgroup("user");
        }
        users.setCreated(new Date());
        users.setActivated(new Date());
        users.setStatus(1);
        return service.save(users)?"success":"error";
    }

    @RequestMapping("/addsel/{username}")
    @ResponseBody
    public String addsel(@PathVariable("username") String username) {
        int ucount=service.query().eq("username",username).list().size();
        return ucount==0?"success":"error";
    }

    @PostMapping("/update")
    @ResponseBody
    public String updateUser(@RequestBody Users users) {
        return service.updateById(users)?"success":"error";
    }
    @PostMapping("/updatepass")
    @ResponseBody
    public String updateUserpass(@RequestBody Users users,HttpServletRequest request) {

        if (service.updateById(users)){
            HttpSession session = request.getSession();
            session.invalidate();
            return "success";
        }else {
            return "error";
        }

    }
    @RequestMapping("/delete/{uid}")
    @ResponseBody
    public String delete(@PathVariable("uid") int uid) {
        return service.removeById(uid)?"success":"error";
    }

    @RequestMapping("/delcids")
    @ResponseBody
    public String delcids(@RequestBody List<Integer> uids){
        return service.removeByIds(uids)?"success":"error";
    }

    @PostMapping("/updatestatic")
    @ResponseBody
    public String updatestatic(@RequestBody Users users){
        if (users.getStatus()==0){
            users.setStatus(1);
            return service.updateById(users)?"success":"error";
        }else {
            users.setStatus(0);
            return service.updateById(users)?"success":"error";
        }

    }
}

