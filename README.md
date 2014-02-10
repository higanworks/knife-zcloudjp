# Knife::Zcloudjp

[![Build Status](https://secure.travis-ci.org/higanworks/knife-zcloudjp.png)](http://travis-ci.org/higanworks/knife-zcloudjp)

A Knife(Opscode Chef) plugin for [Z Cloud](http://z-cloud.jp). This plugin allows you to retrieve product catalog, print the current machines and bootstrap a machine.

## F.Y.I

SmartOS Bootstrap template is here.

[higanworks/knife-bootstrap-smartos](https://github.com/higanworks/knife-bootstrap-smartos)


## Installation

### from Rubygems

    gem install knife-zcloudjp

### from github

Drop the following line into your application's `Gemfile`.

    gem 'knife-zcloudjp', :git => "git://github.com/higanworks/knife-zcloudjp.git"

And execute the `bundle` command.

    $ bundle

## Usage

Add the following entries to your `.chef/knife.rb`.

    knife[:zcloudjp_api_token] = "YOUR-API-TOKEN"
    knife[:zcloudjp_api_url] = "https://my.z-cloud.jp"

### Retrieve the product catalog that are currently available.

```
$ knife zcloudjp product list (options)
name                   os            dataset                     package   
MySQL Small 1          SmartOS       sdc:sdc:mysql:1.4.1         Small_1GB 
MySQL Medium 2         SmartOS       sdc:sdc:mysql:1.4.1         Medium_2GB
MySQL Medium 4         SmartOS       sdc:sdc:mysql:1.4.1         Medium_4GB
MySQL Large 1          SmartOS       sdc:sdc:mysql:1.4.1         Large_8GB 
Fedora Small 1         Fedora 14     sdc:sdc:fedora-14:1.0.1     Small_1GB 
Fedora Medium 2        Fedora 14     sdc:sdc:fedora-14:1.0.1     Medium_2GB
Fedora Medium 4        Fedora 14     sdc:sdc:fedora-14:1.0.1     Medium_4GB
Fedora Large 8         Fedora 14     sdc:sdc:fedora-14:1.0.1     Large_8GB 
CentOS Small 1         CentOS 5.7    sdc:jpc:centos-5.7:1.3.0    Small_1GB 
CentOS Medium 2        CentOS 5.7    sdc:jpc:centos-5.7:1.3.0    Medium_2GB
CentOS Medium 4        CentOS 5.7    sdc:jpc:centos-5.7:1.3.0    Medium_4GB
CentOS Large 8         CentOS 5.7    sdc:jpc:centos-5.7:1.3.0    Large_8GB 
Ubuntu Small 1         Ubuntu 10.04  sdc:sdc:ubuntu10.04:0.1.0   Small_1GB 
Ubuntu Medium 2        Ubuntu 10.04  sdc:sdc:ubuntu10.04:0.1.0   Medium_2GB
Ubuntu Medium 4        Ubuntu 10.04  sdc:sdc:ubuntu10.04:0.1.0   Medium_4GB
Ubuntu Large 8         Ubuntu 10.04  sdc:sdc:ubuntu10.04:0.1.0   Large_8GB 
SmartOS Plus Small 1   SmartOS       sdc:sdc:standard:1.0.7      Small_1GB 
SmartOS Plus Medium 2  SmartOS       sdc:sdc:standard:1.0.7      Medium_2GB
SmartOS Plus Medium 4  SmartOS       sdc:sdc:standard:1.0.7      Medium_4GB
SmartOS Plus Large 8   SmartOS       sdc:sdc:standard:1.0.7      Large_8GB 
Hadoop Small 1         SmartOS       sdc:sdc:hadoop:1.0.0        Small_1GB 
Hadoop Medium 2        SmartOS       sdc:sdc:hadoop:1.0.0        Medium_2GB
Hadoop Medium 4        SmartOS       sdc:sdc:hadoop:1.0.0        Medium_4GB
Hadoop Large 8         SmartOS       sdc:sdc:hadoop:1.0.0        Large_8GB 
Chef Server Small 1    SmartOS       sdc:sdc:chefserver:1.0.0    Small_1GB 
Chef Server Medium 2   SmartOS       sdc:sdc:chefserver:1.0.0    Medium_2GB
Chef Server Medium 4   SmartOS       sdc:sdc:chefserver:1.0.0    Medium_4GB
Chef Server Large 8    SmartOS       sdc:sdc:chefserver:1.0.0    Large_8GB 
Ubuntu Small 1         Ubuntu 12.04  sdc:jpc:ubuntu-12.04:2.4.1  Small_1GB 
Ubuntu Medium 2        Ubuntu 12.04  sdc:jpc:ubuntu-12.04:2.4.1  Medium_2GB
Ubuntu Medium 4        Ubuntu 12.04  sdc:jpc:ubuntu-12.04:2.4.1  Medium_4GB
Ubuntu Medium 8        Ubuntu 12.04  sdc:jpc:ubuntu-12.04:2.4.1  Large_8GB 
Debian Small 1         Debian 6.0.7  sdc:sdc:debian-6.0.7:2.4.1  Small_1GB 
Debian Medium 2        Debian 6.0.7  sdc:sdc:debian-6.0.7:2.4.1  Medium_2GB
Debian Medium 4        Debian 6.0.7  sdc:sdc:debian-6.0.7:2.4.1  Medium_4GB
Debian Large 8         Debian 6.0.7  sdc:sdc:debian-6.0.7:2.4.1  Large_8GB 
SmartOS Small 1        SmartOS       sdc:sdc:base64:13.1.0       Small_1GB 
SmartOS Medium 2       SmartOS       sdc:sdc:base64:13.1.0       Medium_2GB
SmartOS Medium 4       SmartOS       sdc:sdc:base64:13.1.0       Medium_4GB
SmartOS Large 8        SmartOS       sdc:sdc:base64:13.1.0       Large_8GB 
MongoDB Small 1        SmartOS       sdc:sdc:mongodb:1.4.5       Small_1GB 
MongoDB Medium 2       SmartOS       sdc:sdc:mongodb:1.4.5       Medium_2GB
MongoDB Medium 4       SmartOS       sdc:sdc:mongodb:1.4.5       Medium_4GB
MongoDB Large 8        SmartOS       sdc:sdc:mongodb:1.4.5       Large_8GB 
Node.js Small 1        SmartOS       sdc:sdc:nodejs:13.1.0       Small_1GB 
Node.js Medium 2       SmartOS       sdc:sdc:nodejs:13.1.0       Medium_2GB
Node.js Medium 4       SmartOS       sdc:sdc:nodejs:13.1.0       Medium_4GB
Node.js Large 8        SmartOS       sdc:sdc:nodejs:13.1.0       Large_8GB 
Percona Small 1        SmartOS       sdc:sdc:percona:13.1.0      Small_1GB 
Percona Medium 2       SmartOS       sdc:sdc:percona:13.1.0      Medium_2GB
Percona Medium 4       SmartOS       sdc:sdc:percona:13.1.0      Medium_4GB
Percona Large 8        SmartOS       sdc:sdc:percona:13.1.0      Large_8GB 
Riak Small 1           SmartOS       sdc:sdc:riak:13.1.0         Small_1GB 
Riak Medium 2          SmartOS       sdc:sdc:riak:13.1.0         Medium_2GB
Riak Medium 4          SmartOS       sdc:sdc:riak:13.1.0         Medium_4GB
Riak Large 1           SmartOS       sdc:sdc:riak:13.1.0         Large_8GB 
CentOS Small 1         CentOS 6.4    sdc:sdc:centos-6:2.4.1      Small_1GB 
CentOS Medium 2        CentOS 6.4    sdc:sdc:centos-6:2.4.1      Medium_2GB
CentOS Medium 4        CentOS 6.4    sdc:sdc:centos-6:2.4.1      Medium_4GB
CentOS Large 8         CentOS 6.4    sdc:sdc:centos-6:2.4.1      Large_8GB 
```


<pre><code>knife zcloudjp product list (options)
    -s, --server-url URL             Chef Server URL
    -k, --key KEY                    API Client Key
        --[no-]color                 Use colored output, defaults to enabled
    -c, --config CONFIG              The configuration file to use
        --defaults                   Accept default values for all questions
    -d, --disable-editing            Do not open EDITOR, just accept the data as is
    -e, --editor EDITOR              Set the editor to use for interactive commands
    -E, --environment ENVIRONMENT    Set the Chef environment
    -F, --format FORMAT              Which format to use for output
    -u, --user USER                  API Client Username
        --print-after                Show the data after a destructive operation
    -V, --verbose                    More verbose output. Use twice for max verbosity
    -v, --version                    Show chef version
    -y, --yes                        Say yes to all prompts for confirmation
    -K, --zcloudjp-api-token KEY     Your Z cloud API token
        --zcloudjp-api-auth-url URL  Your Z Cloud API url
    -h, --help                       Show this message
</code></pre>


### Print the machine list

    $ knife zcloudjp machine list (options)
    name               id                                    ips                  dataset                    package     state
    Son_of_Jenkins_02  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:ubuntu10.04:0.1.0  Medium_2GB  running
    chef-sv01          xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:ubuntu10.04:0.1.0  Small_1GB   running
    shinobra           xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.1    Small_1GB   running
    growthforecast     xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running
    rabi01             xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running
    zootest_south      xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  ["210.152.xxx.xxx"]  sdc:sdc:smartos64:1.5.3    Small_1GB   running

<pre><code>knife zcloudjp machine list (options)
    -s, --server-url URL             Chef Server URL
    -k, --key KEY                    API Client Key
        --[no-]color                 Use colored output, defaults to enabled
    -c, --config CONFIG              The configuration file to use
        --defaults                   Accept default values for all questions
    -d, --disable-editing            Do not open EDITOR, just accept the data as is
    -e, --editor EDITOR              Set the editor to use for interactive commands
    -E, --environment ENVIRONMENT    Set the Chef environment
    -F, --format FORMAT              Which format to use for output
    -u, --user USER                  API Client Username
        --print-after                Show the data after a destructive operation
    -V, --verbose                    More verbose output. Use twice for max verbosity
    -v, --version                    Show chef version
    -y, --yes                        Say yes to all prompts for confirmation
    -K, --zcloudjp-api-token KEY     Your Z cloud API token
        --zcloudjp-api-auth-url URL  Your Z Cloud API url
    -h, --help                       Show this message
</code></pre>

### Create a new machine and integrate it to the Chef Server

    $ knife zcloudjp machine create -I DATASET [-p PACKAGE] [-r role|recipie] (options)

Notice that the Linux virtual machine can be bootstrapped with the above command but the SmartMachine based on SmartOS can not be. To work out this issue, please refer to the following workaround.

#### Workaround for bootstrapping a machine based on SmartOS

Login into a newly provisonned machine based on SmartOS via ssh, and introduce the `chef-client` with the following commands.

    # pkg_trans /tmp/chef-{version}.{arc}.solaris
    # cp -rp chef/root/opt/chef /opt/
    # /opt/chef/bin/chef-client

`client.rb` and `validation.pem` may be already stored in the `/etc/chef` directory. Now `chef-client` command is available on your machine, so you can perfome `run_list` with it.

<pre><code>knife zcloudjp machine create (options)
        --bootstrap-version VERSION  The version of Chef to install
    -N, --node-name NAME             The Chef node name for your new node (default uuid)
    -s, --server-url URL             Chef Server URL
    -k, --key KEY                    API Client Key
        --[no-]color                 Use colored output, defaults to enabled
    -c, --config CONFIG              The configuration file to use
    -I DATASET_IMAGE,                Dataset image of the machine
        --dataset-image
        --defaults                   Accept default values for all questions
        --disable-editing            Do not open EDITOR, just accept the data as is
    -d, --distro DISTRO              Bootstrap a distro using a template; default is 'chef-full'
    -e, --editor EDITOR              Set the editor to use for interactive commands
    -E, --environment ENVIRONMENT    Set the Chef environment
    -j JSON_ATTRIBS,                 A JSON string to be added to the first run of chef-client
        --json-attributes
    -F, --format FORMAT              Which format to use for output
        --[no-]host-key-verify       Verify host key, disabled by default
    -i IDENTITY_FILE,                The SSH identity file used for authentication
        --identity-file
    -n, --machine-name NAME          Name tag value for your new machne (dafault uuid's first period)
    -u, --user USER                  API Client Username
    -p, --package PACKAGE            Package of machine; default is Small_1GB
        --prerelease                 Install the pre-release chef gems
        --print-after                Show the data after a destructive operation
    -r, --run-list RUN_LIST          Comma separated list of roles/recipes to apply
    -x, --ssh-user USERNAME          The ssh username; default is 'root'
        --template-file TEMPLATE     Full path to location of template to use
    -V, --verbose                    More verbose output. Use twice for max verbosity
    -v, --version                    Show chef version
    -y, --yes                        Say yes to all prompts for confirmation
    -K, --zcloudjp-api-token KEY     Your Z cloud API token
        --zcloudjp-api-auth-url URL  Your Z Cloud API url
    -M, --zcloud-metadata JSON       JSON string version of metadata hash to be supplied with the machine create call
    -h, --help                       Show this message
</code></pre>


### Start and stop machine.

Use '-n' option with UUID

    knife zcloudjp machine [start}stop] -n ${MACHINE_UUID}

<pre><code>$ knife zcloudjp machine start -n ********-****-****-****-********
Waiting state of machine changed to running... (Timeout: 10 seconds)
ID: ********-****-****-****-********
ip: 210.152.xxx.xxx
type: smartmachine
dataset: sdc:sdc:standard:1.0.7
state: running</code></pre>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## <a name="authors"></a> Authors

Created and maintained by [Sawanobori Yukihiko][author] (<sawanoboriyu@higanworks.com>)

## <a name="license"></a> License

Apache 2.0 (see [LICENSE][license])


[author]:           https://github.com/sawanoboly
[license]:          https://github.com/higanworks/knife-zcloudjp/blob/master/LICENSE
