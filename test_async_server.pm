use v6;

react {
    whenever IO::Socket::Async.listen('localhost',3333) -> $conn {
        my $bs = $conn.Supply(:bin);
        $bs.tap(-> $buf { await $conn.write: $buf } );
        $bs.wait;
        $conn.close;
    }
}
