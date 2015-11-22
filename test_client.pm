use v6;

await IO::Socket::Async.connect('localhost',3333).then( -> $p {
    if $p.status {
        given $p.result {
            .print('Hello, Perl 6');
            react {
                whenever .chars-supply() -> $v {
                    $v.say;
                    done;
                }
            }
            .close;
        }
    }
});
