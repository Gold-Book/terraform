- コマンドは直下でやる
- terraform.tfvarsでval解決してもvariables.tfで定義してやらないと環境作成とかで解決できないので定義してやる
- 基本的に直下にあるtfファイル読んでリソース作って、作ったリソースを参照したい場合は「id」とか「dns_name」とか指定してやれば出来る
- ディレクトリ構成は要検討、リソースがばらけるとしんどいので考える

- 環境作成
  - terraform init
  - プラグインとかのモジュールとってくるだけっぽいので1回たたけば良い
  - pluginとか追加したらまたやらないと多分動かない

- 環境確認
  - terraform plan
  - 環境を作成した場合の状況一覧を表示する、実際には環境作成しない

- 環境作成
  - terraform apply
  - 環境作成する
  - 途中で失敗すると中途半端に環境が残るので、こけたらdestroyする

- 環境削除
  - terraform destroy


- 以下old 環境情報(devとかprodとか)をworkspaceで行えるっぽいけどベストプラクティスがぶれぶれすぎて使えないかも よーわからん
- 環境作成
  - terraform workspace new dev

- 環境設定
  - terraform workspace select development

- 環境確認(多分必要なのでenv指定)
  - $ terraform plan

- 環境作成(多分必要なのでenv指定)
  - terraform apply

- ホスト環境変数参照
  - TF_VAR_HOGE
    - e.g. TF_VAR_access_key=foo
