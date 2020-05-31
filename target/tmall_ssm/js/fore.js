
$(function(){
//	$("a[href$=#nowhere]").click(function(){
//         alert("模仿天猫的连接，并没有跳转到实际的页面"); 
//    });
	$("div#footer a[href$=#nowhere]").click(function(){
		alert("模仿天猫的连接，并没有跳转到实际的页面");
	});
	

	$("a.wangwanglink").click(function(){
		alert("模仿旺旺的图标，并不会打开旺旺");
	});
	$("a.notImplementLink").click(function(){
		alert("这个功能没做，蛤蛤~");
	});
});

$("a.wangwanglink").click(function(){
     alert("模仿旺旺的图标，不会打开旺旺"); 
 });
 $("a.notImplementLink").click(function(){
     alert("这个功能没做，蛤蛤~"); 
}); 

/*******************************cat1.js**********************************/
//天猫图标
$(function(){
	$("div.menu span").mouseenter(function(){
		var left = $(this).position().left;
		var top = $(this).position().top;
		var width = $(this).css("width");
		var jiange= $(this).css("margin-left")
		var destLeft = parseInt(left) + parseInt(width)/2+ parseInt(jiange)/2;
		$("img#catear").css("left",destLeft);
		$("img#catear").css("top",top+147);
		$("img#catear").fadeIn(500);
	});
	$("div.menu span").mouseleave(function(){
		$("img#catear").hide();
	});
});
//产品分类页
//将产品页全部隐藏，鼠标触摸到categoryMenuItem时，根据id可以访问到对应的产品页
function showProductsAsideCategorys(cid){
	$("div.categoryMenuItem[cid="+cid+"]").css("background-color","white");
	$("div.categoryMenuItem[cid="+cid+"] a").css("color","#87CEFA");
	$("div.productsAsideCategorys[cid="+cid+"]").show();
}

function hideProductsAsideCategorys(cid){
	$("div.categoryMenuItem[cid="+cid+"]").css("background-color","#e2e2e3");
	$("div.categoryMenuItem[cid="+cid+"] a").css("color","#000");
	$("div.productsAsideCategorys[cid="+cid+"]").hide();
}
$(function(){
	$("div.categoryMenuItem").mouseenter(function(){
		var cid=$(this).attr("cid");//得到cid属性值
		showProductsAsideCategorys(cid);
	});
	$("div.categoryMenuItem").mouseleave(function(){
		var cid=$(this).attr("cid");
		hideProductsAsideCategorys(cid);
	});
	$("div.productsAsideCategorys").mouseenter(function(){
		var cid=$(this).attr("cid");
		showProductsAsideCategorys(cid);
	});
	$("div.productsAsideCategorys").mouseleave(function(){
		var cid=$(this).attr("cid");
		hideProductsAsideCategorys(cid);
	});
});
//产品列表
$(function(){
	$("div.productItem").mouseenter(function(){
		$(this).css("border","1px solid #980707");
	});
	$("div.productItem").mouseleave(function(){
		$(this).css("border","1px solid white");
	});
});
/*******************************cat3.js**********************************/
//$(function(){
//	$("input.sortBarPrice").keyup(function(e){
//		var beginPrice=$("input.beginPrice").val();
//		var endPrice=$("input.endPrice").val();
//		beginPrice=parseInt(beginPrice);
//		endPrice=parseInt(endPrice);		
//		if(!isNaN(beginPrice)&&!isNaN(endPrice)){/*都是数字*/
//			console.log("begin:"+beginPrice);
//            console.log("end:"+endPrice);
//			$("div.productUnit").hide();
//			if(beginPrice<0){
//				beginPrice=0;
//			}
////			alert(beginPrice+","+endPrice);
//			if(endPrice>=beginPrice){		
//				$("div.productUnit").each(function(){/*对每个*/
//					var price=$(this).attr("price");/*字符串？*/
//					price= new Number(price);
//					if(price<=endPrice&&price>=beginPrice){
//						$(this).show();
//					}
//				});
//			}
//		}
//		else if(!isNaN(beginPrice)^!isNaN(endPrice)){/*一个是数字*/
//			$("div.productUnit").hide();
//		}
//		else {/*都不是数字*/
//			$("div.productUnit").show();
//		}
//	});
//});

