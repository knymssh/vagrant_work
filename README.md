Vagrantセットアップ for Mac
==========

<h2>Vagrantインストール</h2>
<ol>
<li>VirtualBoxインストール</li>
<li>Vagrantインストール</li>
http://www.vagrantup.com/downloads.html
<pre>
$ vagrant -v
</pre>
<li>Vagrant Pluginインストール</li>
<pre>
$ vagrant plugin install vagrant-aws		// 仮想マシンにAWS EC2を使用
$ vagrant plugin install vagrant-omnibus		// 仮想マシンにChefを自動インストール
$ vagrant plugin install vagrant-proxyconf		// Proxy設定
$ vagrant plugin install sahara		// Sahara
</pre>
※インストール済プラグイン確認
<pre>
$ vagrant plugin list
</pre>
<li>boxファイル追加</li>
「box」とは、仮想サーバのイメージファイルを示す。
http://www.vagrantbox.es/
<pre>
$ vagrant box add {box名} {boxのURL}
$ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
</pre>
<li>任意の場所に作業用フォルダ生成</li>
<pre>
$ mkdir vagrant-sample
$ cd vagrant-sample
</pre>
<li>Vagrantfile準備</li>
「Vagrantfile」とは、仮想サーバ構築設定を記載するファイル。
<pre>
$ vagrant init {box名}
</pre>
<li>仮想サーバ起動</li>
<pre>
$ vagrant up
$ vagrant up --provider=aws
</pre>
<li>仮想サーバへのSSH接続</li>
<pre>
$ vagrant ssh
</pre>
</ol>
<h2>その他のコマンド</h2>
<ul>
<li>仮想サーバのシャットダウン＋破棄</li>
<pre>
$ vagrant destroy
</pre>
<li>仮想サーバのシャットダウン</li>
<pre>
$ vagrant halt
</pre>
<li>仮想サーバのサスペンド</li>
<pre>
$ vagrant suspend
</pre>
<li>仮想サーバの再起動</li>
<pre>
$ vagrant reload
</pre>
<li>仮想サーバの状態確認</li>
<pre>
$ vagrant status
</pre>
</ul>
