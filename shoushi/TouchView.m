//
//  TouchView.m
//  shoushi
//
//  Created by GY.Z on 2017/2/6.
//  Copyright © 2017年 GY.Z. All rights reserved.
//

#import "TouchView.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface TouchView ()

@property(nonatomic,strong)NSMutableArray *selectbtns;
@property(nonatomic,assign)CGPoint currentPoint;

@end

@implementation TouchView

- (NSMutableArray *)selectbtns{
    if (!_selectbtns) {
        _selectbtns = [NSMutableArray array];
    }
    return _selectbtns;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupButton];
    }
    return self;
}

- (void)setupButton{
    
    CGFloat WandH = 300;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat x = (WandH - w*3)/4;
    CGFloat y = (WandH - h*3)/4;
    
    for (NSInteger i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        CGFloat row = i/3;
        CGFloat col = i%3;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        btn.tag = i+1;
        btn.frame = CGRectMake(x+col*(x+w),y+row*(y+h), w, h);
        [self addSubview:btn];
    }
    self.frame = CGRectMake((WIDTH-300)/2, (HEIGHT-300)/2, 300, 300);
}

- (CGPoint)pointWithTouch:(NSSet *)touches{
    //拿到触摸的点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    return point;
}

- (UIButton *)buttonWithPoint:(CGPoint)point{
    //根据触摸的点拿到响应的按钮
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self pointWithTouch:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectbtns addObject:btn];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self pointWithTouch:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectbtns addObject:btn];
    }else{
        self.currentPoint = point;
    }
    //当视图发生变化的时候会调用这个方法
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //清除选中状态
//    [self.selectbtns makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    if ([self.delegate respondsToSelector:@selector(lockView:didFinishPath:)]) {
        NSMutableString *path = [NSMutableString string];
        for (UIButton *btn in self.selectbtns) {
            [path appendFormat:@"%ld",btn.tag];
        }
        [self.delegate lockView:self didFinishPath:path];
    }
    
    for (int i = 0; i < self.selectbtns.count; i++) {
        UIButton *btn = self.selectbtns[i];
        btn.selected = NO;
    }
    [self.selectbtns removeAllObjects];
    [self setNeedsDisplay];
    // 清空currentPoint
    self.currentPoint = CGPointZero;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
    
}

#pragma mark ---绘图
- (void)drawRect:(CGRect)rect{
    if (self.selectbtns.count == 0) {
        return;
    }
    //使用贝塞尔曲线进行连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor whiteColor] set];
    
    for (int i = 0; i < self.selectbtns.count; i++) {
        UIButton *btn = self.selectbtns[i];
        if (i == 0) {//设置起点
            [path moveToPoint:btn.center];
        }else{//连线
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:self.currentPoint];
    [path stroke];
}

@end
