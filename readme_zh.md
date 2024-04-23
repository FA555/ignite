Ignite 是一个美观的索引文档生成工具，适用于开卷考试、文档等场景。

Readme 中文 | [English](readme.md)

## 前置

- Python 3.4+ (with pip)
- Typst

## 如何使用

### 索引文件语法

首先将索引内容写入 `data/index.txt` 中。索引文件由若干行构成。除空行（会被忽略）外，任何一行应当符合两种格式之一：

1. 以 `<` 开头且以 `>` 结尾，表示章节划分。尖括号以内的内容会被视为章节标题。
2. 由任意内容加末尾的一个数字构成，表示一个条目。数字的语义是该条目的页码。

### 生成文档

```bash
python3 -m pip install -r requirements.txt
python3 main.py
typst compile index.typ
# 将生成 index.pdf
```

调整格式细节请自行查看并修改 `index.typ`。

## 示例

我们已经在 `example/` 下提供了一组示例。你可以通过以下命令生成示例文档：

```bash
typst compile index.typ --input data-dir=example
# 将生成 index.pdf
```

![示例文档 P1](img/1.png)

![示例文档 P2](img/2.png)
