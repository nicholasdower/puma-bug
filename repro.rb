def run
  fork_safe = ->(t) { t }
  RubyVM::YJIT.enable

  i = 0

  begin
    while i < 100
      i += 1
      p i
      begin
        next if i
      rescue Interrupt
      end
    end
  ensure
  end
  p :ok
end

run