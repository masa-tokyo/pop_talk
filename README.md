## 開発方法

0. flutterのversionを`2.2.1`以上に設定する(fvm推奨)

```bash
fvm use 2.2.1
```

1. `.env`ファイルを作成する

```bash
# 必要であればenvを書き換える
cp .env.example .env
```

2. 好きな方法でFlutterを動かす

```bash
fvm flutter pub get
fvm flutter run -d chrome
```
