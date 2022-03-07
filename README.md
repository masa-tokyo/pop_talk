# アプリ説明
Flutter大学の共同開発チームで作成したアプリです。
○音声配信アプリ『ポップトーク』
iOS版: https://apps.apple.com/app/id1586833764
Android版: https://play.google.com/store/apps/details?id=com.yamyanu.poptalk

# 開発方法

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

# 本番ビルド

- pubspec.yamlのversionを新しいバージョンに変更

```shell
version: 1.0.0+1 (versionName+versionCode)
#↓
version: 2.0.0+2
```

## iOSビルド

```shell
fvm flutter build ipa
```

できたファイルをxcodeで開いてapp store connectにアップロード

## Androidビルド

1. ./android/key.propertiesファイルを設置する

2. key.propertiesにkeystore(jks)の情報を記述する

```
storePassword={{ store pass }}
keyPassword={{ key pass }}
keyAlias={{ key alias = key }}
storeFile={{ key.jksの絶対パス }}
```

3. ビルドコマンドを叩く

```shell
fvm flutter build appbundle
```

4. できたファイルを[内部アプリ共有](https://play.google.com/console/u/0/internal-app-sharing)
   にアップロードしてテスト

## Firebase関連デプロイ

```shell
# CloudFunctionデプロイ
cd functions
npm run deploy -- --project poptalk-production
cd -
# セキュリティルールデプロイ
firebase deploy --only firestore:rules --project poptalk-production
# firestoreインデックスデプロイ
firebase deploy --only firestore:indexes --project poptalk-production
# RemoteConfigデプロイ
firebase deploy --only remoteconfig --project poptalk-production
```

## Webビルド

```shell
# ビルド
fvm flutter build web

# デプロイ
firebase deploy --only hosting --project poptalk-production
```
