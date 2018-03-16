//
//  JSExportText.h
//  JSCoreDemo
//
//  Created by 侑夕 on 2018/3/13.
//  Copyright © 2018年 侑夕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PersonProtocol <JSExport>
- (NSString *)fullName;
@end

@interface Person : NSObject <PersonProtocol>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@end
