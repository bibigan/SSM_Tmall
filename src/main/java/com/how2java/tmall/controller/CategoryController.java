package com.how2java.tmall.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;

import com.how2java.tmall.util.ImageUtil;
import com.how2java.tmall.util.UploadedImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.tmall.pojo.Category;
import com.how2java.tmall.service.CategoryService;
import com.how2java.tmall.util.Page;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

// 告诉spring mvc这是一个控制器类
@Controller
@RequestMapping("")
public class CategoryController {
	@Autowired
	CategoryService categoryService;

	@RequestMapping("admin_category_list")
	public ModelAndView listCategory(Page page){
		ModelAndView mav = new ModelAndView();//redirect:/

		PageHelper.offsetPage(page.getStart(),page.getCount());

		List<Category> cs= categoryService.list();

		int total=(int) new PageInfo<>(cs).getTotal();
		page.setTotal(total);
		
		// 放入转发参数
		mav.addObject("cs", cs);
		// 放入jsp路径
		mav.setViewName("admin/listCategory");
		return mav;
	}
	@RequestMapping("admin_category_add")
	public ModelAndView addCategory(Category category, HttpSession session, UploadedImageFile uploadedImageFile)
			throws java.io.IOException, IllegalStateException{
		ModelAndView mav=new ModelAndView("redirect:/admin_category_list");
		/*
		1.1 参数 Category c接受页面提交的分类名称
		1.2 参数 session 用于在后续获取当前应用的路径
		1.3 UploadedImageFile 用于接受上传的图片*/
		categoryService.add(category);
		File ImageFolder =new File(session.getServletContext().getRealPath("img/category"));
		File imageFile=new File(ImageFolder,category.getId()+".jpg");
		if(!imageFile.getParentFile().exists())
			imageFile.getParentFile().mkdirs();
		uploadedImageFile.getImage().transferTo(imageFile);
		BufferedImage img=ImageUtil.change2jpg(imageFile);
		ImageIO.write(img,"jpg",imageFile);
		return mav;
	}
	@RequestMapping("admin_category_delete")
	public ModelAndView deleteCategory(int id,HttpSession session){
		ModelAndView mav=new ModelAndView("redirect:/admin_category_list");
		categoryService.delete(id);
		//删对应的图片
		File imageFile=new File(session.getServletContext().getRealPath("img/category")+id+".jpg");
		imageFile.delete();

		return mav;
	}
	@RequestMapping("admin_category_edit")
	public ModelAndView editCategory(int id){
		ModelAndView mav=new ModelAndView();
		Category category=getCategory(id);
		mav.addObject("category",category);
		mav.setViewName("admin/editCategory");
		return mav;
	}

	@RequestMapping("admin_category_update")
	public ModelAndView updateCategory(Category category, HttpSession session, UploadedImageFile uploadedImageFile)
			throws java.io.IOException, IllegalStateException{
		ModelAndView mav=new ModelAndView("redirect:/admin_category_list");
		/*
		1.1 参数 Category c接受页面提交的分类名称
		1.2 参数 session 用于在后续获取当前应用的路径
		1.3 UploadedImageFile 用于接受上传的图片*/
		categoryService.update(category);
		MultipartFile image = uploadedImageFile.getImage();
		if(null!=image &&!image.isEmpty()){
			File  imageFolder= new File(session.getServletContext().getRealPath("img/category"));
			File file = new File(imageFolder,category.getId()+".jpg");
			image.transferTo(file);
			BufferedImage img = ImageUtil.change2jpg(file);
			ImageIO.write(img, "jpg", file);
		}
		return mav;
	}

	public Category getCategory(int id){
		Category category=categoryService.get(id);
		return category;
	}
}
