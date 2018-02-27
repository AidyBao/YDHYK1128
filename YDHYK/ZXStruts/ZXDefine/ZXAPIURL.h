//
//  ZXAPIURL.h
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#ifndef ZXAPIURL_h
#define ZXAPIURL_h

//MARK: -
#define ZXPAGE_SIZE  10       //单页数据条数
//MARK: -
#define ZXAPI_KEY    @"reson" //接口签名秘钥
//MARK: - 接口状态定义
#define ZXAPI_TIMEOUT_INTREVAL   15 //接口超时时间
#define ZXAPI_SUCCESS             0 //接口调用成功
#define ZXAPI_LOGIN_INVALID  100001 //登录失效
#define ZXAPI_COUPON_ERROR   200006 //保存订单现金券异常
#define ZXAPI_SIGN_FAILED    100002 //签名认证失败
#define ZXAPI_PARAM_ERROR    100003 //参数错误
#define ZXAPI_NOT_EXIST      100004 //会员不存在
#define ZXAPI_NODATE         100005 //误操作的数据
#define ZXAPI_ERROR          200001 //业务操作失败
#define ZXAPI_NOT_MEMBER     200002 //药店不存在该会员
#define ZXAPI_SYSTEM_ERROR   300001 //系统异常
//MARK: -
#define ZXAPI_FORMAT_ERROR   900900           //接口返回数据非json字典
#define ZXFORMAT_ERROR_MSG   @"接口数据格式错误" //接口返回数据非json字典
//MARK: -
#define ZXAPI_HTTP_TIME_OUT    -1001                 //请求超时
#define ZXAPI_HTTP_ERROR       900901                //HTTP请求失败
#define ZXAPI_HTTP_ERROR_MSG   @"此时无法访问服务器"    //HTTP请求失败
#define ZXAPI_HTTP_TIMEOUT_MSG @"访问超时,请稍后再试"   //HTTP请求失败
//MARK: - AppStore更新检测地址
#define APPSTORE_CHECKUPDATE        @"https://itunes.apple.com/cn/lookup?id=1075692786"

//MARK: - 应用包名
#define ENTERPRISE_BUNDLE_ID        @"com.reson.ydhyk"              //企业
#define APPSTORE_BUNDLE_ID          @"com.reson.ydhyk.appstore"     //AppStore

//MARK: - 会员、管家、店铺二维码
#define ZX_QRCODE_CONTAIN           @".120v.cn"   //二维码地址需包含

//MARK: - 默认地址
#define ZX_LATITUDE                 30.592061
#define ZX_LONGITUDE                104.063396

//商城接口
//#define ZXSTORE_URL              @"https://techstoreinterfaceydy.120v.cn"
#define ZXSTORE_URL              @"http://192.168.0.171/store"

#if ZXTARGET == 1
    //MARK: - -----------------------------生产环境----------------------------------
    //MARK: - 接口地址
    #define ZXROOT_URL                  @"https://hykinterfaceydy.120v.cn"
    #define ZXPORT                      @"443"
    //MAKR: - 资源服务器地址
    #define ZXIMAGE_URL                 @"https://ydy.120v.cn"
    //    #define ZXIMAGE_PORT                @"80"
    //MARK: - Web药店地址
    #define ZXWEBSTORE_URL              @"https://storeydy.120v.cn/index.html"
    //MARK: - 静态网页端口
    #define ZXROOT_STATIC_URL           @"https://htmlydy.120v.cn/"
    //MARK: - 企业版更新检测地址
    #define ENTERPRISE_CHECKUPDATE      @"https://dl.120v.cn/iOS/ydy_hyk_version.js"
#elif ZXTARGET == 2
    //MARK: - -----------------------------测试环境----------------------------------
    //MARK: - 接口地址
    #define ZXROOT_URL                  @"https://testhykinterfaceydy.120v.cn"
    #define ZXPORT                      @"443"
    //MAKR: - 资源服务器地址
    #define ZXIMAGE_URL                 @"https://testydy.120v.cn"
    #define ZXIMAGE_PORT                @"443"
    //MARK: - Web药店地址
    #define ZXWEBSTORE_URL              @"https://teststoreydy.120v.cn/index.html"
    //MARK: - 静态网页端口
    #define ZXROOT_STATIC_URL           @"https://testhtmlydy.120v.cn/"
    //MARK: - 企业版更新检测地址
    #define ENTERPRISE_CHECKUPDATE      @"https://testdl.120v.cn/iOS/ydy_hyk_version.js"
