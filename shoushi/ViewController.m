//
//  ViewController.m
//  shoushi
//
//  Created by GY.Z on 2017/2/6.
//  Copyright © 2017年 GY.Z. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<LockViewDelegate>

@property(nonatomic,strong)UIImageView *bgImage;

@property(nonatomic,strong)TouchView *touchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

- (void)lockView:(TouchView *)lockView didFinishPath:(NSString *)path{
    if ([path isEqualToString:@"123456"]) {
        NSLog(@"密码正确");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSLog(@"密码错误");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)initUI{
    
    [self setupBgImage];
}

- (void)setupBgImage{
    self.bgImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgImage.image = [UIImage imageNamed:@"Home_refresh_bg"];
    [self.view addSubview:self.bgImage];
    
    self.touchView = [[TouchView alloc] init];
    self.touchView.delegate = self;
    [self.view addSubview:self.touchView];
}

//- (void)setupButton{
//    self.bgView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH-300)/2, (HEIGHT-300)/2, 300, 300)];
//    self.bgView.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:self.bgView];
//    
//    CGFloat WandH = 300;
//    CGFloat w = 70;
//    CGFloat h = 70;
//    CGFloat x = (WandH - w*3)/4;
//    CGFloat y = (WandH - h*3)/4;
//    
//    for (NSInteger i = 0; i < 9; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        CGFloat row = i/3;
//        CGFloat col = i%3;
//        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
//        btn.tag = i+1;
//        btn.frame = CGRectMake(x+col*(x+w),y+row*(y+h), w, h);
//        [self.bgView addSubview:btn];
//        btn.userInteractionEnabled = false;
//    }
//    
//}

//- (CGPoint)pointWithTouch:(NSSet *)touches{
//    //拿到触摸的点
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:touch.view];
//    return point;
//}
//
//- (UIButton *)buttonWithPoint:(CGPoint)point{
//    //根据触摸的点拿到响应的按钮
//    for (UIButton *btn in self.bgView.subviews) {
//        if (CGRectContainsPoint(btn.frame,point)) {
//            return btn;
//        }
//    }
//    return nil;
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //拿到触摸的点
//    CGPoint point = [self pointWithTouch:touches];
//    UIButton *btn = [self buttonWithPoint:point];
//    if (btn && btn.selected == false) {
//        btn.selected = true;
//    }
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //拿到触摸的点
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:touch.view];
//    //根据触摸的点拿到响应的按钮
//    for (UIButton *btn in self.bgView.subviews) {
//        if (CGRectContainsPoint(btn.frame, point)) {
//            btn.selected = true;
//        }
//    }
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //拿到触摸的点
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:touch.view];
//    //根据触摸的点拿到响应的按钮
//    for (UIButton *btn in self.bgView.subviews) {
//        if (CGRectContainsPoint(btn.frame, point)) {
////            btn.selected = true;
//        }
//    }
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self touchesEnded:touches withEvent:event];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
