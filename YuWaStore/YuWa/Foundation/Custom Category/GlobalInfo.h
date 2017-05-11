//
//  GlobalInfo.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#ifndef GlobalInfo_h
#define GlobalInfo_h

#define HTTP_ADDRESS        @"https://www.yuwabao.cn"    //地址


#pragma mark - push Image

#define HTTP_IMG_UP @"/api.php/Index/uploadImg/" //1上传图片




#pragma mark - Logion & Register

#define HTTP_REGISTER       @"/api.php/Login/reg/" //1注册账号
#define HTTP_REGISTER_CODE   @"/api.php/Login/getRegisterCode/" //1注册验证码
#define HTTP_LOGION_CODE   @"/api.php/Login/getRegisterCode/" //1快捷登录验证码
#define HTTP_RESET_CODE   @"/api.php/Login/getRegisterCode/" //1重置密码验证码
#define HTTP_LOGIN          @"/api.php/Login/login/" //1登入
#define HTTP_LOGIN_Quick      @"/api.php/Login/phoneLogin/" //1快捷登录  验证码登录
#define HTTP_LOGIN_FORGET_TEL @"/api.php/Login/resetPassword/" //1找回密码


#pragma mark  -- 首页

#define HTTP_HOME_PAGE    @"/api.php/Index/index/"    //1首页获取数据的接口
#define HTTP_HOME_MORELOADING     @"/api.php/Index/pullRefresh/"   //1加载首页更多的数据
#define HTTP_HOME_UPDATECOORDINATE    @"/api.php/Index/updateCoordinate/"   //1更新经纬度
#define HTTP_HOME_HOTSEARCH          @"/api.php/Index/hotSearch/"    //1热门搜索 旋风也用
#define HTTP_HOME_SEARCH            @"/api.php/Index/searchResult/"     //1搜索

#define HTTP_HOME_SHOPDETAIL        @"/api.php/Shop/index/"      //1店铺详情
#define HTTP_GETPAGEVIEW            @"/api.php/Shop/addLog/"      //1得到浏览量
#define HTTP_GET_CONPON             @"/api.php/User/robCoupon/"  //1抢优惠券
#define HTTP_HOME_SCHEDULE          @"/api.php/User/addReserve/" //1店铺预定
#define HTTP_HOME_SHOPPHOTO         @"/api.php/Shop/getShopPhoto/"  //1店铺相册
#define HTTP_HOME_MOREGOODS       @"/api.php/Shop/moreGoods/"  //1更多商品
#define HTTP_HOME_MORECOMMIT      @"/api.php/Shop/moreComment/"  //1更多评论



#define HTTP_QRCODE_ID              @"/api.php/User/getQrcode/"  //1通过二维码的id 得到买单的详情
#define HTTP_MAKEORDER             @"/api.php/Index/addNoPayOrder/"  //1生成未付款的订单 选好优惠券点确认付款
#define HTTP_BALANCE_PAY          @"/api.php/index/payForBalanceMoney/"  //1全部余额支付
#define HTTP_THIRD_PAY            @"/api.php/index/payForNoBalanceMoney/" //1第三方支付
#define HTTP_PAY_RESULT           @"/api.php/index/payToGetMoney/"     //1支付结果


#pragma 18大分类
#define HTTP_HOME_GETCATEGORY     @"/api.php/Shop/getAllCatoryAndBusiness/"   //1得到大分类和商圈
#define HTTP_HOME_CATEGORYSHOW    @"/api.php/Shop/checkShop/"    //1 18个分类的筛选






#pragma mark - discover

#define HTTP_RB_HOME @"/api.php/Note/index/" //1发现首页
#define HTTP_RB_DETAIL @"/api.php/Note/detail/" //1笔记详情
#define HTTP_RB_RELATED @"/api.php/Note/getRelationNote/" //1相关笔记
#define HTTP_RB_LIKE @"/api.php/Note/addLikes/" //1添加点赞（喜欢）
#define HTTP_RB_LIKE_CANCEL @"/api.php/Note/delLikes/" //1取消点赞（喜欢）
#define HTTP_RB_ALDUM @"/api.php/Note/getUserAlbumLists/" //1获取用户专辑列表
#define HTTP_RB_CREATE_ALDUM @"/api.php/Note/addAlbum/" //1创建专辑
#define HTTP_RB_COLLECTION_TO_ALDUM @"/api.php/Note/addToMyAlbum/" //1添加收藏到我的专辑
#define HTTP_RB_COLLECTION_CANCEL @"/api.php/Note/delMyNoteAlbum/" //1取消收藏单条笔记
#define HTTP_RB_COMMENT @"/api.php/Note/addNoteComment/" //1评论发布
#define HTTP_RB_COMMENT_LIST @"/api.php/Note/getCommentListByNoteId/" //1笔记的评论列表
#define HTTP_RB_SEARCH_QUICK @"/api.php/Note/hotSearch/" //1笔记热门搜索
#define HTTP_RB_SEARCH_KEY @"/api.php/Note/getRelationKeywords/" //1搜索相关 词语
#define HTTP_RB_SEARCH_RESULT @"/api.php/Note/searchResult/" //1搜索结果
#define HTTP_RB_NODE_PUBLISH @"/api.php/Note/addNote/" //1发布笔记

