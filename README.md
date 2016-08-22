# ttest2stan
二群の平均値の差に関して，伝統的心理統計ではt検定を行いますが，ベイズ統計学的アプローチでは正規分布に関する事後分布から直接比較を行います。　

## 使い方
この関数は，あたかも伝統的心理統計で行われてきたt検定の関数のように，二群の平均値の差をベイズ的に検討するものです。
Rのもつt.test関数では，帰無仮説を ![equation](http://mathurl.com/z6xhd9c) ，対立仮説を ![equation](http://mathurl.com/zf8zspr) としますが，このttest2stan関数は ![equation](http://mathurl.com/z7ecrtw) という仮説が成立する割合を返します。

なお、このパッケージを使うためには`RStan`が必要です。

## 書き方
ttest2stan(x,y,c,paied=FALSE,iter=2000,warmup=1000,chains=4)

## 引数

引数 | 説明
---- | -------------
x,y  | 比較する二つのデータです
c    | ttest2stanは第一の仮説として![equation](http://mathurl.com/z4gzrj5)を検定しますが，第二の仮説として![equation](http://mathurl.com/hh844h8)を検証します。デフォルトは_0_になっています。実数を指定することが可能です。
paierd | TRUEであれば対応のある,FALSEであれば対応のないt検定をします。デフォルトはFALSEです。
iter | stanで反復する回数を指定します。デフォルトは2000です。
warmup | stanで反復する際のウォームアップ回数を指定します。デフォルトは1000です。
chains | stanで構成するMCMCチェインの数を指定します。デフォルトは4です。

## 出力

基本的にstanのprint関数で出力されるものがそのまま出てきます。

出力 | 説明
---- | -------------
mu1,mu2 | x,yの推定された平均値です
sigma1,sigma2 | x,yの推定された標準偏差です。
delta | 生成量での平均値の差です。
d_overC | ![equation](http://mathurl.com/hh844h8)になった割合です。

## 参考文献
豊田秀樹編著(2015) 基礎からのベイズ統計学　朝倉書店

