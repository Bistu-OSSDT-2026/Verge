# Verge — 时间循环塔防游戏

> Demo 版（2周交付）

## 核心玩法
时间循环 × 角色塔防 × 黎明清屏爽感

## 目录结构
```
Verge/
├── project.godot            # Godot 项目配置（核心文件）
├── icon.svg                 # 项目图标
├── README.md                # 本项目说明
│
├── scripts/                 # GDScript 脚本
│   ├── core/                #   核心工具类（单例、信号总线等）
│   ├── game_manager/        #   全局游戏管理器（Autoload）
│   ├── time_cycle/          #   时间循环系统（白天/黄昏/夜晚/黎明）
│   ├── economy/             #   经济系统（金币、金矿）
│   ├── character/           #   角色脚本（先锋/近卫/狙击）
│   ├── enemy/               #   敌人脚本（杂兵/鬼影/精英）
│   ├── building/            #   建筑脚本（金矿、部署位等）
│   ├── ui/                  #   UI 脚本
│   └── utils/               #   工具函数
│
├── scenes/                  # .tscn 场景文件
│   ├── main_game/           #   主游戏场景共用组件
│   ├── tutorial/            #   教程关场景
│   ├── menu/                #   菜单场景
│   └── effects/             #   特效场景
│
├── levels/                  # 关卡配置
│   ├── tutorial/            #   教程关 "初次守候"
│   └── main_test/           #   正式关 "暗夜突袭"
│
├── resources/               # 数据配置
│   ├── config/              #   全局配置（game_config.json）
│   └── data/
│       ├── characters/      #   角色数据
│       ├── enemies/         #   敌人数据
│       ├── waves/           #   波次配置
│       └── economy/         #   经济配置
│
├── assets/                  # 美术/音频资源
│   ├── images/              #   图片
│   ├── animations/          #   动画
│   ├── audio/
│   │   ├── music/           #   音乐
│   │   └── sfx/             #   音效
│   ├── fonts/               #   字体
│   └── ui/                  #   UI 素材
│
├── models/                  # 3D 模型（如有）
├── addons/                  # Godot 插件
│
└── 策划书/                  # 策划文档（不纳入 Git）
```

## 开发计划
详见 `策划书/Verge_Demo版策划书.docx`

## 启动
在 Godot 中打开 `project.godot` 即可。
