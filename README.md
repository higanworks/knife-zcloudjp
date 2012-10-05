# Knife::Zcloudjp

Knife(Opscode Chef) plugin for [Z Cloud](http://z-cloud.jp).

## Installation

Add this line to your application's Gemfile:

    gem 'knife-zcloudjp', :git => "git://github.com/higanworks/knife-zcloudjp.git"

And then execute:

    $ bundle

## Usage

Put your Z Cloud url and api token to .chef/knife.rb


    knife[:zcloud_api_token] = "YOUR-API-TOKEN"
    knife[:zcloud_api_url] = "https://my.z-cloud.jp"

### retrieve products

<pre><code>
$ knife zcloudjp product list (options)
name                   os            dataset                      package
SmartOS Small 1        SmartOS       sdc:sdc:smartos64:1.5.3      Small_1GB
SmartOS Medium 2       SmartOS       sdc:sdc:smartos64:1.5.3      Medium_2GB
SmartOS Medium 4       SmartOS       sdc:sdc:smartos64:1.5.3      Medium_4GB
SmartOS Large 8        SmartOS       sdc:sdc:smartos64:1.5.3      Large_8GB
SmartOS Plus Small 1   SmartOS       sdc:sdc:smartosplus64:3.0.7  Small_1GB
SmartOS Plus Medium 2  SmartOS       sdc:sdc:smartosplus64:3.0.7  Medium_2GB
SmartOS Plus Medium 4  SmartOS       sdc:sdc:smartosplus64:3.0.7  Medium_4GB
SmartOS Plus Large 8   SmartOS       sdc:sdc:smartosplus64:3.0.7  Large_8GB
MySQL Small 1          SmartOS       sdc:sdc:mysql:1.4.1          Small_1GB
MySQL Medium 2         SmartOS       sdc:sdc:mysql:1.4.1          Medium_2GB
MySQL Medium 4         SmartOS       sdc:sdc:mysql:1.4.1          Medium_4GB
MySQL Large 1          SmartOS       sdc:sdc:mysql:1.4.1          Large_8GB
</code></pre>

### print machine list

<pre><code>
$ knife zcloudjp machine list (options)
name               id                                    ips                  dataset                    package     state
Son_of_Jenkins_02  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:ubuntu10.04:0.1.0  Medium_2GB  running
chef-sv01          xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:ubuntu10.04:0.1.0  Small_1GB   running
shinobra           xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.1    Small_1GB   running
growthforecast     xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running
rabi01             xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running
zootest_south      xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running
</code></pre>


### create new machine and integration your chef server.

<pre><code>
$ knife zcloudjp machine create -I DATASET [-p PACKAGE] [-r role/recipie] (options)
</code></pre>

Chef bootstrap works fine on linux virtuamachine. But doesn't work on smartmachine(smartos).

#### workaround for smartos

Login smartmachine via ssh after provision. And copy chef-client manualy.

<pre><code>
# pkg_trans /tmp/chef-{version}.{arc}.solaris
# cp -rp chef/root/opt/chef /opt/
# /opt/chef/bin/chef-client
</code></pre>

client.rb and validation.pem are already stored to /etc/chef directory.  
chef-client command regists your smartmachine and perfomes run_list.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
