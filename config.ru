RubyVM::YJIT.enable
run ->(env) { [200, {"content-type" => "text/plain"}, ["ok"]] }