//#define HTTP_RB_ @"/api.php/Login/resetPassword/" //添加地点
//#define HTTP_RB_ @"/api.php/Login/resetPassword/" //搜索地点
//#define HTTP_STORM_SEARCH_HOT @"/api.php/Index/hotSearch/" //1热门搜索
//#define HTTP_STORM_SEARCH @"/api.php/Shop/searchResult/" //1搜索店铺 旋风
//#define HTTP_GETPAYDETAIL          @"/api.php/User/getMyAccount/"   //废 钱包中得到收入支出明细






#pragma mark - Storm

#define HTTP_STORM_NEARSHOP @"/api.php/Shop/getMyNearShop/" //1商家
#define HTTP_STORM_TAG @"/api.php/Shop/getTagNameByCid/" //1子标签





#pragma mark - message
#define HTTP_FRIENDS_INFO @"/api.php/User/getUserInfoByUserName/" //1好友信息 得到好友的名字和头像








#pragma mark  -- 个人中心


#define HTTP_PRESON_CHANGEINFO     @"/api.php/User/setMyBaseInfo/"  //1 修改个人中心资料
#define HTTP_PERSON_COUPON         @"/api.php/User/getMyCoupon/"   //1 显示优惠券列表
#define HTTP_NOTCCAFICATIONJ_ORDER @"/api.php/User/reservePushNotice/" //1预约通知
#define HTTP_NOTCCAFICATIONJ_PAY @"/api.php/User/payPushNotice/" //1付款通知
#define HTTP_GETMONEY              @"/api.php/User/getMyMoney/"   //1得到钱 账户余额

#define HTTP_MYORDER               @"/api.php/User/getMyOrder/"      //1显示我的订单
#define HTTP_DELETEORDER           @"/api.php/Index/delOrder/"       //1 删除未付款的订单
#define HTTP_POSTCOMMIT            @"/api.php/Shop/addShopComment/"   //1 订单付款后的评价 发布评价
#define HTTP_SHOWCOLLECTION        @"/api.php/User/getMyCollection/"   //1 显示收藏
#define HTTP_DELETECOLLECTION      @"/api.php/User/delCollection/"     //1 删除收藏
#define HTTP_ADDCOLLECTION         @"/api.php/User/addCollection/"     //1添加收藏店铺

//笔记那一票
#define HTTP_GETNOTES              @"/api.php/Note/getMyNewNote/"    //1得到笔记
#define HTTP_GETALBUMS             @"/api.php/Note/getMyNewAlbum/"   //1得到专辑
#define HTTP_RBAdd_AlbumDetail @"/api.php/Note/getAlbumDetail/" //1专辑详情
#define HTTP_RBAdd_DelAlbum @"/api.php/Note/delMyAlbum/" //1删除整个专辑
#define HTTP_GETCOMMIT             @"/api.php/Shop/getUserComment"   //1得到评论（自己和别人的）
#define HTTP_ADDABOUT              @"/api.php/User/addAttention/"    //1加关注
#define HTTP_DELABOUT              @"/api.php/User/delAttention/"    //1删除关注
#define HTTP_MYABOUNT              @"/api.php/User/myAttention/"   //1我的关注
#define HTTP_MYFANS                @"/api.php/User/myFans/"        //1我的粉丝
#define HTTP_SEEOTHERCENTER       @"/api.php/User/getUserInfo/"  //1查看他人个人中心
#define HTTP_TAABOUNT              @"/api.php/User/otherAttention/"  //1他人的关注
#define HTTP_TAFANS                @"/api.php/User/otherFans/"       //1他人的粉丝
#define HTTP_Other_Node @"/api.php/Note/getOtherNewNote/"        //1别人的笔记
#define HTTP_Other_Aldum @"/api.php/Note/getOtherAlbum/"         //1别人的专辑


//商务会员
#define HTTP_BUSINESS_HOME         @"/api.php/Sale/getBaseInfo/"    //1 商务会员首页
#define HTTP_BUSINESS_SALEINFO     @"/api.php/Sale/detail/"    //1 交易详情信息
#define HTTP_DEAL_DETAIL           @"/api.php/Sale/detailShow/"  //1 每一条交易详情
#define HTTP_MY_ORDER_SHOP         @"/api.php/Sale/myInviteShop/" //1 我签约的店铺
#define HTTP_MY_USER               @"/api.php/Sale/myDirectUser/"  //1 我的绑定用户
#define HTTP_POINTGETMONEY         @"/api.php/Sale/scoreToMoney/" //1 积分提现


//普通消费者
#define HTTP_PERSON_INTRODUCE      @"/api.php/Customer/getBaseInfo/"  //1 普通消费者的介绍分红   //非商务会员分红首页
#define HTTP_PERSON_SALEINFO       @"/api.php/Customer/detail/"   //1 普通消费者的交易详情
#define HTTP_PERSON_DETAIL         @"/api.php/Customer/detailShow/"  //1 普通消费者的详情
#define OPEN_BUSINESS              @"/api.php/Sale/toBeSale/"   //1 开通商务会员


//消费记录那栏
#define HTTP_INCOMEOUT             @"/api.php/Sale/myMoneyHistory/"  //1 个人中心的消费记录



#pragma mark - BaoBao
#define HTTP_BAOBAO_LVUP @"/api.php/User/updateMyLevel/" //1雨娃宝宝升级按钮
#define HTTP_BAOBAO_SevenConsume @"/api.php/User/getSevenConsume/" //1 近7次消费金额 消费分析
#define HTTP_BAOBAO_ConsumeType @"/api.php/User/consumeType/" //1消费在哪个大类里面
#define HTTP_BAOBAO_LuckyDraw @"/api.php/User/luckyDraw/" //1 抢优惠券







#endif /* GlobalInfo_h */
