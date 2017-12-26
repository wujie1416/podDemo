//
//  HYDWebImage.m
//  podDemo
//
//  Created by wujie on 2017/12/18.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "HYDWebImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface HYDWebImage ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image;

@end

@implementation HYDWebImage

//下载图片
- (void)setImage
{
    [self.imageView sd_setImageWithURL:self.url];
    
    [self.imageView sd_setImageWithURL:self.url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [self.imageView sd_setAnimationImagesWithURLs:@[self.url,self.url]];

    [self.imageView sd_setImageWithURL:self.url placeholderImage:self.image];
    
    [self.imageView sd_setImageWithURL:self.url placeholderImage:self.image options:SDWebImageLowPriority];
    
    [self.imageView sd_setImageWithURL:self.url placeholderImage:self.image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [self.imageView sd_setImageWithURL:self.url placeholderImage:self.image options:SDWebImageLowPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [self.imageView sd_setImageWithURL:self.url placeholderImage:self.image options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:self.url placeholderImage:self.image options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

//UIImageView(WebCache) 分类的核心在于 SDWebImageManager 的下载和缓存处理，SDWebImageManager将图片下载和图片缓存组合起来了。SDWebImageManager也可以单独使用
- (void)load
{
    [[SDWebImageManager sharedManager] loadImageWithURL:self.url options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
    }];
}

//我们还可以单独使用 SDWebImageDownloader 来下载图片，但是图片内容不会缓存。
- (void)downLoad
{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:self.url options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
    }];
}

- (void)getSize
{
    [[SDImageCache sharedImageCache] getSize];
    [[SDImageCache sharedImageCache] getDiskCount];
}

//清理内存缓存，清理内存中缓存的图片资源，释放内存资源。
- (void)clearMemory
{
    [[SDImageCache sharedImageCache] clearMemory];
}

//有了清理内存缓存，自然也有清理磁盘缓存的接口
- (void)clearDisk
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];
}

//SDImageCache 支持内存缓存和异步的磁盘缓存（可选），如果你想单独使用 SDImageCache 来缓存数据的话，可以使用单例，也可以创建一个有独立命名空间的 SDImageCache 实例。
- (void)storeImageToDisk
{
    [[SDImageCache sharedImageCache] storeImage:self.image forKey:@"" completion:^{
        
    }];
}

//默认情况下，图片数据会同时缓存到内存和磁盘中，如果你想只要内存缓存的话，可以使用下面的方法：
- (void)storeImageToMemory
{
    [[SDImageCache sharedImageCache] storeImage:self.image forKey:@"" toDisk:NO completion:^{
        
    }];
}

//读取缓存时可以使用 queryDiskCacheForKey:done: 方法，图片缓存的 key 是唯一的，通常就是图片的 absolute URL。
- (void)readImage
{
    SDImageCache *imageCache = [[SDImageCache alloc] initWithNamespace:@""];
    [imageCache queryCacheOperationForKey:@"" done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
        
    }];
}

// 自定义缓存 key
//有时候，一张图片的 URL 中的一部分可能是动态变化的（比如获取权限上的限制），所以我们只需要把 URL 中不变的部分作为缓存用的 key。
- (void)setKey
{
    [[SDWebImageManager sharedManager] setCacheKeyFilter:^NSString * _Nullable(NSURL * _Nullable url) {
        return [url absoluteString];
    }];
}



@end
