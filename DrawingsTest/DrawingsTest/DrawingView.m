//
//  DrawingView.m
//  DrawingsTest
//
//  Created by Eugene Butkevich on 8/9/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    NSLog(@"drawRect %@", NSStringFromCGRect(rect));
    
//    [self drawSomething:rect];
    [self drawChess:rect];
}

-(void) drawSomething:(CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect square1 = CGRectMake(100, 100, 100, 100);
    CGRect square2 = CGRectMake(200, 200, 100, 100);
    CGRect square3 = CGRectMake(300, 300, 100, 100);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //    CGContextAddRect(context, rect);
    //    CGContextFillPath(context);
    //    CGContextFillRect(context, rect);   //Закомментированные 2 строчки выше и эта выполняют одно и то же
    CGContextAddRect(context, square1);
    CGContextAddRect(context, square2);
    CGContextAddRect(context, square3);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextAddEllipseInRect(context, square1);
    CGContextAddEllipseInRect(context, square2);
    CGContextAddEllipseInRect(context, square3);
    CGContextFillPath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 3.f);
    CGContextSetLineCap(context, kCGLineCapRound);      //делает концы линии скругленными
    CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
    CGContextAddLineToPoint(context, CGRectGetMinX(square3), CGRectGetMaxY(square3));
    CGContextMoveToPoint(context, CGRectGetMaxX(square3), CGRectGetMinY(square3));
    CGContextAddLineToPoint(context, CGRectGetMaxX(square1), CGRectGetMinY(square1));
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddArc(context, CGRectGetMaxX(square1), CGRectGetMaxY(square1), CGRectGetWidth(square1), M_PI, 0, YES);
    CGContextMoveToPoint(context, CGRectGetMaxX(square3), CGRectGetMinY(square3));
    CGContextAddArc(context, CGRectGetMinX(square3), CGRectGetMinY(square3), CGRectGetWidth(square3), 0, M_PI, YES);
    CGContextStrokePath(context);
    
    NSString* text = @"test";
    UIFont* font = [UIFont systemFontOfSize:14.f];
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowBlurRadius = 0.5;
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:  [UIColor grayColor], NSForegroundColorAttributeName,
                                font,   NSFontAttributeName,
                                shadow, NSShadowAttributeName,nil];
    CGSize textSize = [text sizeWithAttributes:attributes];
    CGRect textRect = CGRectMake(CGRectGetMidX(square2) - textSize.width / 2,
                                 CGRectGetMidY(square2) - textSize.height / 2, textSize.width, textSize.height);
    textRect = CGRectIntegral(textRect);    // Данная функция округляет значения ширины и высоты и тем самым спасает от размытостей
    [text drawInRect:textRect withAttributes:attributes];
}

-(void) drawChess:(CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat offset = 50.f;
    CGFloat borderWidth = 2.f;
    CGFloat maxBoardSize = MIN(CGRectGetWidth(rect) - 2*offset - 2*borderWidth, CGRectGetHeight(rect) - 2*offset - 2*borderWidth);
    int cellSize = (int) maxBoardSize / 8;
    int boardSize = 8 * cellSize;
    CGRect boardRect = CGRectMake((CGRectGetWidth(rect) - boardSize) / 2, (CGRectGetHeight(rect) - boardSize) / 2,
                                  boardSize, boardSize);
    boardRect = CGRectIntegral(boardRect);
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (i % 2 != j % 2) {
                CGRect cellRect = CGRectMake(CGRectGetMinX(boardRect) + i*cellSize,
                                             CGRectGetMinY(boardRect) + j*cellSize,
                                             cellSize, cellSize);
                CGContextAddRect(context, cellRect);
            }
        }
    }
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, borderWidth);
    CGContextAddRect(context, boardRect);
    CGContextStrokePath(context);
}

@end
