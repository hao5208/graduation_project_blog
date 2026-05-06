package com.lh.blog.controller;


import com.lh.blog.pojo.Files;
import com.lh.blog.service.FilesService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
@Controller
@RequestMapping("/files")
public class FilesController {
    @Autowired
    private FilesService service;
    @RequestMapping("/getfiles")
    public String queryFilesByPage(@RequestParam(value = "curr",defaultValue = "1") int curr, HttpServletRequest request) {
        Map<String, Object> map = service.queryFilesByPage(curr);
        request.setAttribute("pages",map.get("pages"));
        request.setAttribute("counts",map.get("counts"));
        request.setAttribute("curr",curr);
        request.setAttribute("records",(List)(map.get("records")));
        return "files";
    }

    @RequestMapping("/delete/{fid}")
    @ResponseBody
    public String deleteFiles(@PathVariable("fid") int fid) {
        return service.removeById(fid)?"success":"error";
    }

    @RequestMapping("/delfids")
    @ResponseBody
    public String delfids(@RequestBody List<Integer> fids){
        return service.removeByIds(fids)?"success":"error";
    }



    @RequestMapping("/upload")
    @ResponseBody
    public Map<String,Object> upload(@RequestParam Integer userid, @RequestParam("source") MultipartFile source, HttpSession session) throws IOException{


        String filename = source.getOriginalFilename();
        //定制全局唯一的命名
        String unique = UUID.randomUUID().toString();
        //获得文件的后缀
        String ext = FilenameUtils.getExtension(filename);//abc.txt   txt    hello.html  html
        //定制全局唯一的文件名
        String uniqueFileName = unique+"."+ext;
        System.out.println("唯一的文件名:"+uniqueFileName);

        //文件的类型
        String type = source.getContentType();
        System.out.println("filename:"+filename+" type:"+type);

        //获得 upload_file的磁盘路径 ==> 在webapp目录下创建一个目录"upload_file",且此目录初始不要为空，否则编译时被忽略
        String real_path = session.getServletContext().getRealPath("/upload/");
        System.out.println("real_path:"+real_path);
        System.out.println("文件:"+real_path+uniqueFileName);
        File uploadDir = new File(real_path);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        source.transferTo(new File(uploadDir, uniqueFileName));


        int b=(int)((999 - 100 + 1) * Math.random() + 100);
        boolean pd1=service.save(new Files(filename, ext, userid,"/upload/"+uniqueFileName));
        if (pd1) {
            Map<String, Object> map = new HashMap<>();
            map.put("msg","success");
            map.put("url","/upload/"+uniqueFileName);
            map.put("sj","sj"+b);
            return map;
        }else {
            Map<String, Object> map = new HashMap<>();
            map.put("msg","error");
            map.put("url","error");
            return map;
        }

    }

    @RequestMapping("/tinyupload")
    @ResponseBody
    public Map<String,Object> tinyupload(@RequestParam("file") MultipartFile file, HttpSession session) throws IOException{


        String filename = file.getOriginalFilename();
        //定制全局唯一的命名
        String unique = UUID.randomUUID().toString();
        //获得文件的后缀
        String ext = FilenameUtils.getExtension(filename);//abc.txt   txt    hello.html  html
        //定制全局唯一的文件名
        String uniqueFileName = unique+"."+ext;
        System.out.println("唯一的文件名:"+uniqueFileName);

        //文件的类型
        String type = file.getContentType();
        System.out.println("filename:"+filename+" type:"+type);

        //获得 upload_file的磁盘路径 ==> 在webapp目录下创建一个目录"upload_file",且此目录初始不要为空，否则编译时被忽略
        String real_path = session.getServletContext().getRealPath("/upload/");
        System.out.println("real_path:"+real_path);
        System.out.println("文件:"+real_path+uniqueFileName);
        File uploadDir = new File(real_path);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        file.transferTo(new File(uploadDir, uniqueFileName));

int userid= (int) session.getAttribute("userid");
        int b=(int)((999 - 100 + 1) * Math.random() + 100);
        boolean pd1=service.save(new Files(filename, ext, userid,"/upload/"+uniqueFileName));
        if (pd1) {
            Map<String, Object> map = new HashMap<>();

            map.put("location ","/upload/"+uniqueFileName);

            return map;
        }else {
            Map<String, Object> map = new HashMap<>();
            map.put("msg","error");
            map.put("url","error");
            return map;
        }

    }

}

