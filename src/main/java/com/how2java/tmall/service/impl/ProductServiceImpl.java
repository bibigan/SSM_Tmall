package com.how2java.tmall.service.impl;

import com.how2java.tmall.mapper.ProductMapper;
import com.how2java.tmall.pojo.Category;
import com.how2java.tmall.pojo.Product;
import com.how2java.tmall.pojo.ProductExample;
import com.how2java.tmall.pojo.ProductImage;
import com.how2java.tmall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductMapper productMapper;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    ReviewService reviewService;
    @Autowired
    OrderItemService orderItemService;

    @Override
    public List<Product> list(int cid) {//显示该分类下所有的产品
        ProductExample productExample=new ProductExample();//辅助查询类
        productExample.createCriteria().andCidEqualTo(cid);//查询cid字段
        productExample.setOrderByClause("id desc");//设置排序
        List<Product> productList= productMapper.selectByExample(productExample);
        //设置非数据库属性
        setCategory(productList);
        setFirstProductImage(productList);
        return productList;
    }

    @Override
    public void add(Product product) {
        productMapper.insert(product);
    }

    @Override
    public void delete(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Product get(int id) {
        Product p=productMapper.selectByPrimaryKey(id);
        //设置非数据库属性
        setCategory(p);
        setFirstProductImage(p);
        return p;
    }

    @Override
    public int update(Product product) {
        productMapper.updateByPrimaryKeySelective(product);
        return 0;
    }
    //根据pid和图片类型查询出所有的单个图片，然后把第一个取出来放在firstProductImage上。
    @Override
    public void setFirstProductImage(Product p) {
        List<ProductImage> pis = productImageService.list(p.getId(), ProductImageService.type_single);
        if (!pis.isEmpty()) {
            ProductImage pi = pis.get(0);
            p.setFirstProductImage(pi);
        }
    }
    public void setFirstProductImage(List<Product> ps) {
        for (Product p : ps) {
            setFirstProductImage(p);
        }
    }
//给多个产品设置图片
    public void setCategory(Product p){
        int cid = p.getCid();
        Category c = categoryService.get(cid);
        p.setCategory(c);
    }

    public void setCategory(List<Product> ps){
        for (Product p : ps)
            setCategory(p);
    }
    @Override
    public void fill(List<Category> cs) {
        for (Category c:cs)
            fill(c);
    }

    @Override
    public void fill(Category c) {
        //填充p给o
        List<Product> ps=list(c.getId());
        c.setProducts(ps);
    }

    @Override
    public void fillByRow(List<Category> cs) {
        int productNumberEachRow = 8;
        for (Category c : cs) {
            List<Product> products =  c.getProducts();
            List<List<Product>> productsByRow =  new ArrayList<>();
            for (int i = 0; i < products.size(); i+=productNumberEachRow) {
                int size = i+productNumberEachRow;
                size= size>products.size()?products.size():size;
                List<Product> productsOfEachRow =products.subList(i, size);
                productsByRow.add(productsOfEachRow);
            }
            c.setProductsByRow(productsByRow);
        }
    }
    @Override
    public void setProductSingleImages(Product p){
        List<ProductImage> productImageList=productImageService.list(p.getId(), ProductImageService.type_single);
        p.setProductSingleImages(productImageList);
    }
    @Override
    public void setProductDetailImages(Product p){
        List<ProductImage> productImageList=productImageService.list(p.getId(), ProductImageService.type_detail);
        p.setProductDetailImages(productImageList);
    }
    @Override
    public void setReviewCount(Product p){//设置某产品下的评论数
        p.setReviewCount(reviewService.getReviewCount(p.getId()));
    }
    @Override
    public void setSaleCount(Product p){//设置某产品下的销量
        //销量为该产品下的订单项的数量之和
        p.setSaleCount(orderItemService.getSaleCount(p));
    }
    public void set(List<Product> ps){//设置非数据库属性
        for(Product p:ps){
            setCategory(p);
            setFirstProductImage(p);
//            setProductDetailImages(p);
//            setProductSingleImages(p);
            setReviewCount(p);
            setSaleCount(p);
        }
    }
    public void set(Product p){//设置非数据库属性
        setCategory(p);
        setFirstProductImage(p);
//        setProductDetailImages(p);
//        setProductSingleImages(p);
        setReviewCount(p);
        setSaleCount(p);
    }

    @Override
    public List<Product> searchProuducts(String keyword) {//关键词搜索产品
        ProductExample example=new ProductExample();
        example.createCriteria().andNameLike("%"+keyword+"%");
        example.setOrderByClause("id desc");
        List<Product> productList= productMapper.selectByExample(example);
        //设置非数据库属性
        set(productList);
        return productList;
    }

    public ProductServiceImpl() {
        super();
    }

    @Override
    public void setSaleAndReviewNumber(Product p) {
        int saleCount = orderItemService.getSaleCount(p);
        p.setSaleCount(saleCount);

        int reviewCount = reviewService.getReviewCount(p.getId());
        p.setReviewCount(reviewCount);
    }

    @Override
    public void setSaleAndReviewNumber(List<Product> ps) {
        for (Product p : ps) {
            setSaleAndReviewNumber(p);
        }
    }
}
