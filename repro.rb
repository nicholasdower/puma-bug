def run
  fork_safe = ->(t) { t }
  RubyVM::YJIT.enable

  read, wakeup = IO.pipe
  wakeup.write("!")

  begin
    while true
      begin
        next if read.wait_readable
      rescue Interrupt
      end
    end
  ensure
  end
end

run