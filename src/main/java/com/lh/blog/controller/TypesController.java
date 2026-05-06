package com.lh.blog.controller;



import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lh.blog.pojo.Types;
import com.lh.blog.service.TypesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
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
@RequestMapping("/types")
public class TypesController {
    int pagesize=10;
    @Autowired
    private TypesService service;


    @RequestMapping("/gettypes")
    public String queryTypesByPage(@RequestParam(value = "curr", defaultValue = "1") int curr, HttpServletRequest request) {
//        PageHelper.startPage(curr, 5);
//        //PageInfo<Types> info=new PageInfo()
        Page<Types> p=new Page<>(curr,pagesize);
        IPage<Types> info =service.getBaseMapper().selectPage(p,null);
//        System.out.println(info.getRecords());
        //Map<String, Object> map = new HashMap<>();
       // request.setAttribute("pages", map.get);
        request.setAttribute("pages",info.getPages());
        request.setAttribute("counts",info.getTotal());
        request.setAttribute("curr", curr);
        request.setAttribute("records",info.getRecords() );
        return "types";

    }


    @PostMapping("/add")
    @ResponseBody
    public String addTypes(@RequestBody Types types) {
       return service.save(types)?"success":"error";
    }

    @PostMapping("/update")
    @ResponseBody
    public String updateTypes(@RequestBody Types types) {
        return service.updateById(types)?"success":"error";
    }

    @RequestMapping("/delete/{mid}")
    @ResponseBody
    public String deleteTypes(@PathVariable("mid") int mid) {
        return service.removeById(mid)?"success":"error";
    }

    @RequestMapping("/delcids")
    @ResponseBody
    public String delcids(@RequestBody List<Integer> mids){
        return service.removeByIds(mids)?"success":"error";
    }

@RequestMapping("queryAllType")
    @ResponseBody
    public List<Types> queryAllType(){
        return service.list(null);
    }

}

