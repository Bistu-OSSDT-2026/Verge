# 贡献指南

感谢你对 Verge 项目的关注！本文档说明如何参与项目贡献。

---

## 行为准则

- 尊重所有贡献者，友好沟通
- 对代码而非对人提出意见
- 接受建设性批评，专注于项目改进

---

## 如何贡献

### 1. 报告 Bug

如果你发现了 Bug，请在 GitHub Issues 中提交，并包含：

- Bug 的简要描述
- 复现步骤（越详细越好）
- 预期行为和实际行为
- 截图（如有）
- 你的操作系统和 Godot 版本

### 2. 提出新功能

新功能建议同样通过 Issue 提交，说明：

- 这个功能解决什么问题
- 建议的实现方式（可选）
- 对现有功能的影响

### 3. 提交代码

#### 开发流程

```bash
# 1. Fork 项目仓库
# 2. 克隆到本地
git clone https://github.com/你的用户名/Verge.git
cd Verge

# 3. 创建功能分支
git checkout -b feature/你的功能名

# 4. 在 Godot 中开发...

# 5. 提交你的改动
git add -A
git commit -m "简要描述你的改动"

# 6. 推送到你的 Fork
git push -u origin feature/你的功能名

# 7. 在 GitHub 上创建 Pull Request
```

#### 分支命名

- `feature/功能描述` — 新功能
- `fix/问题描述` — Bug 修复
- `docs/文档描述` — 文档修改

#### 提交信息规范

请使用清晰的中文或英文提交信息，例如：

- `修复胜利结算面板按钮无法点击`
- `调整敌人数值：杂兵 180→100 HP`
- `添加 GitHub Actions 自动导出工作流`

#### Pull Request 要求

- PR 描述中说明改了什么、为什么改、如何验证
- 确保代码在 Godot 4.x 中可以正常运行
- 尽量保持 PR 范围小且专注（一个 PR 解决一个问题）
- AI 辅助生成的代码需要实际运行验证过

### 4. 代码审查

- 所有 PR 需要至少一名其他成员 Review
- Review 时请提出具体的问题或建议，不要只说"LGTM"
- 根据 Review 意见修改后，重新推送即可，PR 会自动更新

---

## 开发环境

- **引擎**：Godot 4.x（推荐 4.7）
- **语言**：GDScript
- **渲染器**：gl_compatibility
- **分辨率**：1280×720

## 项目结构

```
Verge/
├── project.godot          # 项目配置
├── scenes/                # 场景文件
├── scripts/               # 源代码
│   ├── core/              # 核心模块
│   ├── character/         # 角色
│   ├── enemy/             # 敌人
│   ├── ui/                # 用户界面
│   └── ...
├── resources/             # 数据配置
└── docs/                  # 文档
```

---

## 许可

本项目采用 MIT License。贡献即表示你同意你的代码在同一许可证下发布。
