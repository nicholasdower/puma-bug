## Without Puma

```ruby
def run
  fork_safe = ->(t) { t }
  RubyVM::YJIT.enable

  read, wakeup = IO.pipe
  Signal.trap("SIGCHLD") { wakeup.write("!") }

  begin
    while true
      begin
        fork { exit }

        next if read.wait_readable
      rescue Interrupt
      end
    end
  ensure
  end
end

run
```

```shell
ruby repro.rb
```

```shell
repro.rb:13:in 'Object#run': undefined method 'wait_readable' for nil (NoMethodError)

        next if read.wait_readable
                    ^^^^^^^^^^^^^^
	from repro.rb:21:in '<main>'
```

## With Puma

`puma.rb`

```ruby
workers 4

on_worker_boot { exit }
```

`config.ru`

```ruby
RubyVM::YJIT.enable
run ->(env) { [200, {"content-type" => "text/plain"}, ["ok"]] }
```

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
