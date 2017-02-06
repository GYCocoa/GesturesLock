//
//  TouchView.h
//  shoushi
//
//  Created by GY.Z on 2017/2/6.
//  Copyright © 2017年 GY.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchView;
@protocol LockViewDelegate <NSObject>

- (void)lockView:(TouchView *)lockView didFinishPath:(NSString *)path;

@end

@interface TouchView : UIView

@property(nonatomic,assign)id <LockViewDelegate> delegate;

@end
