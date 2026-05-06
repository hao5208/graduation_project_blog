package com.lh.blog.common;

import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyExceptionHandler implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        //创建视图模型
        ModelAndView mv = new ModelAndView();
        if(e instanceof MaxUploadSizeExceededException){
            mv.addObject("msg","文件过大啦");
        }
        else if(e instanceof IOException){
            mv.addObject("msg","IO异常");
        }
        else if(e instanceof  RuntimeException){
            //模型添加数据
            mv.addObject("msg","运行时异常");
        }

        else {
            mv.addObject("msg","其他异常");
        }
        //视图跳转
        mv.setViewName("error");
        return mv;
    }
}