// sortBarPrice
$(function(){
    $("input.sortBarPrice").keyup(function(){
        var num= $(this).val();
        if(num.length==0){
            $("div.productUnit").show();
            return;
        }
             
        num = parseInt(num);
        if(isNaN(num))
            num= 1;
        if(num<=0)
            num = 1;
        $(this).val(num);      
         
        var begin = $("input.beginPrice").val();
        var end = $("input.endPrice").val();
        if(!isNaN(begin) && !isNaN(end)){
            console.log(begin);
            console.log(end);
            $("div.productUnit").hide();
            $("div.productUnit").each(function(){
                var price = $(this).attr("price");
                price = new Number(price);
                 
                if(price<=end && price>=begin)
                    $(this).show();
            });
        }
         
    });
});
/*******************************countJs.js**********************************/
$(function(){
	$("input.leaveMessageInput").focus(function(){
		$(this).hide();
        $("span.leaveMessageTextareaSpan").show();
        $("textarea.leaveMessageTextarea").focus();
        $("div.orderItemListumDiv").css("height","100px");
    });

    $("textarea.leaveMessageTextarea").blur(function () {
        $("span.leaveMessageTextareaSpan").hide();
        $("input.leaveMessageInput").show();
        $("input.leaveMessageInput").val($("textarea.leaveMessageTextarea").val());
        $("div.orderItemListumDiv").css("height","50px");
    });
    $("textarea.leaveMessageTextarea").keyup(function () {
        var num=$(this).val().length;
        if(num>=200)
            num=200;
        var avaible=200-num;
        $("span.inputNumber").text(avaible);
        var buff=$(this).val();
        $(this).val(buff.substring(0,200));
    });
});
/*******************************myOrderJs.js**********************************/
$(function(){
	//含有orderStatus属性的a 点击订单类型时
    $("a[orderStatus]").click(function(){
        var orderStatus = $(this).attr("orderStatus");
        if('all'==orderStatus){//所有订单
        	//含有orderStatus属性的table
            $("table[orderStatus]").show();
        }
        else{
            $("table[orderStatus]").hide();//全部隐藏
            //显示当前orderStatus属性值下的table
            $("table[orderStatus="+orderStatus+"]").show();        
        }
        $("div.orderType div").removeClass("selectedOrderType");//全部移除class类名->无变红样式
        $(this).parent("div").addClass("selectedOrderType");//用于动态增加class类名->当前a前的div增加变红样式
    });
    //点击垃圾箱
    $("a.deleteOrderLink").click(function(){
        deleteOrderid = $(this).attr("oid");
        deleteOrder = false;
        $("#deleteConfirmModal").modal("show");
    });
//    //点击确认删除按钮
//    $("button.deleteConfirmButton").click(function(){
//        deleteOrder = true;
//        $("#deleteConfirmModal").modal('hide');
//    });
//    //绑定事件 
//    //通过ajax访问后端的服务，一旦后端把数据删除掉后，返回消息给前端，前端确认删除成功后，把该行订单数据隐藏掉
//    $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
//        if(deleteOrder){
//            var page="foredeleteOrder";
//            $.post(
//                    page,
//                    {"oid":deleteOrderid},
//                    function(result){
//                        if("success"==result){
//                            $("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
//                        }
//                        else{
//                            location.href="login.jsp";
//                        }
//                    }
//                );
//        }
//    })     
});
/*******************************productPageJs.js**********************************/
//显示缩略图效果
$(function(){
	$("img.smallImage").mouseenter(
		function(){
			var bigImageURL=$(this).attr("bigImageURL");
			$("img.bigImg").attr("src",bigImageURL);
	});
	$("img.bigImg").load(
		function(){
			//onload一直会预加载，加了个条件
		  if(0 == $("div.img4load").children().length){
			$("img.smallImage").each(function(){
				console.info("预加载：" + $("div.img4load").children().length);
				var bigImageURL=$(this).attr("bigImageURL");
				img=new Image();
				img.src=bigImageURL;
				img.onload=function(){
					console.log(bigImageURL);  
                    $("div.img4load").append($(img));
				};
			});
		 }
	});
});
//产品信息

