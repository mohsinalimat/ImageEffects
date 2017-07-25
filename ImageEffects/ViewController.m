//
//  ViewController.m
//  ImageEffects
//
//  Created by niexiaobo on 2017/7/25.
//  Copyright © 2017年 niexiaobo. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"
#define SCREENWIDTH          [[UIScreen mainScreen] bounds].size.width
@interface ViewController ()
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)NSMutableArray *sliderA;
@property(nonatomic,strong)NSMutableArray *labA;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     1.一行代码完成模糊设置:
     self.imageV.image = [image applyLightEffectcolor:0.14 alf:0.17 radiu:8.8 Factor:1.37];
     
     2.下面代码是界面:
     */
    
    NSArray *nameA = @[@"颜色:0.000",@"透明度:0.000",@"模糊:0.000",@"色彩:0.000"];
    NSArray *minA = @[@"0",@"0",@"0",@"0"];
    NSArray *maxA = @[@"1",@"1",@"50",@"3"];
    self.sliderA = [[NSMutableArray alloc]init];
    self.labA = [[NSMutableArray alloc]init];
    for (int i=0; i< 4; i++) {
        
        // 滑动条slider
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((SCREENWIDTH - 150) - 50, SCREENWIDTH + 50 + i * 40, 150, 20)];
        
        slider.minimumValue = [minA[i] integerValue];// 设置最小值
        slider.maximumValue = [maxA[i] integerValue];// 设置最大值
        slider.value = 0.0;// 设置初始值
        slider.continuous = YES;// 设置可连续变化
        //    slider.minimumTrackTintColor = [UIColor greenColor]; //滑轮左边颜色，如果设置了左边的图片就不会显示
        //    slider.maximumTrackTintColor = [UIColor redColor]; //滑轮右边颜色，如果设置了右边的图片就不会显示
        //    slider.thumbTintColor = [UIColor redColor];//设置了滑轮的颜色，如果设置了滑轮的样式图片就不会显示
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];// 针对值变化添加响应方法
        
        //label
        UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.origin.x - 135, slider.frame.origin.y, 130, 20)];
        minLabel.textAlignment = NSTextAlignmentRight;
        minLabel.text = nameA[i];
        [self.view addSubview:minLabel];
        [self.labA addObject:minLabel];
        slider.tag = i;
        [self.view addSubview:slider];
        
        [self.sliderA addObject:slider];
    }
    
    
    UIImage *image = [UIImage imageNamed:@"test"];
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH)];
    self.imageV.image = image;
    [self.view addSubview:self.imageV];
}

// slider变动时改变label值,获得调节参数
- (void)sliderValueChanged:(id)sender {
    
    float color = 0.0;
    float alf = 0.0;
    float radiu = 0.0;
    float Factor = 0.0;
    for (int i=0; i< 4; i++) {
        // 滑动条slider
        UISlider *slider = self.sliderA[i];
        UILabel *msgLab = self.labA[i];
        
        if (i == 0) {
            color = slider.value;
            msgLab.text = [NSString stringWithFormat:@"颜色:%.3f",color];
        } else if (i == 1) {
            alf = slider.value;
            msgLab.text = [NSString stringWithFormat:@"透明度:%.3f",alf];
        } else if (i == 2) {
            radiu = slider.value;
            msgLab.text = [NSString stringWithFormat:@"模糊:%.3f",radiu];
        } else if (i == 3) {
            Factor = slider.value;
            msgLab.text = [NSString stringWithFormat:@"色彩:%.3f",Factor];
        }
    }
    UIImage *image = [UIImage imageNamed:@"test"];
    self.imageV.image = [image applyLightEffectcolor:color alf:alf radiu:radiu Factor:Factor];
    
}

@end
