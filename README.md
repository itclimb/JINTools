# JINTools
Some userful tools
1.最初看到的是下面展示的一个赋值,表面上看来它就是通过get方法来给属性进行赋值的,实际上它是一个代理方法,这种方式是通过协议完成的.下面会通过一个Demo详细分析.
```
- (UIDynamicItemCollisionBoundsType)collisionBoundsType{
    return UIDynamicItemCollisionBoundsTypeEllipse;
}
```
2.首先,定义一个协议,协议中的的属性viewBackgroundColor是只读的,显然不能再通过set对其进行赋值,属性类型是个枚举值,只是为了更好的展示效果.
```
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JINViewBackgroudColorType) {
    JINViewBackgroudColorTypeBlack,
    JINViewBackgroudColorTypeRed,
    JINViewBackgroudColorTypeBlue
};

@protocol JINProperty <NSObject>

@optional
@property(nonatomic, readonly) JINViewBackgroudColorType viewBackgroundColor;

@end
```
3.在自定义的JINProtocolView中遵守协议(在.m中并没有实现属性的代理方法,因为它是可选的,没有什么关系).  在respondsToSelector中对枚举属性viewBackgroundColor进行判断,并实现相应的设置.这样在JINProtocolView的子类中,只需要通过实现代理方法,就能对枚举属性viewBackgroundColor赋值,并且实现对应的效果.
```
#import <UIKit/UIKit.h>
#import "JINProperty.h"

@interface JINProtocolView : UIView<JINProperty>

@end
```
```
#import "JINProtocolView.h"

@implementation JINProtocolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        if ([self respondsToSelector:@selector(viewBackgroundColor)]) {
            switch (self.viewBackgroundColor) {
                case JINViewBackgroudColorTypeBlack:
                    self.backgroundColor = [UIColor blackColor];
                    break;
                case JINViewBackgroudColorTypeBlue:
                    self.backgroundColor = [UIColor blueColor];
                    break;
                case JINViewBackgroudColorTypeRed:
                    self.backgroundColor = [UIColor redColor];
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}

@end
```
4.在测试子视图JINTestView中,实现代理方法,就能设置JINTestView的背景视图为蓝色.所以可以看出,所谓的用get方法给属性赋值,实际上是通过协议,利用代理方法来实现属性对应的效果
```
#import "JINProtocolView.h"

@interface JINTestView : JINProtocolView

@end
```
```
#import "JINTestView.h"

@implementation JINTestView

- (JINViewBackgroudColorType)viewBackgroundColor{
    return JINViewBackgroudColorTypeBlue;
}

@end
```