#elif ZXTARGET == 3
    //MARK: - -----------------------------培训环境----------------------------------
    //MARK: - 接口地址
    #define ZXROOT_URL                  @"https://techhykinterfaceydy.120v.cn"
    #define ZXPORT                      @"443"
    //MAKR: - 资源服务器地址
    #define ZXIMAGE_URL                 @"https://techydy.120v.cn"
    #define ZXIMAGE_PORT                @"443"
    //MARK: - Web药店地址
    #define ZXWEBSTORE_URL              @"https://techstoreydy.120v.cn/index.html"
    //MARK: - 静态网页端口
    #define ZXROOT_STATIC_URL           @"https://techhtmlydy.120v.cn/"
    //MARK: - 企业版更新检测地址
    #define ENTERPRISE_CHECKUPDATE      @"https://techdl.120v.cn/iOS/ydy_hyk_version.js"
#else
    //MARK: - -----------------------------压力测试环境----------------------------------
    //MARK: - 接口地址
    #define ZXROOT_URL                  @"http://192.168.0.206"
    #define ZXPORT                      @"8082"
    //MAKR: - 资源服务器地址
    #define ZXIMAGE_URL                 @"http://stressing.120v.cn"
    #define ZXIMAGE_PORT                @"80"
    //MARK: - Web药店地址
    #define ZXWEBSTORE_URL              @"http://192.168.0.206:8084/index.html"
    //MARK: - 静态网页端口
    #define ZXROOT_STATIC_URL           @"http://115.182.15.118:8005/"
    //MARK: - 企业版更新检测地址
    #define ENTERPRISE_CHECKUPDATE      @"http://115.182.15.118:8004/iOS/ydy_hyk_version.js"
#endif

//MARK: - BaiDuMap_Key
//#define ZX_BaiDuMap_Key @"L9UM2fezULCz2MESMhIIGkE19CekaPY7"
#define ZX_BaiDuMap_AppStore_Key   @"r0IXfei1iptvnOfsZSflfGKZ"
#define ZX_BaiDuMap_Enterprise_Key @"yjd7PTElGXikZTVgHBGOE0yd"

//MARK: - 测试账号
#define ZXAPP_Common_TestAccount          @"18888888888"
#define ZXAPP_Common_TestAccount_Password @"666666"

//MARK: - 默认公司经纬度
#define ZX_Detail_Longitude          @"104.063396"
#define ZX_Detail_Latitude           @"30.592061"


//MARK: - 接口详细地址定义
//MARK: - 资源地址
#define ZXAPI_RESOURCE_URL          @"hyk/pages/uploadFileApp"              //资源接口地址

//MARK: - 商城模块
#define ZXAPI_STORE_HOME            @"siteTemplate/view"                //店铺首页（分类、活动、推荐）
#define ZXAPI_STORE_INFO            @"drugstore/view"                   //药店详情
#define ZXAPI_STORE_CART            @"drugcounter/selectCartList"       //购物车列表
#define ZXAPI_DRUG_MARK             @"member/updateCollection"          //药品收藏
#define ZXAPI_DRUG_INFO             @"drugcounter/view"                 //药品详情
#define ZXAPI_DRUG_BALANCE          @"order/settleAccounts"             //结算
#define ZXAPI_SAVE_ORDER            @"order/saveOrder"                  //保存订单
#define ZXAPI_ORDER_COUPON          @"couponUseRecord/getCouponUseRecordList" //可用现金券

