//
//  ViewController.m
//  Xcode5LocalizeSample
//
//  Created by Dolice on 2014/02/14.
//  Copyright (c) 2014年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

CGFloat const LOCALIZED_LABEL_WIDTH  = 320;
CGFloat const LOCALIZED_LABEL_HEIGHT = 64;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 画像配置
    [self setLocalizedImage];
    
    // ラベル配置
    [self setLocalizedLabel];
}

// 画像配置
- (void)setLocalizedImage
{
    UIImageView *localizedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    localizedImage.image = [self getLocalizedImageWithName:@"title" ext:@"png"];
    [self.view addSubview:localizedImage];
}

// ラベル配置
- (void)setLocalizedLabel
{
    UILabel *localizedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.center.y - (LOCALIZED_LABEL_HEIGHT / 2), LOCALIZED_LABEL_WIDTH, LOCALIZED_LABEL_HEIGHT)];
    localizedLabel.text = NSLocalizedString(@"sampleText", nil);
    localizedLabel.font = [UIFont systemFontOfSize:12.0f];
    localizedLabel.textColor = [UIColor blackColor];
    localizedLabel.textAlignment = NSTextAlignmentCenter;
    localizedLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:localizedLabel];
}

// ローカライズ画像取得
- (UIImage *)getLocalizedImageWithName:(NSString *)name ext:(NSString *)ext
{
    UIImage *localizedImage;
    if ([self isJapaneseLanguage]) {
        localizedImage = [self getUIImageFromResources:name ext:ext];
    } else {
        localizedImage = [self getUIImageFromResources:[NSString stringWithFormat:@"%@%@", name, @"_en"] ext:ext];
    }
    return localizedImage;
}

// 言語設定取得
- (BOOL)isJapaneseLanguage
{
    static BOOL isJapanese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage compare:@"ja"] == NSOrderedSame;
    });
    return isJapanese;
}

// 画像ファイル取得
- (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    return (img);
}

@end