//切换商品详情和累计评价效果
$(function(){
    $("div.productReviewDiv").hide();
    $("a.productDetailTopReviewLink").click(function(){
        $("div.productReviewDiv").show();
        $("div.productDetailDiv").hide();
    });
    $("a.productReviewTopPartSelectedLink").click(function(){
        $("div.productReviewDiv").hide();
        $("div.productDetailDiv").show();      
    });
})
/*******************************ShoppingCart.js**********************************/
////公共函数：
///*
//把金额转化为千进制格式
//123456 -> 123,456
//*/
//function formatMoney(num) {
//    num = num.toString().replace(/\$|\,/g, '');
//    if (isNaN(num))
//        num = "0";
//    sign = (num == Math.abs(num));//sign为false，num是负数，反之亦然
//    num = Math.abs(num);//取正数num  
//  /*   百分位四舍五入
//    cents: 小数部分
//    num: 整数部分* */   
//    num = Math.floor(num * 100 + 0.50000000001);
//    cents = num % 100;
//    num = Math.floor(num / 100).toString();
//    if (cents < 10)
//        cents = "0" + cents;
////    三位一隔
//    var number="";
//    var len=num.length;
//    for (var i = 0; i < len ; i++) {
//        number+=num[i];
//        if ((i + 1) % 3 == len % 3 && i != len - 1) {
//            // console -1,234,567.46
//            //第0位，第3位时打印"," 最后一位不用打印,
//            number+=",";
//        }
//    }
//    return (((sign) ? '' : '-') + number + '.' + cents);
//}
//
////结算刷新
//function syncCreateOrderButton(){
////	对每个框，判断是否有框勾上
//	var flag=false;
//	$("img.cartProductItemIfSelected").each(function(){
//		if("selectit"==$(this).attr("selectit"))
//			flag=true;//有勾上
//	});
//	if(flag){//有勾上，结算变红可点
//		$("button.createOrderButton").removeAttr("disabled");
//		$("button.createOrderButton").css("background-color","#C40000");
//	}
//	else{//没有勾，结算变灰不可点
//		$("button.createOrderButton").attr("disabled","disabled");
//		$("button.createOrderButton").css("background-color","#AAAAAA");
//	}
//}
////全选刷新
//function syncSelect(){
////	对每个框，判断是否有框没有勾上
//	var flag=true;
//	$("img.cartProductItemIfSelected").each(function(){
//		if("false"==$(this).attr("selectit"))
//			flag=false;//存在没有勾上
//	});	
//	if(!flag){ //有框没勾上，不是全选，不勾
//		$("img.selectAllItem").attr("src","img/site/cartNotSelected.png");
//	    $("img.selectAllItem").attr("selectit","false");
//	}
//	//是全选,勾上
//	else {
//		 $("img.selectAllItem").attr("src","img/site/cartSelected.png");
//		 $("img.selectAllItem").attr("selectit","selectit");
//	}
//	
//}
////总计、总数刷新
//function calcCartSumPriceAndNumber(){
//	var sum=0.00;//总计
//	var totalNumber = 0;//总数
//	//对勾了的行，根据pid找对应的小计和数量
//	$("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
//		var oiid=$(this).attr("oiid");
//		var n=$(".orderItemNumberSetting[oiid="+oiid+"]").val();
//		totalNumber+=new Number(n);
//		
//		var s=$("span.cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
//		s=s.replace(/,/g,"");
//		s=s.replace(/￥/g,"");
//		sum+=new Number(s); 
//	});
////	放到对应的位置
//	$("span.cartSumNumber").html(totalNumber);
//	$("span.cartSumPrice").html("￥"+formatMoney(sum));
//	$("span.cartTitlePrice").html("￥"+formatMoney(sum));	
//}
////小计刷新 某行改了数量，传该行pid,num,单价price，并刷新总计
//function syncPrice(pid,num,price){
//	$(".orderItemNumberSetting[pid="+pid+"]").val(num);
//	$("span.cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+formatMoney(num*price));
//	calcCartSumPriceAndNumber();
//}
//
//
////响应事件：
//$(function(){
////	选中某行：原本没勾：某行变黄，某行有勾，刷新全选框，刷新结算按钮，刷新合计
////			   原本有勾：某行变白，某行没有勾，刷新全选框，刷新结算按钮，刷新合计
//	$("img.cartProductItemIfSelected").click(function(){
//		var selectit=$(this).attr("selectit");
//		if(selectit=="false"){//原本没勾
//			$(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
//			$(this).attr("src","img/site/cartSelected.png");
//			$(this).attr("selectit","selectit");
//		}
//		else{//原本有勾
//			$(this).parents("tr.cartProductItemTR").css("background-color","#fff");
//			$(this).attr("src","img/site/cartNotSelected.png");
//			$(this).attr("selectit","false");
//		}
//		syncSelect();
//		syncCreateOrderButton();
//		calcCartSumPriceAndNumber();
//	});
////	全选：原本没勾：行全变黄，全有勾，刷新结算按钮，刷新合计
////	   	   原本有勾：行全变白，全没勾，刷新结算按钮，刷新合计
//	$("img.selectAllItem").click(function(){		
//		var selectit=$(this).attr("selectit");
//		if(selectit=="false"){//原本没勾
//			$("img.selectAllItem").attr("src","img/site/cartSelected.png");
//			$("img.selectAllItem").attr("selectit","selectit");
//			$("img.cartProductItemIfSelected").each(function(){
//				$(this).attr("src","img/site/cartSelected.png");
//				$(this).attr("selectit","selectit");
//				$(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
//			});
//		}
//		else{//原本有勾
//			$("img.selectAllItem").attr("src","img/site/cartNotSelected.png");
//			$("img.selectAllItem").attr("selectit","false");
//			$("img.cartProductItemIfSelected").each(function(){
//				$(this).attr("src","img/site/cartNotSelected.png");
//				$(this).attr("selectit","false");
//				$(this).parents("tr.cartProductItemTR").css("background-color","#fff");
//			});
//		}
//		syncCreateOrderButton();
//		calcCartSumPriceAndNumber();
//});
////	手动写数量：计算某商品小计 控制范围1-stock 刷新小计
//	$(".orderItemNumberSetting").keyup(function(){
//		var pid=$(this).attr("pid");
//		var num=$(this).val();
//		var price=$("span.orderItemPromotePrice[pid="+pid+"]").text();
//		var stock=$("span.orderItemListtock[pid="+pid+"]").text();
//		num = parseInt(num);
//		if(isNAN(num))
//			num=1;
//		if(num<=0)
//			num=1;
//		if(num>stock)
//			num=stock;
//		price =new Number(price);
//		syncPrice(pid,num,price);
//	});
////	点击-：计算某商品小计，只能减为1  刷新小计
//	$(".numberMinus").click(function(){
//		var pid=$(this).attr("pid");
//		var num=$(".orderItemNumberSetting[pid="+pid+"]").val();
//		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
//		num = parseInt(num);
//		if(num>1)
//			num--;
//		syncPrice(pid,num,price);
//	});
////	点击+：计算某商品小计，只能加到stock  刷新小计
//	$(".numberPlus").click(function(){
//		var pid=$(this).attr("pid");
//		var num=$(".orderItemNumberSetting[pid="+pid+"]").val();
//		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
//		var stock=$("span.orderItemListtock[pid="+pid+"]").text();
//		num = parseInt(num);
//		if(num<stock)
//			num++;
//		syncPrice(pid,num,price);
//	});
//	//点击结算按钮----获取选中的订单项的id
//	$("button.createOrderButton").click(function(){
//        var params = "";
//        $(".cartProductItemIfSelected").each(function(){
//            if("selectit"==$(this).attr("selectit")){
//                var oiid = $(this).attr("oiid");
//                params += "&oiid="+oiid;
//            }
//        });
//        params = params.substring(1);
//        location.href="forebuy?"+params;
//    });
//	//改变数量
//	$("input.orderItemNumberSetting").keyup(function(){
//        var pid=$(this).attr("pid");
//        var stock= $("span.orderItemListtock[pid="+pid+"]").text();
//        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
//         
//        var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
//        num = parseInt(num);
//        if(isNaN(num))
//            num= 1;
//        if(num<=0)
//            num = 1;
//        if(num>stock)
//            num = stock;
//         
//        syncPrice(pid,num,price);
//    });
//	
//});