#define ZXAPI_DRUG_RECORD           @"browseRecord/addOrUpdate"         //添加商品浏览记录
#define ZXAPI_DRUG_RELATE           @"drugcounter/randList"             //药品详情 推荐商品
#define ZXAPI_STORE_RECOMMEND       @"browseRecord/list"                //猜您需药
#define ZXAPI_STORE_SEARCH          @"drugcounter/list"                 //分类列表、药品搜索列表
#define ZXAPI_STORE_ACTIVELIST      @"drugActive/list"                  //活动商品列表
#define ZXAPI_STORE_CATEGORY_TREE   @"drugsort/treelist"                //分类树

//MARK: - 发现界面
#define ZXAPI_DISCOVER_LIST         @"promotion/list"                  //发现列表
#define ZXAPI_DISCOVER_DETAIL       @"promotion/view"                  //返现详细内容

//MARK: - 加入会员
//读取剪贴板时,获取店铺名称,判断是否会员
#define ZXAPI_ISSTOREMEMBER       @"memberRelation/memberValidate"
#define ZXAPI_JOINMEMBER          @"memberRelation/addRelation"      //加入会员
#define ZXAPI_DRUGSTORE_DETAIL    @"drugstore/view"                  //药店详情
#define ZXAPI_FETCH_CASHCOUNPON   @"couponUseRecord/addMemberCoupon" //新会员关联历史现金券
#define ZXAPI_FETCH_PROMOTION     @"promotion/addMemberPromotion"    //新会员关联历史促销信息

//MARK: - 现金券
#define ZXAPI_CASHCOUPON_LIST     @"couponUseRecord/list"            //现金券列表
#define ZXAPI_CASHCOUPON_DETAIL   @"coupon/view"                     //现金券详情

//MARK: - 消息列表
#define ZXAPI_MESSAGE_LIST        @"message/list"                    //消息列表
#define ZXAPI_MESSAGE_DETAIL      @"message/view"                    //消息详情

//MARK: - 处方
#define ZXAPI_PRESCRIPTION_ADD    @"memberPrescription/add"          //新增处方
#define ZXAPI_PRESCRIPTION_DELETE @"memberPrescription/remove"       //删除处方
#define ZXAPI_PRESCRIPTION_LIST   @"memberPrescription/list"         //处方列表
#define ZXAPI_PRESCRIPTION_DETAIL @"memberPrescription/view"         //处方详情

//MARK: - 用户订单
#define ZXAPI_ORDER_LIST          @"order/list"                      //订单列表
#define ZXAPI_ORDER_DETAIL        @"order/view"                      //订单详情
#define ZXAPI_ORDER_UPDATE        @"order/update"                    //订单操作 取消 删除 确认收货
#define ZXAPI_ORDER_VIEWCODE      @"order/viewCode"                  //查看提货码

//MAKR: - 化验单
#define ZXAPI_REPORT_LIST         @"laboratorySheet/list"            //化验单列表
#define ZXAPI_REPORT_VIEW         @"laboratorySheet/view"            //化验单详情
#define ZXAPI_ANALYSERESUT_VIEW   @"laboratorySheet/viewAbnormal"    //分析结果
#define ZXAPI_CHECKITEM_LIST      @"laboratoryItem/list"             //检查项列表
#define ZXAPI_ADD_ANALYSE_REPORT  @"laboratorySheet/add"             //新增化验单
#define ZXAPI_DELETE_ANALYSE      @"laboratorySheet/remove"          //删除化验单

//MARK: - 药品收藏
#define ZXAPI_DRUGCOLLECT_LIST    @"memberCollection/list"           //收藏列表
#define ZXAPI_DRUGCOLLECT_DELETE  @"memberCollection/delete"         //删除记录

//MARK: - 用药提醒
#define ZXAPI_REMIND_LATER        @"remind/remindWait"               //稍后提醒
#define ZXAPI_TAKE_MEDICINE_LIST  @"remind/remindPush"               //用药提醒列表

//MARK: - 常量字典 未读消息
#define ZXAPI_CONST_DIC_LIST      @"dict/getDictList"                //常量列表
#define ZXAPI_UNREAD_MSGCOUNT     @"statistics/statisticsData"       //个人中心角标统计
//MARK: - 开启语音提醒
#define ZXAPI_VOICE_REMIND_UPDATE @"member/updateVoiceRemind"        //推送用药语音提醒


