# JINTools
Some userful tools
1.最初看到的是下面展示的一个赋值,表面上看来它就是通过get方法来给属性进行赋值的,实际上它是一个代理方法,这种方式是通过协议完成的.下面会通过一个Demo详细分析.
```
- (UIDynamicItemCollisionBoundsType)collisionBoundsType{
    return UIDynamicItemCollisionBoundsTypeEllipse;
}
```
