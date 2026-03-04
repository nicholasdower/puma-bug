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
