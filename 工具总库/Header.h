//
//  Header.h
//  XiaoShenTu
//
//  Created by 张云飞 on 16/7/4.
//  Copyright © 2016年 万启鹏. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define LocalHost @"http://192.168.1.139:9001/xiaoshentu/"
#define TestHost  @"http://112.126.68.147:9001/xiaoshentu/"
//#define TestHost  @"http://192.168.1.108:9001/xiaoshentu/"
//创建群组
#define CreatGroup @"groups/add"
//获取群组信息
#define Groups @"groups"
//搜索好友
#define SearchFriend  @"users/search"
//发送邀请
#define inviteFriend @"friends/inviteds/add"
//获取好友信息
#define GetFriendInfo @"users"

//群组信息
#define GetGroupInfo @"groups"
//生活圈
#define Lifecircle @"lifecircle/growfootprint/getbypage"
//发送评论
#define SendComment @"comments/reply/add"
// 删除评论
#define DeleteComment @"comments/reply/delete"

#define sendHB @"redbags/sendeds"

//收红包
#define receiveHB @"redbags/receiveds"
#endif /* Header_h */
