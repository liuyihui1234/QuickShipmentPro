//
//  ConfigDefine.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/28.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#ifndef ConfigDefine_h
#define ConfigDefine_h
/*------ 环境相关 ------*/
#define ONLINE 0 // 环境切换 正式1 测试0

//正式环境
#define ONLINE_HOST @"http://www.k8yz.com/"

//测试环境
#define TEST_HOST @"http://192.168.1.211:8081/"

#if ONLINE
#define KBHOST ONLINE_HOST
#else
#define KBHOST TEST_HOST
#endif

#endif /* ConfigDefine_h */