//MARK: - 资源存储文件夹
#define ZXAPI_Thumb_Path          @"member"                          //头像存储文件夹
#define ZXAPI_ChuFang_Path        @"prescription"                    //处方存储文件夹
#define ZXAPI_HYD_Path            @"laboratorySheet"                 //化验单存储文件夹

//MARK: - 登录模块
/** 登录*/
#define ZXAPI_Get_Verification_Code @"member/SMSVerificationCode"   //获取验证码URL
#define ZXAPI_Login @"member/login"//登录URL
#define ZXAPI_Update_Equipment @"member/updateEquipmentInfo"        //更新设备信息URL
#define ZXAPI_FlashScreen @"flashScreen/getFlashScreen"             //获取闪屏数据
#define ZXAPI_Update_Position @"member/updatePosition"              //更新会员信息
#define ZXAPI_Get_AgeGroup @"dict/getDictList"                      //获取年龄段
#define ZXAPI_Update_Sex @"member/updateSex"                        //更新性别
#define ZXAPI_Update_AgrGroups @"member/updateAgeGroups"            //更新年龄段

//MARK: - 地图模块
#define ZXAPI_Pharmacy_List @"drugstore/list"                       //附近药店、中医馆列表URL

//MARK: - 卡购药模块
#define ZXAPI_Query_Member_Card @"memberRelation/myCard"            //会员卡查询
#define ZXAPI_Closes_Drugstore_List @"drugstore/closestList"        //获取附近10条数据

//MARK: - 用药提醒模块
#define ZXAPI_DrugRemind_List @"remind/getListByMemberId"           //已添加提醒URL
#define ZXAPI_DrugRemind_TurnOn @"remind/isOpen"                    //用药提醒药品开启/关闭提醒URL
#define ZXAPI_Delete_DrugRemind @"remind/remove"                    //用药提醒药品删除
#define ZXAPI_Get_History_Drug_Order @"remind/getOrderByMemberId"   //用药提醒历史订单药品列表
#define ZXAPI_Add_TakeMedicine_Remind @"remind/add"                 //添加用药提醒
#define ZXAPI_Get_DictList_URL @"dict/getDictList"                  //药品单位以及用药周期URL
#define ZXAPI_Search_ByRemindTime @"remind/searchByRemindTime"      //用药提醒按提醒时间分类查询URL
#define ZXAPI_Modify_RemindTime @"remind/updateRemindTime"          //用药提醒修改提醒时间
#define ZXAPI_Remove_MyCard @"memberRelation/removeMyCard"          //删除我的会员卡

//MARK: - 编辑资料模块
#define ZXAPI_Modify_Profile_Sex @"member/updateSex"                //修改性别
#define ZXAPI_Modify_Profile_AgeGroups @"member/updateAgeGroups"    //修改年龄段
#define ZXAPI_Modify_Profile_HeadPortrait @"member/updateHeadPortrait"//更新会员头像
#define ZXAPI_Get_Profile_AgeGroup @"dict/getDictList"              //获取年龄段
#define ZXAPI_Receiver_Address @"memberAddress/getListByMemberId"   //收货地址清单
#define ZXAPI_Remove_Address @"memberAddress/remove"                //移除收货地址
#define ZXAPI_Set_Default_Address @"memberAddress/setDefault"       //设置默认收货地址
#define ZXAPI_Update_Receiver_Address @"memberAddress/update"       // 修改收货地址
#define ZXAPI_Delete_Receiver_Address @"memberAddress/remove"       //删除收货地址
#define ZXAPI_Add_Receiver_Address @"memberAddress/add"             //新增收货地址
#define ZXAPI_Modify_Name @"member/updateName"                      //修改用户名字

//MARK: - 设置模块
#define ZXAPI_Modify_Repeated_Reminders @"member/updateRepeatedReminders"//开启关闭重复提醒

//MARK: - 关于 && 用户协议
#define ZXAPI_ABOUT                         @"hyk/about/index.html?app_version="    //关于
#define ZXAPI_LICENSE_AGREEMENT             @"hyk/licenseAgreement/index.html"      //用户协议


#endif /* ZXAPIURL_h */
