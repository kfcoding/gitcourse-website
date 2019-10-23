---
title: Quick Start
description: Quick Start.
date: 2018-03-16
categories: [getting started,fundamentals]
keywords: []
menu:
  docs:
    parent: "getting-started"
    weight: 30
weight: 60
sections_weight: 60
draft: false
toc: true
---


# GitCourse 说明

## GitCourse项目结构

每一个GitCourse项目根目录下都含有一个course.json，course.json定义了全部与课程相关的配置信息如标题、作者、场景等。 一个典型的GitCourse目录结构如下所示：

```
- 项目根目录
|- course.json
|- shell
	|-- 1.1-check.sh
	|-- 1.2-check.sh
|- scenario
	|-- 1.1-sample1.md
	|-- 1.2-sample2.md
|- script
	|-- auth.js
	|-- complete.js
	|-- preload.js
|- ...其它文件或者目录
```

course.json里包含了什么？ 首先请看一个简单的course.json实例:

```
{
  "version": "1",
  "title": "Flink 教程",
  "author": "GitCourse",
  "description": "Apache Flink is an open source platform for distributed stream and batch data processing. Flink’s core is a streaming dataflow engine that provides data distribution, communication, and fault tolerance for distributed computations over data streams. Flink builds batch processing on top of the streaming engine, overlaying native iteration support, managed memory, and program optimization.",
  "scenarios": [
    {
      "title": "Flink环境搭建",
      "environment": "registry.cn-shanghai.aliyuncs.com/kfcoding/kfcoding-envs:cloudware-base",
      "steps": [
        {
          "title": "Setup: Download and Start Flink",
          "text": "scenario/text.md",
          "check": "shell/check.sh",
          "preload": "script/preload.js",
          "extraTab": "https://baidu.com"
        },
        {
          "title": "第二步",
          "text": "scenario/text.md"
        }
      ]
    },
    {
      "title": "Flink环境测试",
      "environment": "registry.cn-shanghai.aliyuncs.com/kfcoding/kfcoding-envs:nb-golang",
      "steps": [
        {
          "title": "环境测试",
          "text": "setup/text.md",
          "program": "shell/bg.sh",
          "extraTab": "[domain]:[:8888]/notebooks/main.ipynb"
        },
        {
          "title": "环境测试2",
          "text": "scenario/text.md",
          "program": "shell/bg.sh",
          "extraTab": "[domain]:[:8888]/notebooks/basic%20knowledge/1.ipynb"
        }
      ]
    }
  ]
}
```

如你所见，course.json文件是一个简单的json对象，其内容也是非常清晰且易于阅读，其字段定义如下所示：

| 字段          | 类型     | 默认值  | 说明                            |
|-------------|--------|------|-------------------------------|
| version     | string | "1"  | 所使用的GitCourse解释器版本，目前只支持版本"1" |
| title       | string | ""   | 课程标题                          |
| author      | string | ""   | 作者                            |
| description | string | ""   | 课程简介                          |
| scenarios   | array  | \[\] | 课程的场景，将会按顺序逐个进行解析             |


## 场景

course.json中的scenarios字段是一组包含必要信息来构建交互式学习场景的scenario，例如：

```
{
  "title": "Flink环境测试",
  "environment": "registry.cn-shanghai.aliyuncs.com/kfcoding/kfcoding-envs:nb-golang",
  "steps": [
    {
      "title": "环境测试",
      "text": "setup/text.md",
      "program": "shell/bg.sh",
      "extraTab": "[domain]:[:8888]/notebooks/main.ipynb"
    },
    {
      "title": "环境测试2",
      "text": "scenario/text.md",
      "program": "shell/bg.sh",
      "extraTab": "[domain]:[:8888]/notebooks/basic%20knowledge/1.ipynb"
    }
  ]
}
```

| 字段               | 类型     | 默认值       | 说明                                |
|------------------|--------|-----------|-----------------------------------|
| title            | string | ""        | 场景打开时显示的标题                        |
| description      | string | ""        | 场景的描述                             |
| shell            | string | "/bin/sh" | 指定终端使用/bin/sh还是/bin/bash          |
| docker\_endpoint | string | ""        | 所使用的docker服务的地址，不指定则使用全局地址        |
| environment      | string | null      | 本场景所使用的容器镜像地址                     |
| steps            | array  | \[\]      | 场景的步骤，将会按顺序逐个进行解析，以供学员分步骤完成本场景的学习 |

## 步骤

scenario对象中的steps字段是一组step对象，例如：

```
{
  "title": "环境测试",
  "text": "setup/text.md",
  "program": "shell/bg.sh",
  "extraTab": "[domain]:[:8888]/notebooks/main.ipynb"
}
```

其字段定义如下所示：

| 字段       | 类型     | 默认值  | 说明                                                               |
|----------|--------|------|------------------------------------------------------------------|
| title    | string | ""   | 此步骤的标题                                                           |
| text     | string | null | markdown文件的相对路径，用于在此步骤中展示                                        |
| preload  | string | null | javascript脚本的相对路径，步骤初始化时在浏览器端执行                                  |
| program  | string | null | shell脚本的相对路径，步骤初始化时在容器中执行                                        |
| check    | string | null | shell脚本的相对路径，用户点击完成步骤时在容器中执行，用于检查完成情况。当脚本检查通过后应当输出1，否则用户不会进入下一步。 |
| extraTab | string | null | 除了默认的终端之外，可以额外使用的容器交互接口。将在一个iframe中访问指定的容器端口与路径。                 |

extraTab的示例如下：

```
[domain]:[:8888]/notebooks/main.ipynb
```

当指定uri的host为[domain]时，将在步骤初始化时尝试访问本场景容器实例相应端口的服务。在此示例中[:8888]指定了访问容器内部在8888端口监听的服务，路径为/notebooks/main.ipynb，GitCourse将自动进行NAT端口映射，您无须关注访问的具体过程。当uri的host并未被指定时，将会直接在iframe中进行加载。
