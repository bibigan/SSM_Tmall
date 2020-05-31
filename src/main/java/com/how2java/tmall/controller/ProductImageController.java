package com.how2java.tmall.controller;

import com.how2java.tmall.pojo.Category;
import com.how2java.tmall.pojo.Product;
import com.how2java.tmall.pojo.ProductImage;
import com.how2java.tmall.service.CategoryService;
import com.how2java.tmall.service.ProductImageService;
import com.how2java.tmall.service.ProductService;
import com.how2java.tmall.util.ImageUtil;
import com.how2java.tmall.util.UploadedImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import sun.awt.ModalExclude;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductImageController {
    @Autowired
    ProductImageService productImageService;
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping("admin_productImage_list")
    public ModelAndView listProductImage(int pid){
        //admin_productImage_list?pid=${p.id}
        //需要product.category、singleImgList、detailImgList
        ModelAndView mav=new ModelAndView();
        Product product=productService.get(pid);

        Category category=categoryService.get(product.getCid());
        product.setCategory(category);

        List<ProductImage> singleImgList=productImageService.list(pid,ProductImageService.type_single);
        List<ProductImage> detailImgList=productImageService.list(pid,ProductImageService.type_detail);

        mav.addObject("product",product);
        mav.addObject("singleImgList",singleImgList);
        mav.addObject("detailImgList",detailImgList);
        mav.setViewName("admin/listProductImage");
        return mav;
    }
    @RequestMapping("admin_productImage_add")
    public ModelAndView addProductImage(ProductImage productImage, HttpSession session, UploadedImageFile uploadedImageFile){
        //admin_productImage_list?pid=${p.id}
        ModelAndView mav=new ModelAndView("redirect:/admin_productImage_list?pid="+productImage.getPid());
        productImageService.add(productImage);
        //保存图片到本地
        String ImageFolder;
        String imageFolder_small=null;
        String imageFolder_middle=null;
        //是单个图片
        if(ProductImageService.type_single.equals(productImage.getType())){
            ImageFolder=session.getServletContext().getRealPath("img/productSingle");
            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
        }
        else{//是详情图片
            ImageFolder=session.getServletContext().getRealPath("img/productDetail");
        }
        File imageFile=new File(ImageFolder,productImage.getId()+".jpg");
        imageFile.getParentFile().mkdirs();
        try{
            uploadedImageFile.getImage().transferTo(imageFile);
            BufferedImage image= ImageUtil.change2jpg(imageFile);
            ImageIO.write(image,"jpg",imageFile);
            if(ProductImageService.type_single.equals(productImage.getType())) {
                File f_small = new File(imageFolder_small, productImage.getId()+".jpg");
                File f_middle = new File(imageFolder_middle, productImage.getId()+".jpg");

                ImageUtil.resizeImage(imageFile, 56, 56, f_small);
                ImageUtil.resizeImage(imageFile, 217, 190, f_middle);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return mav;
    }
    @RequestMapping("admin_productImage_delete")
    public ModelAndView deleteProductImage(int id,HttpSession session){
        //admin_productImage_list?pid=${p.id}
        ProductImage productImage=productImageService.get(id);
        ModelAndView mav=new ModelAndView("redirect:/admin_productImage_list?pid="+productImage.getPid());

        //从本地删除图片
        String fileName = productImage.getId()+ ".jpg";
        String imageFolder;
        String imageFolder_small=null;
        String imageFolder_middle=null;

        if(ProductImageService.type_single.equals(productImage.getType())){
            imageFolder= session.getServletContext().getRealPath("img/productSingle");
            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
            File imageFile = new File(imageFolder,fileName);
            File f_small = new File(imageFolder_small,fileName);
            File f_middle = new File(imageFolder_middle,fileName);
            imageFile.delete();
            f_small.delete();
            f_middle.delete();
        }
        else{
            imageFolder= session.getServletContext().getRealPath("img/productDetail");
            File imageFile = new File(imageFolder,fileName);
            imageFile.delete();
        }
        productImageService.delete(id);
        return mav;
    }
}
