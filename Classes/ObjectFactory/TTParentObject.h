//
//  TTParentObject.h
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//
//  Если бы не требовалось описывать базовую реализацию - можно было бы обойтись протоколом.
//  Но в данном случае в родительском объекте я делаю метод для раскрашивания нужного UIView.

#import <Foundation/Foundation.h>

@interface TTParentObject : NSObject

- (void)onRecieve;
- (void)changeBgColorTo:(UIColor *)color;

@end
