//
//  JsonResponse.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#ifndef BaLaBaLa_JsonResponse_h
#define BaLaBaLa_JsonResponse_h

enum {
    
    /**
     *  服务器正常响应状态代码, 200
     */
    RESPONSE_STATUS_200 = 200,
    
    /**
     * 服务器500状态响应代码
     */
    RESPONSE_STATUS_500 = 500
};
typedef NSUInteger ResponseStatus;


#define JSON_NODE_RECORDSET @"recordset"
#define JSON_NODE_RECORD @"record"
#define JSON_NODE_PAGING_NAME @"paging"
#define JSON_NODE_STATUS_NAME @"status"
#define JSON_NODE_EXCEPTION_NAME @"exception"
#define JSON_NODE_EXCEPTION_MESSAGE_NAME @"exception_message"

#endif
