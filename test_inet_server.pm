use v6;

my $listen = IO::Socket::INET.new(:listen, :localport(3333));
loop {
    my $conn = $listen.accept;
    while my $buf = $conn.recv(:bin) {
        $conn.write: $buf;
    }
    $conn.close;
}
