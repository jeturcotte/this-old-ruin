use v6;

# TODO -- Pull the following from config instead
our $port = 7041;
push our @commands, @*ARGS.perl || 'No command given';
say "commands given: {@commands}";
# TODO -- and/or accept command line arguments as override

await IO::Socket::Async.connect('localhost',$port).then( -> $p {
    if $p.status {
        given $p.result {
            .print(@commands);
            react {
                whenever .Supply() -> $v {
                    $v.say;
                    done;
                }
            }
            .close;
        }
    }
});
