# さくらレンタルサーバーのMYSQLをバックアップ(dump)するスクリプト

毎回ウェブ上でログインしてバックアップとるのが面倒臭いので作ったスクリプト

## スクリプト処理内容
1. ssh接続
1. mysqldumpコマンドで`$BACKUP_FILE_NAME`に指定されたパスにファイルをバックアップ & 保存
1. rsyncコマンドで上記でバックアップしたサーバー上のファイルを指定したローカル場所に持ってくる
以上

## 設定方法
> 下記のように設定 **dump_sakura_db.sh**ファイルを編集
```bash:
# set ssh info
SSH_HOST=hogehoge.sakura.ne.jp #サーバーネーム
SSH_USER=hogehoge　　　　　　　　#サクラレンタルサーバーユーザID
SSH_PASS=passwd                 #サクラレンタルサーバーパスワード

# set mysql info
DB_HOST=mysqlxxx.db.sakura.ne.jp　#ｍｙｓｑｌアドレス
DB_USER=hogehoge                  #ｍｙｓｑｌユーザ名
DB_PASS=dbpasswd                  #ｍｙｓｑｌパスワード
DB_NAME=dbname                    #ｍｙｓｑｌDB名

# set file info
BACKUP_FILE_NAME=/home/${SSH_USER}/product_db_`date "+%Y%m%d%H%M"`.sql
LOCAL_FOLDER=${DIR}/backiup/
LOGFILE=${DIR}/log.log
 ```
 
 ## 実行
 `$ sh dump_sakura_db.sh`
