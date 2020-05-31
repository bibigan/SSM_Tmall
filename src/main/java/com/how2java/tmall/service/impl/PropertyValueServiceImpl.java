package com.how2java.tmall.service.impl;

import com.how2java.tmall.mapper.PropertyValueMapper;
import com.how2java.tmall.pojo.Product;
import com.how2java.tmall.pojo.Property;
import com.how2java.tmall.pojo.PropertyValue;
import com.how2java.tmall.pojo.PropertyValueExample;
import com.how2java.tmall.service.PropertyService;
import com.how2java.tmall.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyValueServiceImpl implements PropertyValueService {
    @Autowired
    PropertyValueMapper propertyValueMapper;
    @Autowired
    PropertyService propertyService;

    @Override
    public void init(Product product) {
        // 这个方法的作用是初始化某产品下所有的PropertyValue
        List<Property> propertyList=propertyService.list(product.getCid());
        if(!propertyList.isEmpty())
            for(Property pt:propertyList){
                //用属性和id产品id去查询，看看这个属性和这个产品，是否已经存在属性值了
                PropertyValue propertyValue=get(pt.getId(),product.getId());
                if(propertyValue==null){
                    //如果不存在，那么就创建一个属性值，并设置其属性和产品，接着插入到数据库中
                    propertyValue=new PropertyValue();
                    propertyValue.setPid(product.getId());
                    propertyValue.setPtid(propertyValue.getId());
                    propertyValueMapper.insert(propertyValue);
                }
            }
    }

    @Override
    public void update(PropertyValue propertyValue) {
        //更新
        propertyValueMapper.updateByPrimaryKeySelective(propertyValue);
    }

    @Override
    public PropertyValue get(int ptid, int pid) {
        //根据属性id和产品id获取PropertyValue对象
        PropertyValueExample propertyValueExample=new PropertyValueExample();
        propertyValueExample.createCriteria().andPtidEqualTo(ptid)
                                             .andPidEqualTo(pid);
        List<PropertyValue> propertyValueList=propertyValueMapper.selectByExample(propertyValueExample);
        if(!propertyValueList.isEmpty())
            return propertyValueList.get(0);
        return null;
    }

    @Override
    public List<PropertyValue> list(int pid) {
        //根据产品id获取所有的属性值
        PropertyValueExample propertyValueExample=new PropertyValueExample();
        propertyValueExample.createCriteria().andPidEqualTo(pid);
        propertyValueExample.setOrderByClause("id desc");
        List<PropertyValue> propertyValueList= propertyValueMapper.selectByExample(propertyValueExample);
        //设置每个pv的所属属性pt
        for (PropertyValue pv:propertyValueList){
            Property property=propertyService.get(pv.getPtid());
            pv.setProperty(property);
        }
        return propertyValueList;
    }
}
