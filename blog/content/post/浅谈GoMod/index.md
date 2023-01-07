---
title: "浅谈GoMod"
date: 2021-11-28T16:24:57+08:00
tags:
  - Go
categories:
  - Devops
image: feature.png
draft: false
---

如果使用之前的**GOPATH**进行包管理的话会面临以下问题:

- **在不使用额外的工具的情况下，Go 的依赖包需要手工下载**
- **第三方包没有版本的概念，如果第三方包的作者做了不兼容升级，会让开发者很难受**
- **协作开发时，需要统一各个开发成员本地`$GOPATH/src`下的依赖包**
- **引用的包引用了已经转移的包，而作者没改的话，需要自己修改引用**
- **第三方包和自己的包的源码都在 src 下，很混乱。对于混合技术栈的项目来说，目录的存放会有一些问题**

新的包管理模式**go mod**解决了以上问题:

- **自动下载依赖包(有前提)**
- **项目不必放在 GOPATH/src 内了**
- **项目内会生成一个 go.mod 文件，列出包依赖**
- **所有来的第三方包会准确的指定版本号**
- **对于已经转移的包，可以用 replace 申明替换，不需要改代码**

## 准备工作

1.golang 版本必须支持 go mod

2.添加环境变量  **GO111MODULE**  为  **on**  或者**auto**

## 创建一个项目

首先，在$GOPATH/src 路径外的你喜欢的地方创建一个目录，cd 进入目录，新建一个 hello.go 文件，内容如下

```golang
     package main
     import (
         "fmt"
     )
     func main() {
         fmt.Println("Hello, world!")
     }
```

## 初始化模块

在当前目录下，命令行运行 go mod init + 模块名称 初始化模块

```golang
    go mod init hello
```

运行完后，会在当前项目目录下生成一个 go.mod 文件，这是一个关键文件，之后的包的管理都是通过这个文件管理。

> 官方说明：除了 go.mod 之外，go 命令还维护一个名为 go.sum 的文件，其中包含特定模块版本内容的预期加密哈希  
> go 命令使用 go.sum 文件确保这些模块的未来下载检索与第一次下载相同的位，以确保项目所依赖的模块不会出现意外更改，无论是出于恶意、意外还是其他原因。 go.mod 和 go.sum 都应检入版本控制。  
> go.sum 不需要手工维护，所以可以不用太关注。

生成出来的文件包含模块名称和当前的 go 版本号

```golang
    module hello
    go 1.17
```

**注意**：子目录里是不需要 init 的，所有的子目录里的依赖都会组织在根目录的 go.mod 文件里

## 看看 go mod 如何工作的

接下来，让项目依赖一下第三方包以大部分人都熟悉的 beego 为例吧！修改 Hello.go 文件：

```golang
    package main
    import "github.com/astaxie/beego"
    func main() {
        beego.Run()
    }
```

接下来执行 go run hello.go 然后会提示叫用 go get 下载引用第三方包，那就用呗。

下载完第三方包后，再次 go run hello.go 就跑起来啦！

## 问题：依赖的包下载到哪里了？

使用 Go 的包管理方式，依赖的第三方包被下载到了$GOPATH/pkg/mod 路径下。（可以自行更改下载路径）
