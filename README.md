```shell
bundle install
bundle exec ruby -S puma config.ru -C puma.rb
```

```
/Users/nickdower/.rvm/gems/ruby-4.0.0/gems/puma-7.2.0/lib/puma/cluster.rb:471:in 'Puma::Cluster#run': undefined method 'wait_readable' for nil (NoMethodError)

            if read.wait_readable([0, @next_check - Time.now].max)
                   ^^^^^^^^^^^^^^
	from /Users/nickdower/.rvm/gems/ruby-4.0.0/gems/puma-7.2.0/lib/puma/launcher.rb:208:in 'Puma::Launcher#run'
	from /Users/nickdower/.rvm/gems/ruby-4.0.0/gems/puma-7.2.0/lib/puma/cli.rb:73:in 'Puma::CLI#run'
	from /Users/nickdower/.rvm/gems/ruby-4.0.0/gems/puma-7.2.0/bin/puma:10:in '<top (required)>'
	from /Users/nickdower/.rvm/rubies/ruby-4.0.0/lib/ruby/4.0.0/rubygems.rb:303:in 'Kernel#load'
	from /Users/nickdower/.rvm/rubies/ruby-4.0.0/lib/ruby/4.0.0/rubygems.rb:303:in 'Gem.activate_and_load_bin_path'
	from /Users/nickdower/.rvm/gems/ruby-4.0.0/bin/puma:25:in '<main>'
```
