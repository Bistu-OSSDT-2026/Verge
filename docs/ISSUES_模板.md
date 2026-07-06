# GitHub Issues 创建清单

> 在 GitHub 仓库页面的 Issues 标签中逐条创建以下 Issue。
> 创建后，在右侧 Assignees 中分配给对应成员，Labels 中选择对应标签。

---

## Issue 1: 项目启动 — 完善项目工程配置

**标题**: 完善项目工程配置（LICENSE + CONTRIBUTING + CI/CD）

**内容**:
```markdown
## 任务描述
项目缺少开源项目必需的基础文件，需要补充。

## 待完成
- [ ] 添加 MIT LICENSE 文件
- [ ] 添加 CONTRIBUTING.md 贡献指南
- [ ] 配置 GitHub Actions（GDScript 语法检查 + Godot 导出）

## 完成标准
- GitHub 仓库根目录存在 LICENSE 和 CONTRIBUTING.md
- GitHub Actions 工作流正常运行
```

**标签**: `documentation`, `enhancement`
**负责人**: 项目维护与协调

---

## Issue 2: 核心玩法 — 实现敌人阻挡逻辑

**标题**: [P0] 实现敌人阻挡逻辑（近战角色挡住敌人）

**内容**:
```markdown
## 问题描述
`character_base.gd` 中有 `block_count` 属性（先锋2/重装4），但 `enemy_movement.gd` 未实现阻挡检测。
敌人经过角色所在格子时不会停下来，直接穿过防线攻击核心。这是 PVZ 式塔防的核心机制，当前缺失。

## 期望行为
- 近战角色（先锋/重装）部署在路径格上时，经过该格的敌人被阻挡
- 阻挡数用完后，多余的敌人可以穿过
- 被阻挡的敌人与角色互相攻击

## 涉及文件
- `scripts/character/character_base.gd`
- `scripts/enemy/enemy_movement.gd`
```

**标签**: `bug`, `P0`
**负责人**: 功能开发

---

## Issue 3: 敌人系统 — 敌人视觉差异化

**标题**: [P0] 三种敌人视觉差异化（颜色区分）

**内容**:
```markdown
## 问题描述
三种敌人（混沌杂兵/迅捷鬼影/黑铁精英）目前视觉完全相同（绿色方块），无法在战斗中区分。

## 期望行为
- 混沌杂兵：绿色/青色
- 迅捷鬼影：黄色
- 黑铁精英：红色/暗色，体型稍大

## 实现方式
修改 `enemy.tscn` 中 AnimatedSprite2D 的 modulate 颜色，
或使用不同的 sprite_frames 资源。

## 涉及文件
- `scenes/main_game/enemy.tscn`
- `scenes/main_game/enemy_ghost.tscn`
- `scenes/main_game/enemy_elite.tscn`
```

**标签**: `enhancement`, `P0`
**负责人**: 功能开发

---

## Issue 4: UI 优化 — 设置面板实现音量控制

**标题**: 设置面板添加音量控制功能

**内容**:
```markdown
## 任务描述
暂停菜单中的"设置"面板目前显示"开发中"，需要实现音效和音乐的音量滑块控制。

## 待完成
- [ ] 添加音效音量滑块（0-100%）
- [ ] 添加音乐音量滑块（0-100%）
- [ ] 创建 AudioManager 单例管理音频
- [ ] 设置值保存到配置文件

## 涉及文件
- `scripts/ui/pause_menu.gd`
- 新建 `scripts/core/audio_manager.gd`
```

**标签**: `enhancement`
**负责人**: 功能开发

---

## Issue 5: 测试验证 — 完整运行与 Bug 修复

**标题**: 教学关完整运行测试与问题修复

**内容**:
```markdown
## 任务描述
按照测试清单完整运行教学关，记录发现的所有问题，并修复。

## 测试清单
- [ ] F5 启动 → splash_screen → 主菜单 → 章节选择 → 教学关
- [ ] 部署先锋/重装/狙击/金矿，确认金币扣减 + 角色出现
- [ ] Day 1~3 完整流程（白天/黄昏/夜晚/黎明）
- [ ] 胜利结算面板（星级 + 数据 + 按钮）
- [ ] 暂停菜单（继续/设置/返回章节/返回主菜单）
- [ ] 倍速 1x ↔ 2x 切换
- [ ] 失败结算面板（核心被摧毁）
- [ ] 从结算面板返回章节选择/主菜单

## 发现的问题
（测试后在此填写）
```

**标签**: `testing`
**负责人**: 测试与质量保证

---

## Issue 6: 项目文档 — 完善项目文档

**标题**: 完善项目文档（使用说明 + 策划书 + 开发日志）

**内容**:
```markdown
## 任务描述
完善项目文档，确保新成员能够快速上手。

## 待完成
- [ ] 更新使用说明（环境要求/安装步骤/操作指南）
- [ ] 整理策划书文档
- [ ] 更新开发进度日志
- [ ] 确保 README 与实际项目状态一致

## 涉及文件
- `使用说明.txt`
- `README.md`
- `docs/progress.md`
- `docs/开发日志.md`
```

**标签**: `documentation`
**负责人**: 项目文档

---

## Issue 7: 版本发布 — Demo v1.0 发布准备

**标题**: 准备 Demo v1.0 版本发布

**内容**:
```markdown
## 任务描述
完成 Demo v1.0 版本的最终检查和发布。

## 待完成
- [ ] 删除测试快捷键（F3/F4）
- [ ] 最终验证核心使用流程
- [ ] 打版本 Tag（v1.0.0）
- [ ] 创建 GitHub Release 并编写 Release Notes
- [ ] 确保 README 中的操作说明与实际一致

## Release Notes 要点
- 3天完整时间循环
- 3种角色 + 3种敌人
- 完整 UI（暂停/胜利/失败）
- 已知限制（无阻挡逻辑/无音效/敌人视觉未区分）
```

**标签**: `release`
**负责人**: 发布与项目工程
