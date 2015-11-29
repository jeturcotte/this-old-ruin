use v6;

react {
    whenever IO::Socket::Async.listen('localhost',3333) -> $conn {
        say "connection established";
	my $bs = $conn.bytes-supply;
        $bs.tap(-> $buf { await $conn.write: $buf } );
        $bs.wait;
    }
}
