# Asciidoctor Template

Asciidoctorで日本語ドキュメントを作成するためのテンプレートです。

## 使い方

### 事前準備

foremanを利用するのでインストールしてください。
最初に一度、index.htmlを作成したほうが良いかもしれません。

```sh
$ gem install foreman
$ bundle install
$ bundle exec asciidoctor -D public src/index.adoc
```

### 普段の利用

foremanを立ち上げて、http://localhost:4000 にアクセスしてください。
src以下のファイルを変更すると、index.htmlが自動で作成・更新されます。

```sh
$ foreman start
```

## PDFの作成

### 事前準備

日本語フォントに、[源真ゴシック](http://jikasei.me/font/genshin/)を使用します。
genshinディレクトリを作成して、必要なファイルをダウンロードしてください。

```sh
$ mkdir genshin && cd genshin
$ wget https://ftp.iij.ad.jp/pub/osdn.jp/users/8/8637/genshingothic-20150607.zip
$ unzip genshingothic-20150607.zip
```

### コマンド

asciidoctor-pdfを使用してPDFを作成します。

```sh
$ bundle exec asciidoctor-pdf -r ./trail.rb -r ./ruby.rb -D public src/index.adoc
```

本文に数式が含まれる場合は、asciidoctor-mathematicalを使用します。

```sh
$ bundle exec asciidoctor-pdf -r ./trail.rb -r ./ruby.rb -r asciidoctor-mathematical -a mathematical-format=svg -D public src/index.adoc
```

※
asciidoctor-pdfが、pdfの作成に利用しているprawnが依存するttfunkは、
v1.8.0に日本語フォントに関するバグがあるので、v1.7.0を使用しています。


## プリプロセッサ

### trail.rb

Asciidoctorは英文を想定しているため、本文中の改行を分かち書きのためのスペースに変換します。
文章が日本語の場合は、不要な半角スペースが挿入されることになります。
trail.rbは、改行による半角スペースを削除します。

### ruby.rb

漢字などにフリガナ/ルビをふる拡張構文であるrbを追加します。
`rb::漢字[かんじ]` と書くと `<ruby>漢字<rp>（</rp><rt>かんじ</rt><rp>）</rp></ruby>` に変換します。
PDFでは `漢字 (かんじ)` に変換します。
